
# Lua Extensions

> This library is intended for use in the [Luvit](https://luvit.io/) environment. However it may eventually be adapted
> for use elsewhere.

## Usage

Each extension may be loaded separately, or all at the same time. Alternatively, the extensions may be accessed
individually without injecting them into your global environment.

### Injecting All Extensions

This loads all extensions into the global environment.

```lua
local extensions = require('extensions')()
```

### Injecting A Single Library Extension

This loads only the string library extensions into the global environment.

```lua
local extensions = require('extensions')

extensions.string() -- this loads just the string library extensions.
```

### Using Individual Extensions

This accesses the `split` extension without ever modifying your global environment.

```lua
local extensions = require('extensions')

local out = extensions.string.split("hello world", " ")
```

## Extensions

### Math

> #### math.nan
>
> A value that is never equal to itself, use `isnan` if you want to check for this value.

-----

> #### math.clamp(num, minValue, maxValue)
>
> Returns `num` clamped to [minValue, maxValue].
>
> |   Name   |  Type  |
> |----------|--------|
> |   num    | number |
> | minValue | number |
> | maxValue | number |
>
> **Returns: number**

-----

> #### math.round(num, precision)
>
> Returns `num` rounded normally to `precision` decimals of precision.
>
> |   Name    |  Type   |
> |-----------|---------|
> |   num     | number  |
> | precision | number? |
>
> **Returns: number**

-----

> #### math.sign(n)
>
> Returns -1 for a negative number, 1 for a positive number and 0 for 0.
>
> | Name |  Type  |
> |------|--------|
> |  n   | number |
>
> **Returns: number**

-----

> #### math.cbrt(n)
>
> Returns the cube root of `n`.
>
> | Name |  Type  |
> |------|--------|
> |  n   | number |
>
> **Returns: number**

-----

> #### math.root(n, base)
>
> Returns the `base`th root of `n`.
>
> | Name |  Type  |
> |------|--------|
> |  n   | number |
> | base | number |
>
> **Returns: number**

-----

> #### math.isnan(n)
>
> Returns true if `n` is nan.
>
> | Name |  Type  |
> |------|--------|
> |  n   | number |
>
> **Returns: number**

### String

> #### string.endswith(str, pattern, plain)
>
> Returns whether or not the string ends with `pattern`. Use `plain` if you want to match `pattern` literally.
>
> |  Name   |  Type   |
> |---------|---------|
> |   str   | string  |
> | pattern | string  |
> | plain?  | boolean |
>
> **Returns: boolean**

-----

> #### string.startswith(str, pattern, plain)
>
> Returns whether or not the string starts with `pattern`. Use `plain` if you want to match `pattern` literally.
>
> |  Name   |  Type   |
> |---------|---------|
> |   str   | string  |
> | pattern | string  |
> | plain?  | boolean |
>
> **Returns: boolean**

-----

> #### string.patternescape(str)
>
> Returns a new string with all Lua Pattern special characters escaped.
>
> | Name |  Type   |
> |------|---------|
> | str  | string  |
>
> **Returns: string**

-----

> #### string.trim(str)
>
> Returns a new string with all leading and trailing whitespace removed.
>
> | Name |  Type   |
> |------|---------|
> | str  | string  |
>
> **Returns: string**

-----

> #### string.padright(str, final_len, pattern)
>
> Returns a new string with the left padded with `pattern` or spaces until the string is `final_len` characters long.
>
> |   Name    |  Type  |
> |-----------|--------|
> |    str    | string |
> | final_len | number |
> | pattern?  | string |
>
> **Returns: string**

-----

> #### string.padcenter(str, final_len, pattern)
>
> Returns a new string with both sides padded with `pattern` or spaces until the string is `final_len` characters long.
>
> |   Name    |  Type  |
> |-----------|--------|
> |    str    | string |
> | final_len | number |
> | pattern?  | string |
>
> **Returns: string**

-----

> #### string.padleft(str, final_len, pattern)
>
> Returns a new string with the right padded with `pattern` or spaces until the string is `final_len` characters long.
>
> |   Name    |  Type  |
> |-----------|--------|
> |    str    | string |
> | final_len | number |
> | pattern?  | string |
>
> **Returns: string**

-----

> #### string.pad(str, final_len, align, pattern)
>
> Returns a new string with the left padded with `pattern` or spaces until the string is `final_len` characters long.
>
> Alignment should be one of "left", "right", "center", (defaults to "left" on invalid values).
>
> |   Name    |  Type  |
> |-----------|--------|
> |    str    | string |
> | final_len | number |
> |   align   | string |
> | pattern?  | string |
>
> **Returns: string**

-----

> #### string.split(str, delim, plain)
>
> Returns a table of all elements of the string split on `delim`. Use `plain` if the delimiter provided is not a pattern.
>
> |  Name  |  Type  |
> |--------|--------|
> |  str   | string |
> | delim? | number |
> | plain? | string |
>
> **Returns: table**

-----

> #### string.random(final_len, mn, mx)
>
> Returns a string of `final_len` random characters in the byte-range of `[mn, mx]`. By default `mn = 0` and `mx = 255`.
>
> |   Name    |  Type  |
> |-----------|--------|
> | final_len | number |
> |    mn?    | number |
> |    mx?    | number |
>
> **Returns: string**

-----

> #### string.levenshtein(str1, str2)
>
> Returns the Levenshtein distance between the two strings. This is often referred as "edit distance".
> see [Levenshtein Distance](https://en.wikipedia.org/wiki/Levenshtein_distance).
>
> | Name |  Type  |
> |------|--------|
> | str1 | string |
> | str2 | string |
>
> **Returns: number**

-----

> #### string.dameraulevenshtein(str1, str2)
>
> Returns the Damerau-Levenshtein distance between the two strings. This is often referred as "edit distance".
> see [Damerau-Levenshtein Distance](https://en.wikipedia.org/wiki/Damerau%E2%80%93Levenshtein_distance).
>
> | Name |  Type  |
> |------|--------|
> | str1 | string |
> | str2 | string |
>
> **Returns: number**

-----

> #### string.subsequencematch(subseq, str)
>
> Returns true if the subsequence can be found inside `str`.
> For example: `ggl` is a subsequence of `GooGLe`. (uppercase letters signify which letters form the subsequence)
>
> |  Name  |  Type  |
> |--------|--------|
> | subseq | string |
> |  str   | string |
>
> **Returns: boolean**

-----

> #### string.title(str)
>
> Returns a copy of this string with the first and every letter after a word boundary uppercased, and everything else lowercase
>
> | Name |  Type  |
> |------|--------|
> | str  | string |
>
> **Returns: boolean**

### Table

Todo: Document
