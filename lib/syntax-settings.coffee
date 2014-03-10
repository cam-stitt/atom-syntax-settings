path = require 'path'
_ = require 'lodash'

module.exports =
  defaultSettings:
    languages: [
      name: 'python'
      extension: '.py'
      editorSettings:
        tabLength: 4
      editorViewSettings:
        showInvisibles: false
        softWrap: false
        showIndentGuide: false
    ]

  activate: (state) ->
    console.log "syntax-settings activated"
    that = this
    defaults = _.defaults atom.config.get('syntax-settings.languages'), @defaultSettings
    atom.workspaceView.eachEditorView (editorView) ->
      editor = editorView.getEditor()
      extension = path.extname(editor.getTitle())
      languageSettings = _.find defaults, {'extension': extension}
      if !languageSettings?
        console.log "Can't find language for " + extension
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
