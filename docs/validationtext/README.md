# ValidationText

Represents a text label for an input object and provides data validation support.
The error message is displayed in the label.

![validationtext](/docs/validationtext/validationtext01.png)

**Note:**
This documentation describes only the additional properties and methods.
The standard properties, methods and events can be found in the [LuaRT Label](https://www.luart.org/doc/ui/Label.html) documentation.

## Constructor

Initializes a new validation text instance.

```Lua
ValidationText(parent, widget, [x], [y], [width], [height])
```

Parameter | Type | Description
---|---|---
widget | object | Sets the input object to validate.

## Property - SHOWALLERRORS

Shows either all error messages or only the last one.

```Lua
ValidationText.showallerrors (boolean)
```

![validationtext](/docs/validationtext/validationtext02.png)
![validationtext](/docs/validationtext/validationtext03.png)

## Property - SEPARATOR

Specifies the text between two or more error messages. The default separator is: SEPARATOR.space

```Lua
ValidationText.separator (string)
```

![validationtext](/docs/validationtext/validationtext05.png)

## Constant - SEPARATOR

Field | Value
---|:---:
none |
newline | "\n"
space | " "
semicolon | "; "
comma | ", "

## Property - ERRORBGCOLOR

Defines the background color when validation is unsuccessful.

```Lua
ValidationText.errorbgcolor (number)
```

![validationtext](/docs/validationtext/validationtext06.png)

## Property - ERRORFGCOLOR

Defines the foreground color when validation is unsuccessful.

```Lua
ValidationText.errorfgcolor (number)
```

![validationtext](/docs/validationtext/validationtext06.png)

## Property - ISVALID

Gets a value indicating whether validation succeeded.

```Lua
ValidationText.isvalid (boolean)
```

## Property - COUNT

Gets the amount of errors.

```Lua
ValidationText.count (number)
```

## Property - MESSAGE

Gets the error message.

```Lua
ValidationText.message (string)
```

## Method - ADD

Adds a new validation rule and message.

```Lua
ValidationText:add(rule, message)
```

Parameter | Type | Description
---|---|---
rule | function | Sets the validation function. The function must return false if the validation fails.
message | string | Sets the error message.

## Method - VALIDATE

Performs validation on the associated input object. The method returns true if the validation was successful, otherwise it returns false.

```Lua
ValidationText:validate()
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

local win = ui.Window("ValidationText", "fixed", 300, 250)

local lblAge = ui.Label(win, "Age:", 10, 29)
local etyAge = ui.Entry(win, "", 100, 24, 40)
local valAge = uiva.ValidationText(win, etyAge, 10, 54)
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

![validationtext](/docs/validationtext/validationtext01.png)
