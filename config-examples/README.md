# Fields in example config files

## config-examples root
- `.tern-project`
  - `ecmaVersion`: Specify ECMAScript version
  - `libs`
    - `browser`: Native JavaScript
    - `jquery`
    - All is defined in [tern project def](https://github.com/ternjs/tern/tree/master/defs)
    - `ecma6`
    - `underscore`
    - more...
  - `loadEagerly`: Specify JavaScript files to load
  - `dontLoad`: Opposite to `loadEagerly`
  - `plugins`
    - `node`
    - `requirejs`
    - All is defined in [tern project plugin](https://github.com/ternjs/tern/tree/master/plugin) & [docs](http://ternjs.net/doc/manual.html#plugins)

## UltiSnips sub-directory
Put my custom snippets for my vim editor,
they will under `~/.vim/UltiSnips` and loaded by `honza/vim-snippets` plugin
