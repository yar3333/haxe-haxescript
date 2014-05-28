rm examples.zip
7z a -tzip examples.zip ..\examples
7z a -tzip library.zip * -xr!make.cmd -xr!library.zip
