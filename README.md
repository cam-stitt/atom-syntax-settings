# syntax-settings package

Syntax specific settings there in your config.

## Installation

```
apm install syntax-settings
```

## Usage

You can easily add languages according to the grammar scopeName. Below is an example of modifying the python settings:

```
'syntax-settings':
  'source.python':
    'editorSettings':
      'tabLength': 4
    'editorViewSettings':
      'showInvisibles': false
      'softWrap': false
      'showIndentGuide': false
```

## Supported Settings

Any of the methods in [Editor](https://atom.io/docs/api/v0.69.0/api/) or [EditorView](https://atom.io/docs/api/v0.69.0/api/) that start with 'set' are valid settings.
