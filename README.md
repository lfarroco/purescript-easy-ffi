# purescript-small-ffi

This repo is a fork of [pelotom/purescript-easy-ffi](https://github.com/pelotom/purescript-easy-ffi), which stopped publishing releases for updated Purescript versions.

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

```haskell
foo :: Number -> Number -> Number -> Number
foo = unsafeForeignFunction ["x", "y", "z"] "(x + y) * z"
```

We can also define foreign functions returning monadic actions, by including an empty argument, e.g.

```haskell
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
