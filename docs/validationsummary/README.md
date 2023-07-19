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
ValidationSummary.separator (string)
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

## Property - isvalid

Gets a value indicating whether all  validation succeeded.

```Lua
ValidationSummary.isvalid (boolean)
```

## Property - count

Gets the amount of all errors.

```Lua
ValidationSummary.count (number)
```

## Property - message

Gets all error message.

```Lua
ValidationSummary.message (string)
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

```

![validationsummary](/docs/validationsummary/validationsummary01.png)
