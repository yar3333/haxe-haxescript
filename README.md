# haxescript #

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

// now manually copy haxescript.cmd to folder in PATH

// run notepad and create file "test.hs":

```
#!haxe

Lib.println("hello world!")
```
;


```
#!cmd

haxescript test.hs
```
