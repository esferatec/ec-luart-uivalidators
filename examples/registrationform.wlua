local ui = require("ui")
local va = require("ecluart.uivalidators")

--#region validation functions
local function isrequired(value)
  return string.len(value) > 0
end

local function isinteger(value)
  return math.type(math.tointeger(value)) == "integer"
end

local function isitem2(value)
  return value == "Item 2"
end

local function isemail(value)
  return string.find(value, "@") ~= nil -- for demonstration only
end
--#endregion validation functions

--#region main window
local win = ui.Window("RegistrationForm With ValidationLabels and ValidationSummary", "fixed", 400, 400)

local etyName = ui.Entry(win, "", 100, 20, 180)
local etyPassword = ui.Entry(win, "", 100, 52, 180)
local etyAge = ui.Entry(win, "", 100, 84, 40)
local etyEmail = ui.Entry(win, "", 100, 116, 180)
local cbbCountry = ui.Combobox(win, { "Item 1", "Item 2", "Item 3" }, 100, 148, 80)

local valName = va.ValidationLabel(win, etyName, "Name:", 10, 25, 90)
local valPassword = va.ValidationLabel(win, etyPassword, "Password:", 10, 57)
local valAge = va.ValidationLabel(win, etyAge, "Age:", 10, 89)
local valEmail = va.ValidationLabel(win, etyEmail, "Email:", 10, 121)
local valCountry = va.ValidationLabel(win, cbbCountry, "Country:", 10, 153)

local btnValidate = ui.Button(win, "Validate", 10, 210, 380)

local valSummary = va.ValidationSummary(win, 10, 250, 380, 50)
--#endregion main window

--adds validation rules and messages 
valName:add(isrequired, "Name ist required.")
valPassword:add(isrequired, "Password is required.")
valAge:add(isrequired, "Age is required.")
valAge:add(isinteger, "Age must be a number.")
valEmail:add(isrequired, "Email is required.")
valEmail:add(isemail, "Not a valid Email.")
valCountry:add(isrequired, "Country is required.")
valCountry:add(isitem2, "Country must be Item 2.")

-- adds all validation labels
valSummary:add(valName)
valSummary:add(valPassword)
valSummary:add(valAge)
valSummary:add(valEmail)
valSummary:add(valCountry)

function btnValidate:onClick()
  --executes the individual validation functions of each validation label
  valSummary:validate()

  -- updates the validation summary text with each error message
  valSummary:update()
end

win:show()

repeat
  ui.update()
until not win.visible
