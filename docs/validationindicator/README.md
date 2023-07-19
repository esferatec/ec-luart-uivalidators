# ValidationIndicator

Represents a text label for an input object and provides data validation support.
A flag in the label shows unsuccessful validation.
The error message is displayed in the tooltip.

![validationindicator](/docs/validationindicator/validationindicator01.png)

**Note:**
This documentation describes only the additional properties and methods.
The standard properties, methods and events can be found in the [LuaRT Label](https://www.luart.org/doc/ui/Label.html) documentation.

## Constructor

Initializes a new validation indicator instance.

```Lua
ValidationIndicator(parent, widget, [x], [y], [width], [height])
```

Parameter | Type | Description
---|---|---
widget | object | Sets the input object to validate.

## Property - SHOWALLERRORS

Shows either all error messages or only the last one.

```Lua
ValidationIndicator.showallerrors (boolean)
```

![validationindicator](/docs/validationindicator/validationindicator02.png)
![validationindicator](/docs/validationindicator/validationindicator03.png)

## Property - SEPARATOR

Specifies the text between two or more error messages. The default separator is: SEPARATOR.space

```Lua
ValidationIndicator.separator (string)
```

![validationindicator](/docs/validationindicator/validationindicator05.png)

## Constant - SEPARATOR

Field | Value
---|:---:
none |
newline | "\n"
space | " "
semicolon | "; "
comma | ", "

**Note:**
Newline does not work with tooltip.

## Property - FLAG

Defines the indicator when validation is unsuccessful. The default indicator is: FLAG.exclamationmark.

```Lua
ValidationIndicator.flag (string)
```

![validationindicator](/docs/validationindicator/validationindicator04.png)

## Constant - FLAG

Field | Value
---|:---:
none |
exclamationmark | "(!)"
questionmark | "(?)"

## Property - ERRORBGCOLOR

Defines the background color when validation is unsuccessful.

```Lua
ValidationIndicator.errorbgcolor (number)
```

![validationindicator](/docs/validationindicator/validationindicator06.png)

## Property - ERRORFGCOLOR

Defines the foreground color when validation is unsuccessful.

```Lua
ValidationIndicator.errorfgcolor (number)
```

![validationindicator](/docs/validationindicator/validationindicator06.png)

## Property - ISVALID

Gets a value indicating whether validation succeeded.

```Lua
ValidationIndicator.isvalid (boolean)
```

## Property - COUNT

Gets the amount of errors.

```Lua
ValidationIndicator.count (number)
```

## Property - MESSAGE

Gets the error message.

```Lua
ValidationIndicator.message (string)
```

## Method - ADD

Adds a new validation rule and message.

```Lua
ValidationIndicator:add(rule, message)
```

Parameter | Type | Description
---|---|---
rule | function | Sets the validation function. The function must return false if the validation fails.
message | string | Sets the error message.

## Method - VALIDATE

Performs validation on the associated input object. The method returns true if the validation was successful, otherwise it returns false.

```Lua
ValidationIndicator:validate()
```

## Example

```Lua
local ui = require("ui")
local va = require("ecluart.uivalidators")

local function isrequired(value)
  return string.len(value) > 0
end

local function isnumber(value)
  return math.type(math.tointeger(value)) == "integer"
end

local win = ui.Window("ValidationIndicator", "fixed", 300, 250)

local lblAge = ui.Label(win, "Age:", 10, 29)
local etyAge = ui.Entry(win, "", 45, 24, 40)
local valAge = va.ValidationIndicator(win, etyAge, 90, 29)
local btnValidate = ui.Button(win, "Validate", 10, 100, 300)

valAge:add(isrequired, "Age is required.")
valAge:add(isnumber, "Age must be a number.")

function btnValidate:onClick()
  valAge:validate()
end

win:show()

repeat
    ui.update()
until not win.visible
```

![validationindicator](/docs/validationindicator/validationindicator01.png)
