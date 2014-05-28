# haxescript #

This is simple application to run your haxe as script. See [hscript](https://code.google.com/p/hscript/) haxe library for details.

### On *nix ###


```
#!bash

haxelib install haxescript
haxelib run haxescript --install

nano test.hs
>#!/usr/bin/haxescript
>Lib.println("hello world!");

chmod +ax test.hs
./test.hs

```

### On Windows ###

```
#!cmd

haxelib install haxescript
```
Now manually copy haxescript.cmd to folder in PATH.

Run notepad and create file "test.hs":

```
#!haxe

Lib.println("hello world!");
```

Now you can run your script:

```
#!cmd

haxescript test.hs
```

### Supported classes ###

 * Lib
 * Math
 * Sys
 * FileSystem
 * File
 * StringTools
 * Lambda
 * Process - see [hant](https://code.google.com/p/hant/) library
 * CmdOptions - see [hant](https://code.google.com/p/hant/) library