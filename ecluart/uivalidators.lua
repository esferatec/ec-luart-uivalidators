local ui = require("ui")

-- Provides input validation ui objects.
local uivalidators = {}

-- Defines specific constants.
uivalidators.SEPARATOR = {
  none = "",
  space = " ",
  semicolon = "; ",
  comma = ", ",
  newline = "\n",
}

uivalidators.FLAG = {
  none = "",
  exclamationmark = "(!)",
  questionmark = "(?)"
}

--#region basevalidator

-- Defines the base validator prototype.
local BaseValidator = Object(ui.Label)

-- Overrides the default label constructor.
function BaseValidator:constructor(parent, widget, caption, x, y, width, height)
  super(self).constructor(self, parent, caption, x, y, width, height)

  self.widget = widget
  self.isvalid = true
  self.count = 0
  self.message = ""
  self.rules = {}
  self.showallerrors = true
  self.separator = uivalidators.SEPARATOR.space
  self.textalign = "left"
  
  self:autosize()
end

-- Adds a new validation rule and message.
function BaseValidator:add(rule, message)
  assert(type(rule) == "function", "Parameter type must be a function: rule")
  assert(type(message) == "string" or type(message) == "nil", "Parameter type must be a string or nil: message")

  local newWidget = {}
  newWidget.rule = rule
  newWidget.message = message or ""

  table.insert(self.rules, newWidget)
end

-- Performs validation on the associated input object.
function BaseValidator:validate()
  local result = true

  -- sets default values
  self.isvalid = true
  self.message = ""
  self.count = 0

  for _, widget in pairs(self.rules) do
    if is(self.widget, ui.Entry) or is(self.widget, ui.Edit) then
      result = widget.rule(self.widget.text)
    end

    if is(self.widget, ui.Checkbox) or is(self.widget, ui.Radiobutton) then
      result = widget.rule(self.widget.checked)
    end

    if is(self.widget, ui.Combobox) or is(self.widget, ui.List) or is(self.widget, ui.Tree) then
      result = self.widget.selected and widget.rule(self.widget.selected.text) or widget.rule("")
    end

    if not result then
      self.isvalid = false
      self.count = (self.count + 1)

      if self.showallerrors then
        self.message = (self.count > 1) and (self.message .. self.separator .. widget.message) or widget.message
      else
        self.message = widget.message
      end
    end
  end
end

--#endregion basevalidator

--#region validationlabel

-- Creates a new validation label object.
local ValidationLabel = Object(BaseValidator)

-- Overrides the default label constructor.
function ValidationLabel:constructor(parent, widget, caption, x, y, width, height)
  super(self).constructor(self, parent, widget, caption, x, y, width, height)

  self.flag = uivalidators.FLAG.exclamationmark
  self.errorbgcolor = self.bgcolor
  self.errorfgcolor = 0xFF0000

  -- save initial values
  self.savetext = self.text
  self.savetooltip = self.tooltip
  self.savebgcolor = self.bgcolor
  self.savefgcolor = self.fgcolor
end

-- Performs validation on the associated input object.
function ValidationLabel:validate()
  super(self).validate(self)

  if not self.isvalid then
    self.text = self.savetext .. " " .. self.flag
    self.tooltip = self.message
    self.bgcolor = self.errorbgcolor
    self.fgcolor = self.errorfgcolor
  else
    self.text = self.savetext
    self.tooltip = self.savetooltip
    self.bgcolor = self.savebgcolor
    self.fgcolor = self.savefgcolor
  end

  self:autosize()

  return self.isvalid
end

-- Initializes a new validation label instance.
function uivalidators.ValidationLabel(parent, widget, caption, x, y, width, height)
  return ValidationLabel(parent, widget, caption, x, y, width, height)
end

--#endregion validatonlabel

--#region validationtext

-- Creates a new validation text object.
local ValidationText = Object(BaseValidator)

-- Overrides the default label constructor.
function ValidationText:constructor(parent, widget, x, y, width, height)
  super(self).constructor(self, parent, widget, " ", x, y, width, height)

  self.errorbgcolor = self.bgcolor
  self.errorfgcolor = 0xFF0000

  -- save initial values
  self.savebgcolor = self.bgcolor
  self.savefgcolor = self.fgcolor
end

-- Performs validation on the associated input object.
function ValidationText:validate()
  super(self).validate(self)

  if not self.isvalid then
    self.text = self.message
    self.bgcolor = self.errorbgcolor
    self.fgcolor = self.errorfgcolor
  else
    self.text = " "
    self.bgcolor = self.savebgcolor
    self.fgcolor = self.savefgcolor
  end

  self:autosize()

  return self.isvalid
end

-- Initializes a new validation text instance.
function uivalidators.ValidationText(parent, widget, x, y, width, height)
  return ValidationText(parent, widget, x, y, width, height)
end

--#endregion validationtext

--#region validationindicator

-- Creates a new validation indicator object.
local ValidationIndicator = Object(BaseValidator)

-- Overrides the default label constructor.
function ValidationIndicator:constructor(parent, widget, x, y, width, height)
  super(self).constructor(self, parent, widget, " ", x, y, width, height)

  self.flag = uivalidators.FLAG.exclamationmark
  self.errorbgcolor = self.bgcolor
  self.errorfgcolor = 0xFF0000

  -- save initial values
  self.savebgcolor = self.bgcolor
  self.savefgcolor = self.fgcolor
end

-- Performs validation on the associated input object.
function ValidationIndicator:validate()
  super(self).validate(self)

  if not self.isvalid then
    self.text = self.flag
    self.tooltip = self.message
    self.bgcolor = self.errorbgcolor
    self.fgcolor = self.errorfgcolor
  else
    self.text = ""
    self.tooltip = ""
    self.bgcolor = self.savebgcolor
    self.fgcolor = self.savefgcolor
  end

  self:autosize()

  return self.isvalid
end

-- Initializes a new validation indicator instance.
function uivalidators.ValidationIndicator(parent, widget, x, y, width, height)
  return ValidationIndicator(parent, widget, x, y, width, height)
end

--#endregion validatonndicator

return uivalidators
