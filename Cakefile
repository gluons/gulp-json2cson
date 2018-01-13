chalk = require 'chalk'
CoffeeScript = require 'coffeescript'
del = require 'del'
fs = require 'fs'
globby = require 'globby'
makeDir = require 'make-dir'
path = require 'path'
replaceExt = require 'replace-ext'

{ green } = chalk
{ join, basename } = path
{ log } = console

task 'build', 'Build all source files', () ->
  invoke 'clean' # Clean before build

  makeDir.sync('dist')
  files = await globby 'src/*.coffee'
  files.forEach (file) ->
    baseFile = basename file
    resultFile = join('dist', replaceExt(baseFile, '.js'))
    sourceMapFile = join('dist', replaceExt(baseFile, '.js.map'))
    result = CoffeeScript.compile(fs.readFileSync(file, 'utf8'), {
      sourceMap: true,
      bare: true
    })
    fs.writeFileSync resultFile, result.js
    fs.writeFileSync sourceMapFile, result.v3SourceMap
    log green 'Build complete.'

task 'clean', 'Clean all built files', () ->
  del.sync ['dist/*']
  log green 'Cleaned.'
