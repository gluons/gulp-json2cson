assert = require 'assert'
fs = require 'fs'
gutil = require 'gulp-util'

{ File } = gutil
{ readFileSync } = fs

json2cson = require '../dist/main.js'

normalizeNewline = (text) -> text.replace(/\r\n/g, '\n') # Fixed Windows newline issue.

describe 'JSON to CSON', () ->
  it 'should parse JSON to CSON', (done) ->
    myParser = json2cson()

    fakeFile = new File {
      cwd: '.'
      base: 'test/source'
      path: 'test/source/success.json'
      contents: readFileSync 'test/sources/success.json'
    }

    myParser.once 'data', (file) ->
      try
        assert.notEqual file.contents, null
        assert.equal file.contents.toString(), normalizeNewline(readFileSync('test/expected/success.cson').toString())
        done()
      catch err
        done(err)
      return

    myParser.write fakeFile
    return

  it 'should parse JSON to CSON with tab indentation', (done) ->
    myParser = json2cson('\t')

    fakeFile = new File {
      cwd: '.'
      base: 'test/source'
      path: 'test/source/success.json'
      contents: readFileSync 'test/sources/success.json'
    }

    myParser.once 'data', (file) ->
      try
        assert.notEqual file.contents, null
        assert.equal file.contents.toString(), normalizeNewline(readFileSync('test/expected/success-tab.cson').toString())
        done()
      catch err
        done(err)
      return

    myParser.write fakeFile
    return

  it 'should return error when cannot parse file', (done) ->
    myParser = json2cson()

    fakeFile = new File {
      cwd: '.'
      base: 'test/source'
      path: 'test/source/error.json'
      contents: readFileSync 'test/sources/error.json'
    }

    myParser.once 'error', (err) ->
      try
        assert.notEqual err, null
        assert.equal err.name, 'SyntaxError'
        done()
      catch err
        done(err)
      return

    myParser.write fakeFile
    return
  return
