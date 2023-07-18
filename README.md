# ec-luart-uivalidators

This project provides input validation ui objects for [LuaRT](https://www.luart.org/).
It has been designed to simplify and improve the creation of graphical user interfaces with the LuaRT ui module.

*In the "Registration Form" example below, the ValidationLabel and ValidationSummary are used to validate user input.*

![Screenshot of the Regisatrtion Form](/readme.png)

[![Lua 5.4](https://badgen.net/badge/Lua/5.4/yellow)](https://github.com/lua/lua)
[![LuaRT 5.4](https://badgen.net/badge/LuaRT/1.4.0/blue)](https://github.com/samyeyo/LuaRT)
[![LuaCheck 1.1.1](https://badgen.net/badge/LuaCheck/1.1.1/green)](https://github.com/lunarmodules/luacheck)

## Features

All objects provide both functional and visual support for input validation.
The module provides the following validation objects:

| Name | Description | Module |
| --- | --- | --- |
| ValidationLabel | Represents a text label for an input object and provides data validation support. A flag next to the caption shows unsuccessful validation. The error message is displayed in the tooltip. | uivalidators.lua
| ValidationText | Represents a text label for an input object and provides data validation support. The error message is displayed in the label. | uivalidators.lua
| ValidationIndicator | Represents a text label for an input object and provides data validation support. A flag in the label shows unsuccessful validation. The error message is displayed in the tooltip. | uivalidators.lua
| ValidationSummary | Displays a summary of all validation errors in a text label. The ValidationSummary works with all of the validation objects together. | uivalidators.lua

More detailed descriptions and usage examples for each of these validation objects can be found in the docs folder.

## Installation

1. Create a folder called "ecluart" in your application.
2. Copy the "uivalidators.lua" file into this folder.

```text
[programm]
|
|----ecluart
|   |
|   |----uivalidators.lua
|   |----...
|
|----app.wlua
```

## Usage

The validator objects can be loaded using the function *require()*:

```lua
local va = require("eclua.uivalidators") 
```

## License

Copyright (c) 2023 by esferatec.
It is open source, released under the MIT License.
See full copyright notice in the LICENSE.md file.
