assert = require 'assert'
fs = require 'fs'

gutil = require 'gulp-util'
File = gutil.File

json2cson = require '../'

describe 'JSON to CSON', () ->
  it 'should parse JSON to CSON', (done) ->
    myParser = json2cson()

    fakeFile = new File {
      cwd: '.'
      base: 'test/source'
      path: 'test/source/success.json'
      contents: fs.readFileSync 'test/sources/success.json'
    }

    myParser.once 'data', (file) ->
      assert.notEqual file.contents, null
      assert.equal file.contents.toString(), fs.readFileSync('test/expected/success.cson').toString().replace(/\r\n/g, '\n') # Fixed Windows newline issue.
      done()
      return

    myParser.write fakeFile
    return

  it 'should parse JSON to CSON with tab indentation', (done) ->
    myParser = json2cson('\t')

    fakeFile = new File {
      cwd: '.'
      base: 'test/source'
      path: 'test/source/success.json'
      contents: fs.readFileSync 'test/sources/success.json'
    }

    myParser.once 'data', (file) ->
      assert.notEqual file.contents, null
      assert.equal file.contents.toString(), fs.readFileSync('test/expected/success-tab.cson').toString().replace(/\r\n/g, '\n') # Fixed Windows newline issue.
      done()
      return

    myParser.write fakeFile
    return

  it 'should return error when cannot parse file', (done) ->
    myParser = json2cson()

    fakeFile = new File {
      cwd: '.'
      base: 'test/source'
      path: 'test/source/error.json'
      contents: fs.readFileSync 'test/sources/error.json'
    }

    myParser.once 'error', (err) ->
      assert.notEqual err, null
      assert.equal err.name, 'SyntaxError'
      done()
      return

    myParser.write fakeFile
    return
  return
