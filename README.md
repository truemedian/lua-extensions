
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

> #### table.copy(tbl)
>
> Returns a new table with a single layer of keys-values copied.
>
> | Name | Type  |
> |------|-------|
> | tbl  | table |
>
> **Returns: table**

-----

> #### table.deepcopy(tbl)
>
> Returns a new table with a all layers of keys-values copied. Tables are copied recursively.
>
> | Name | Type  |
> |------|-------|
> | tbl  | table |
>
> **Returns: table**

-----

> #### table.count(tbl)
>
> Returns the number of keys in the table.
>
> | Name | Type  |
> |------|-------|
> | tbl  | table |
>
> **Returns: number**

-----

> #### table.deepcount(tbl)
>
> Returns the number of keys in the table by recursively looking into tables.
>
> | Name | Type  |
> |------|-------|
> | tbl  | table |
>
> **Returns: number**

-----

> #### table.map(tbl, fn)
>
> Returns a new table with new key-value pairs sourced from the map function.
> The map function has a signature of: `fn(value, key) new_value[, new_key]`.
> If `new_key` is omitted, the key will remain the same.
>
> | Name |   Type   |
> |------|----------|
> | tbl  |  table   |
> |  fn  | function |
>
> **Returns: table**

-----

> #### table.filter(tbl, fn)
>
> Returns a new table with only key-value pairs that cause `fn` to return true.
> The filter function has a signature of: `fn(value, key) boolean`.
>
> | Name |   Type   |
> |------|----------|
> | tbl  |  table   |
> |  fn  | function |
>
> **Returns: table**

-----

> #### table.reverse(tbl)
>
> Reverses the contents of the array.
>
> | Name | Type  |
> |------|-------|
> | tbl  | table |
>
> **Returns: nil**

-----

> #### table.reversed(tbl)
>
> Returns a new array with the reversed contents of the original.
>
> | Name | Type  |
> |------|-------|
> | tbl  | table |
>
> **Returns: table**

-----

> #### table.shift(tbl, index, count)
>
> Shifts every index after `index` in the array to the right by `count`.
>
> | Name  |  Type  |
> |-------|--------|
> |  tbl  | table  |
> | index | number |
> | count | number |
>
> **Returns: nil**

-----

> #### table.slice(tbl, start, stop, step)
>
> Returns a slice of the table, works similarly to `string.sub` except on a table.
>
> |  Name  |  Type  |
> |--------|--------|
> |  tbl   | table  |
> | start? | number |
> | stop?  | number |
> | step?  | number |
>
> **Returns: table**

-----

> #### table.memcpy(dest, src, index)
>
> Works identically to `memcpy` in C. copies all of src into dest starting at index.
>
> | Name  |  Type  |
> |-------|--------|
> | dest  | table  |
> |  src  | table  |
> | index | number |
>
> **Returns: nil**

-----

> #### table.swapremove(tbl, i)
>
> Removes the value at the index from an array and replaces it with the item at the end of the array.
>
> | Name |  Type  |
> |------|--------|
> | tbl  | table  |
> |  i   | number |
>
> **Returns: any**

-----

> #### table.search(tbl, value)
>
> Looks for a specific value in a table and returns the key it was first found at.
>
> | Name  | Type  |
> |-------|-------|
> | tbl   | table |
> | value |  any  |
>
> **Returns: any?**

-----

> #### table.keys(tbl)
>
> Returns an array of keys available in the table.
>
> | Name | Type  |
> |------|-------|
> | tbl  | table |
>
> **Returns: table**

-----

> #### table.values(tbl)
>
> Returns an array of values available in the table.
>
> | Name | Type  |
> |------|-------|
> | tbl  | table |
>
> **Returns: table**

-----

> #### table.isempty(tbl)
>
> Returns whether or not the table is empty.
>
> | Name | Type  |
> |------|-------|
> | tbl  | table |
>
> **Returns: boolean**

-----

> #### table.randomipair(tbl)
>
> Returns a random key, value index from an array.
>
> | Name | Type  |
> |------|-------|
> | tbl  | table |
>
> **Returns: any, any**

-----

> #### table.randompair(tbl)
>
> Returns a random key, value index from a table.
>
> | Name | Type  |
> |------|-------|
> | tbl  | table |
>
> **Returns: any, any**
