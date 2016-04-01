gutil = require 'gulp-util'
through = require 'through2'
CSON = require 'cson'

PluginError = gutil.PluginError

PLUGIN_NAME = 'gulp-json2cson'

module.exports = (replacer = null, indent = '  ') ->
  through.obj (file, encoding, callback) ->
    if file.isNull()
      callback null, file

    if file.isStream()
      callback new PluginError(PLUGIN_NAME, 'Streams not supported!')

    json = JSON.parse file.contents.toString()
    file.contents = new Buffer CSON.stringify json, replacer, indent
    file.path = gutil.replaceExtension file.path, '.cson'

    callback null, file

    return
