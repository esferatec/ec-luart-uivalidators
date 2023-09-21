# ValidationSummary

Displays a summary of all validation errors in a text label.
The ValidationSummary works with all of the validation objects together.

![validationsummary](/docs/validationsummary/validationsummary01.png)

**Note:**
This documentation describes only the additional properties and methods.
The standard properties, methods and events can be found in the [LuaRT Label](https://www.luart.org/doc/ui/Label.html) documentation.

## Constructor

Initializes a new validation summary instance.

```Lua
ValidationSummary(parent, [x], [y], [width], [height])
```

## Property - SEPARATOR

Specifies the text between two or more error messages. The default separator is: SEPARATOR.newline

```Lua
ValidationSummary.separator(string)
```

![validationsummary](/docs/validationsummary/validationsummary02.png)

## Constant - SEPARATOR

Field | Value
---|:---:
none |
newline | "\n"
space | " "
semicolon | "; "
comma | ", "

## Property - ISVALID

Gets a value indicating whether all  validation succeeded.

```Lua
ValidationSummary.isvalid(boolean)
```

## Property - COUNT

Gets the amount of all errors.

```Lua
ValidationSummary.count(number)
```

## Property - MESSAGE

Gets all error message.

```Lua
ValidationSummary.message(string)
```

## Method - ADD

Adds a new validation object.

```Lua
ValidationSummary:add(widget)
```

Parameter | Type | Description
---|---|---
widget | object | Adds a ValidationLabel, ValidationText or ValidationIndicator to the ValidationSummary.

## Method - VALIDATE

Performs validation of all validation labels.

```Lua
ValidationSummary:validate()
```

## Method - UPDATE

Updates the validation summary label text.

```Lua
ValidationSummary:update()
```

## Example

```Lua
local ui = require("ui")
local uiva = require("ecluart.uivalidators")

local function isrequired(value)
  return string.len(value) > 0
end

local function isnumber(value)
  return math.type(math.tointeger(value)) == "integer"
end

local win = ui.Window("ValidationSummary", "fixed", 300, 250)

local etyName = ui.Entry(win, "", 100, 24, 110)
local valName = uiva.ValidationLabel(win, etyName, "Name:", 10, 29)
local etyAge = ui.Entry(win, "", 100, 54, 40)
local valAge = uiva.ValidationLabel(win, etyAge, "Age:", 10, 59)
local btnValidate = ui.Button(win, "Validate", 10, 100, 280)
local valSummary = uiva.ValidationSummary(win, 10, 140, 280, 90)

valName:add(isrequired, "Name is required.")
valAge:add(isrequired, "Age is required.")
valAge:add(isnumber, "Age must be a number.")

valSummary:add(valName)
valSummary:add(valAge)

function btnValidate:onClick()
  valSummary:validate()
  valSummary:update()
end

win:show()

repeat
    ui.update()
until not win.visible
```

![validationsummary](/docs/validationsummary/validationsummary01.png)
