# ec-luart-uivalidators

This project provides input validation ui objects for [LuaRT](https://www.luart.org/).
It has been designed to simplify and improve the creation of graphical user interfaces with the LuaRT ui module.

![example](/readme.png)

[![Lua 5.4.6](https://badgen.net/badge/Lua/5.4.6/yellow)](https://github.com/lua/lua)
[![LuaRT 1.7.0](https://badgen.net/badge/LuaRT/1.7.0/blue)](https://github.com/samyeyo/LuaRT)
[![LuaCheck 1.1.1](https://badgen.net/badge/LuaCheck/1.1.1/green)](https://github.com/lunarmodules/luacheck)

## Features

The module provides the following validation objects:

| Name | Description | Module |
| --- | --- | --- |
| ValidationLabel | Represents a text label for an input object and provides data validation support. A flag next to the caption shows unsuccessful validation. The error message is displayed in the tooltip. | uivalidators.lua
| ValidationText | Represents a text label for an input object and provides data validation support. The error message is displayed in the label. | uivalidators.lua
| ValidationIndicator | Represents a text label for an input object and provides data validation support. A flag in the label shows unsuccessful validation. The error message is displayed in the tooltip. | uivalidators.lua

More detailed descriptions and usage examples can be found in the docs folder.

## Installation

1. Create a folder called "ecluart" in your application.
2. Copy the "uivalidators.lua" file into this folder.

```text
[application]
|
|----ecluart
|   |
|   |----uivalidators.lua
|   |----...
|
|----app.wlua
```

## Usage

The validation module can be loaded using the function *require()*:

```lua
local uivalidators = require("ecluart.uivalidators") 
```

## License

Copyright (c) 2023 by esferatec.
It is open source, released under the MIT License.
See full copyright notice in the LICENSE.md file.
