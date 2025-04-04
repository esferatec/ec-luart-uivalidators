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

local cbxShowAll = ui.Checkbox(win, "show all errors", 10, 140)
local cbxSeparator = ui.Checkbox(win, "' / ' as separator", 160, 165)
local cbxBGColor= ui.Checkbox(win, "'0x4060A0' as bg color", 10, 190)
local cbxFGColor= ui.Checkbox(win, "'0xF0A030' as fg color", 160, 190)

cbxShowAll.checked = valAge.showallerrors

function btnValidate:onClick()
  if cbxShowAll.checked then
    valAge.showallerrors = true
  else
    valAge.showallerrors = false
  end

  if cbxSeparator.checked then
    valAge.separator = " / "
  else
    valAge.separator = uiva.SEPARATOR.newline
  end

  if cbxBGColor.checked then
    valAge.errorbgcolor = 0x4060A0
  end

  if cbxFGColor.checked then
    valAge.errorfgcolor = 0xF0A030
  end

  valAge:validate()
end

win:show()

repeat
    ui.update()
until not win.visible