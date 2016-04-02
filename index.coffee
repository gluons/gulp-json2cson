gutil = require 'gulp-util'
through = require 'through2'
CSON = require 'cson'

PluginError = gutil.PluginError

PLUGIN_NAME = 'gulp-json2cson'

module.exports = (indent = '  ') ->
  through.obj (file, encoding, callback) ->
    if file.isNull()
      callback null, file

    if file.isStream()
      callback new PluginError(PLUGIN_NAME, 'Streams not supported!')

    try
      json = JSON.parse file.contents.toString()
      file.contents = new Buffer CSON.stringify json, null, indent
      file.path = gutil.replaceExtension file.path, '.cson'

      callback null, file
    catch error
      callback new PluginError(PLUGIN_NAME, error)
    return
