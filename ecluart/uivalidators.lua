local ui = require("ui")

-- Provides input validation ui objects.
local uivalidators = {}

-- Defines specific constants.
uivalidators.SEPARATOR = {}
uivalidators.SEPARATOR.none = ""
uivalidators.SEPARATOR.newline = "\n"
uivalidators.SEPARATOR.space = " "
uivalidators.SEPARATOR.semicolon = "; "
uivalidators.SEPARATOR.comma = ", "

uivalidators.FLAG = {}
uivalidators.FLAG.none = ""
uivalidators.FLAG.exclamationmark = "(!)"
uivalidators.FLAG.questionmark = "(?)"

--#region basevalidator

local BaseValidator = Object(ui.Label)

function BaseValidator:constructor(parent, widget, caption, x, y, width, height)
  super(self).constructor(self, parent, caption, x, y, width, height)
  self.widget = widget
  self.isvalid = true
  self.count = 0
  self.message = ""
  self.rules = {}
  self.showallerrors = true
  self.separator = uivalidators.SEPARATOR.space

  self:autosize()
end

-- Adds a new validation rule and message.
function BaseValidator:add(rule, message)
  -- validates parameter types
  assert(type(rule) == "function", "Parameter type must be a function: rule")
  assert(type(message) == "string" or type(message) == "nil", "Parameter type must be a string or nil: message")

  -- nw = new widget
  local nw = {}
  nw.rule = rule
  nw.message = message or ""

  table.insert(self.rules, nw)
end

-- Performs validation on the associated input object.
function BaseValidator:validate()
  local result = true

  -- sets default values
  self.isvalid = true
  self.message = ""
  self.count = 0

  -- w = widget
  for _, w in pairs(self.rules) do
    if is(self.widget, ui.Entry) or is(self.widget, ui.Edit) then
      result = w.rule(self.widget.text)
    end

    if is(self.widget, ui.Checkbox) or is(self.widget, ui.Radiobutton) then
      result = w.rule(self.widget.checked)
    end

    if is(self.widget, ui.Combobox) or is(self.widget, ui.List) or is(self.widget, ui.Tree) then
      result = self.widget.selected and w.rule(self.widget.selected.text) or w.rule("")
    end

    if not result then
      self.isvalid = false
      self.count = (self.count + 1)

      if self.showallerrors then
        self.message = (self.count > 1) and (self.message .. self.separator .. w.message) or w.message
      else
        self.message = w.message
      end
    end
  end
end

--#endregion basevalidator

--#region validationlabel

-- Creates a new validation label object.
local ValidationLabel = Object(BaseValidator)

-- Overrites the default label constructor.
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

-- Overrites the default label constructor.
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

-- Overrites the default label constructor.
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

  return self.isvalid
end

-- Initializes a new validation indicator instance.
function uivalidators.ValidationIndicator(parent, widget, x, y, width, height)
  return ValidationIndicator(parent, widget, x, y, width, height)
end

--#endregion validatonndicator

--#region validationsummary

-- Creates a new validation summary object.
local ValidationSummary = Object(ui.Label)

-- Overrites the default label constructor.
function ValidationSummary:constructor(parent, x, y, width, height)
  ui.Label.constructor(self, parent, "", x, y, width, height)
  self.widgets = {}
  self.isvalid = true
  self.count = 0
  self.message = ""
  self.separator = uivalidators.SEPARATOR.newline
end

-- Adds a new validation object.
function ValidationSummary:add(widget)
  local isvalidwiget = { ["ValidationLabel"] = true, ["ValidationIndicator"] = true, ["ValidationText"] = true }

  -- validates parameter types
  assert(isvalidwiget[type(widget)], "Parameter type must be a ValidationLabel, ValidationIndicator or ValidationText.")

  table.insert(self.widgets, widget)
end

-- Performs validation of all validation labels.
function ValidationSummary:validate()
  -- w = widget
  for _, w in pairs(self.widgets) do
    w:validate()
  end
end

-- Updates the validation summary label text.
function ValidationSummary:update()
  -- sets default values
  self.isvalid = true
  self.message = ""
  self.count = 0

  -- w = widget
  for _, w in pairs(self.widgets) do
    if not w.isvalid then
      self.isvalid = false
      self.count = self.count + w.count
      self.message = (self.count > 1) and (self.message .. self.separator .. w.message) or w.message
    end
  end

  if not self.isvalid then
    self.text = self.message
  else
    self.text = ""
  end
end

-- Initializes a new validation summary instance.
function uivalidators.ValidationSummary(parent, x, y, width, height)
  return ValidationSummary(parent, x, y, width, height)
end

--#endregion validationsummary

return uivalidators
