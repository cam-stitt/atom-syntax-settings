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
    editorSettings = languageSettings['editorSettings']
    # Editor settings
    for key, value of editorSettings
      attributeName = @_formatAttribute(key)
      if editor[attributeName]
        editor[attributeName](value)

    editorViewSettings = languageSettings['editorViewSettings']
    # EditorView Settings
    for key, value of editorViewSettings
      attributeName = @_formatAttribute(key)
      if editorView[attributeName]
        editorView[attributeName](value)

  _formatAttribute: (key) ->
    return 'set' + key.charAt(0).toUpperCase() + key.slice(1);
