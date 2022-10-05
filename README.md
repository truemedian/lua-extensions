
# Lua Extensions

> This library is intended for use in the [Luvit](https://luvit.io/) environment. However it may eventually be adapted
> for use elsewhere.

## Installation

```
lit install truemedian/extensions
```

## Documentation

https://pages.truemedian.me/lua-extensions/

## Usage

Each extension may be loaded separately, or all at the same time. Alternatively, the extensions may be accessed
individually without injecting them into your global environment.

### Injecting All Extensions

This loads all extensions into the global environment.

```lua
local extensions = require 'extensions' ()
```

### Using Individual Extensions

This accesses the `split` extension without ever modifying your global environment.

```lua
local extensions = require 'extensions'

local out = extensions.string.split("hello world", " ")
```
