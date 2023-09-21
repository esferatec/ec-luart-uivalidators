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