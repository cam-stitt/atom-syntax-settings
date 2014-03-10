_ = require 'lodash'

module.exports =
  configDefaults:
    "source.python":
      editorSettings:
        tabLength: 4
      editorViewSettings:
        showInvisibles: false
        softWrap: false
        showIndentGuide: false

  activate: (state) ->
    console.log "syntax-settings activated"
    that = this
    defaults = _.defaults atom.config.get('syntax-settings'), @overrides
    atom.workspaceView.eachEditorView (editorView) ->
      editor = editorView.getEditor()
      grammar = editor.getGrammar()

      languageSettings = _.find defaults, grammar.scopeName
      if !languageSettings?
        console.log "Can't find language for " + grammar.scopeName
      else
        that._set_syntax_settings(editorView, editor, languageSettings)

  _set_syntax_settings: (editorView, editor, languageSettings) ->
    editorSettings = languageSettings['editorSettings']
    # Editor settings
    for key, value of editorSettings
      attributeName = 'set' + key
      if editor[attributeName]
        editor[attributeName](value)

    editorViewSettings = languageSettings['editorViewSettings']
    # EditorView Settings
    for key, value of editorViewSettings
      attributeName = 'set' + key
      if editorView[attributeName]
        editorView[attributeName](value)
