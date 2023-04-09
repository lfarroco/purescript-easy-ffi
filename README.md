# purescript-small-ffi

This repo is a fork of [pelotom/purescript-easy-ffi](https://github.com/pelotom/purescript-easy-ffi), which stopped publishing releases for updated Purescript versions.

## Disclaimer

Using this tool might not be a good idea. By using it you are not letting browser and compiler optimizations
take place, as it evaluates literal strings at runtime to run code.
While good for prototyping and experimentation, when your code matures treat this as tech debt and replace it
with proper boring FFI bindings for better performance.

---

Most foreign imports in PureScript follow a familiar pattern:

```purescript
-- In Module.purs
foreign import foo :: Number -> Number -> Number -> Number
```

```javascript
// In Module.js
export function foo (x) {
  return function (y) {
    return function (z) {
      return (x + y) * z; // <- the actually interesting part!
    };
  };
};
```

With small-ffi you can scrap all that boilerplate and write the above as:

```purescript
foo :: Number -> Number -> Number -> Number
foo = unsafeForeignFunction ["x", "y", "z"] "(x + y) * z"
```

We can also define foreign functions returning monadic actions, by including an empty argument, e.g.

```purescript
log :: String -> Effect Unit
log = unsafeForeignProcedure ["string", ""] "console.log(string);" -- note the extra ""
```

which is equivalent to this:

```purescript
foreign import log :: String -> Effect Unit
```

```javascript
export function log (string) {
  return function () {
    console.log(string);
  };
};
```

The only difference between `unsafeForeignFunction` and `unsafeForeignProcedure` is that the former takes an expression as its second argument, and the latter a statement.
