CSON = require 'cson'
PluginError = require 'plugin-error'
replaceExt = require 'replace-ext'
through = require 'through2'

PLUGIN_NAME = 'gulp-json2cson'

module.exports = (indent = '  ') ->
  through.obj (file, encoding, callback) ->
    if (not file?) or file.isNull()
      callback null, file
    else if file.isStream()
      callback new PluginError(PLUGIN_NAME, 'Streams not supported!')
    else
      try
        json = JSON.parse file.contents.toString()
        file.contents = Buffer.from CSON.stringify json, null, indent
        file.path = replaceExt file.path, '.cson'

        callback null, file
      catch error
        callback new PluginError(PLUGIN_NAME, error)
    return
