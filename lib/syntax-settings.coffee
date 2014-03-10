path = require 'path'
_ = require 'lodash'

module.exports =
  defaultSettings:
    languages: [
      name: 'python'
      extension: '.py'
      settings:
        tabLength: 4
        showInvisibles: false
        softWrap: false
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
    settings = languageSettings['settings']
    # Editor settings
    editor.setTabLength(settings['tabLength'])

    # EditorView Settings
    editorView.setSoftWrap(settings['softWrap'])
    editorView.setShowInvisibles(settings['showInvisibles'])
