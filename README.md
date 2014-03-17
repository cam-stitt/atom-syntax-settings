# syntax-settings package

Syntax specific settings there in your config.

## Installation

```
apm install syntax-settings
```

## Usage

You can easily add languages according to the grammar scopeName. Below is an example of modifying the python (`source.python`) settings:

```
'syntax-settings':
  'source':
    'python':
      'editorSettings':
        'tabLength': 4
      'editorViewSettings':
        'showInvisibles': false
        'softWrap': false
        'showIndentGuide': false
```

## Supported Settings

Below is a list of supported settings:

### editorSettings
- softTabs
- softWrap
- tabLength

### editorViewSettings
- fontFamily
- fontSize
- invisibles
- placeholderText
- showIndentGuide
- showInvisibles
- softWrap
