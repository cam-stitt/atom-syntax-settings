{WorkspaceView} = require 'atom'
_ = require 'lodash'

describe "syntax settings", ->
  [pythonGrammar, editor, editorView] = []

  beforeEach ->
    atom.workspaceView = new WorkspaceView

    waitsForPromise ->
      atom.packages.activatePackage('language-python')

    waitsForPromise ->
      atom.packages.activatePackage('syntax-settings')

    runs ->
      atom.workspaceView.openSync('sample.py')
      editorView = atom.workspaceView.getActiveView()
      editor = editorView.getEditor()

      pythonGrammar = atom.syntax.grammarForScopeName "source.python"
      expect(pythonGrammar).toBeTruthy()

  describe "when source.python is the grammar", ->
    it "has the right settings", ->
      expect(editor.getGrammar()).toBe pythonGrammar
      editorView.trigger "syntax-settings:reload"
      expect(editor.getTabLength()).toBe 4
