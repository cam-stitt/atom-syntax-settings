# syntax-settings package

Syntax specific settings there in your config.

This is very much a work in progress, expect bugs.

Just add the following to your `config.cson`:

```
'syntax-settings':
  'languages': [
  ]
```

You can then begin adding languages underneath the grammar scopeName. Below is an example of what is available:

```
{
  'source.python':
    'editorSettings':
      'tabLength': 4
    'editorViewSettings':
      'showInvisibles': false
      'softWrap': false
      'showIndentGuide': false
}
```

Any of the methods in [Editor](https://atom.io/docs/api/v0.69.0/api/) or [EditorView](https://atom.io/docs/api/v0.69.0/api/) that start with 'set' are valid settings.
