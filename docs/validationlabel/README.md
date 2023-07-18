# ValidationLabel

Represents a text label for an input object and provides data validation support.
A flag next to the caption shows unsuccessful validation.
The error message is displayed in the tooltip.

![validationlabel](/docs/validationlabel/validationlabel01.png)

**Note:**
This documentation describes only the additional properties and methods.
The standard properties, methods and events can be found in the [LuaRT Label](https://www.luart.org/doc/ui/Label.html) documentation.

## Constructor

Initializes a new validation label instance.

```Lua
ValidationLabel(parent, widget, caption, [x], [y], [width], [height])
```

Parameter | Type | Description
---|---|---
widget | object | Sets the input object to validate.

## Property - SHOWALLERRORS

Shows either all error messages or only the last one.

```Lua
ValidationLabel.showallerrors (boolean)
```

![validationlabel](/docs/validationlabel/validationlabel02.png)
![validationlabel](/docs/validationlabel/validationlabel03.png)

## Property - SEPARATOR

Specifies the text between two or more error messages. The default separator is: SEPARATOR.space

```Lua
ValidationLabel.separator (string)
```

![validationlabel](/docs/validationlabel/validationlabel05.png)

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
ValidationLabel.flag (string)
```

![validationlabel](/docs/validationlabel/validationlabel04.png)

## Constant - FLAG

Field | Value
---|:---:
none |
exclamationmark | "(!)"
questionmark | "(?)"

## Property - ERRORBGCOLOR

Defines the background color when validation is unsuccessful.

```Lua
ValidationLabel.errorbgcolor (number)
```

![validationlabel](/docs/validationlabel/validationlabel06.png)

## Property - ERRORFGCOLOR

Defines the foreground color when validation is unsuccessful.

```Lua
ValidationLabel.errorfgcolor (number)
```

![validationlabel](/docs/validationlabel/validationlabel06.png)

## Property - isvalid

Gets a value indicating whether validation succeeded.

```Lua
ValidationLabel.isvalid (boolean)
```

## Property - count

Gets the amount of errors.

```Lua
ValidationLabel.count (number)
```

## Property - message

Gets the error message.

```Lua
ValidationLabel.message (string)
```

## Method - ADD

Adds a new validation rule and message.

```Lua
ValidationLabel:add(rule, message)
```

Parameter | Type | Description
---|---|---
rule | function | Sets the validation function. The function must return false if the validation fails.
message | string | Sets the error message.

## Method - VALIDATE

Performs validation on the associated input object. The method returns true if the validation was successful, otherwise it returns false.

```Lua
ValidationLabel:validate()
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

local win = ui.Window("ValidationLabel", "fixed", 300, 250)

local etyAge = ui.Entry(win, "", 100, 24, 40)
local valAge = va.ValidationLabel(win, etyAge, "Age:", 10, 29)
local btnValidate = ui.Button(win, "Validate", 10, 100, 280)

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

![validationlabel](/docs/validationlabel/validationlabel01.png)
