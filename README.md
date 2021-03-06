# Update
This functionality is now in core, I'll no longer be supplying support syntax-settings. See [here](https://discuss.atom.io/t/different-tab-size-depending-on-language/1523/28?u=cam_stitt) for details.
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
      'gutterViewSettings':
        'showLineNumbers': true
```

To find out which grammar you are using, open Developer Settings (`View => Developer => Toggle Developer Tools`) and run:

```
atom.workspace.getActiveEditor().getGrammar().scopeName
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

### gutterViewSettings
- showLineNumbers

## Todo

* Read through atom source to find more views/settings that are worth implementing
