_ = require 'lodash'

module.exports =
  configDefaults:
    source:
      python:
        editorSettings:
          tabLength: 4
        editorViewSettings:
          showInvisibles: false
          softWrap: false
          showIndentGuide: false
      go:
        editorSettings:
          tabLength: 4
          softTabs: false

  settingsAllowed: {
    'editorSettings': [
      'softTabs', 'softWrap', 'tabLength'
    ]
    'editorViewSettings': [
      'fontFamily', 'fontSize', 'invisibles', 'placeholderText',
      'showIndentGuide', 'showInvisibles', 'softWrap'
    ]
  }

  activate: (state) ->
    console.log "syntax-settings activated"
    atom.workspaceView.command "syntax-settings:reload", => @loadSettings()
    @loadSettings()

  loadSettings: ->
    @defaults = _.merge {}, @defaultOverrides, atom.config.get('syntax-settings')
    atom.workspaceView.eachEditorView _.bind(@_loadSettingsForEditorView, @)

  _loadSettingsForEditorView: (editorView) ->
    editor = editorView.getEditor()
    grammar = editor.getGrammar()

    languageSettings = @_extractGrammarSettings(@defaults, grammar)
    if !languageSettings?
      console.log "Can't find language for " + grammar.scopeName
    else
      console.log "Loading settings for " + grammar.scopeName
      @_setSyntaxSettings(editorView, editor, languageSettings)

  _extractGrammarSettings: (settings, grammar) ->
    path = grammar.scopeName.split('.')
    value = settings
    for p in path
      if !value?
        break
      value = value[p]
    return value

  _setSyntaxSettings: (editorView, editor, languageSettings) ->
    _setSettings(editor, languageSettings, 'editorSettings')
    _setSettings(editorView, languageSettings, 'editorViewSettings')

  _loopAndSetSettings: (object, settings, name) ->
    objectSettings = settings[name]
    # EditorView Settings
    for key, value of objectSettings
      if !_.contains @settingsAllowed[name], key
        console.log key + " is not valid for " + name
      attributeName = @_formatAttribute(key)
      if object[attributeName]
        object[attributeName](value)
        continue

  _formatAttribute: (key) ->
    return 'set' + key.charAt(0).toUpperCase() + key.slice(1);
