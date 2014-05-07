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
    'gutterViewSettings': [
      'showLineNumbers'
    ]
  }

  buffers: []

  activate: (state) ->
    atom.workspaceView.command "syntax-settings:reload", => @reloadSettings()
    @loadSettings()

  reloadSettings: ->
    @buffers = []
    @loadSettings()

  loadSettings: ->
    @defaults = _.merge {}, @defaultOverrides, atom.config.get('syntax-settings')
    atom.workspaceView.eachEditorView _.bind(@_loadSettingsForEditorView, @)

  _loadSettingsForEditorView: (editorView) ->
    editor = editorView.getEditor()
    grammar = editor.getGrammar()

    if !_.contains @buffers, editor.buffer
      @buffers.push editor.buffer
      editor.buffer.on 'saved', _.bind( ->
        @_loadSettingsForEditorView(editorView)
      , @)
      editor.buffer.on 'destroyed', ->
        editor.buffer.off()

    languageSettings = @_extractGrammarSettings(@defaults, grammar)
    if languageSettings
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
    @_loopAndSetSettings(editor, languageSettings, 'editorSettings')
    @_loopAndSetSettings(editorView, languageSettings, 'editorViewSettings')
    @_loopAndSetSettings(editorView.gutter, languageSettings, 'gutterViewSettings')

  _loopAndSetSettings: (object, settings, name) ->
    objectSettings = settings[name]

    for key, value of objectSettings
      if !_.contains @settingsAllowed[name], key
        continue
      attributeName = @_formatAttribute(key)
      if object[attributeName]
        object[attributeName](value)

  _formatAttribute: (key) ->
    return 'set' + key.charAt(0).toUpperCase() + key.slice(1);
