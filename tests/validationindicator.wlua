local ui = require("ui")
local va = require("ecluart.uivalidators")

local function isrequired(value)
  return string.len(value) > 0
end

local function isnumber(value)
  return math.type(math.tointeger(value)) == "integer"
end

local win = ui.Window("ValidationIndicator", "fixed", 320, 250)

local lblAge = ui.Label(win, "Age:", 10, 29)
local etyAge = ui.Entry(win, "", 45, 24, 40)
local valAge = va.ValidationIndicator(win, etyAge, 90, 29)
local btnValidate = ui.Button(win, "Validate", 10, 100, 300)

valAge:add(isrequired, "Age is required.")
valAge:add(isnumber, "Age must be a number.")

local cbxShowAll = ui.Checkbox(win, "show all errors", 10, 140)
local cbxSeparator = ui.Checkbox(win, "' / ' as separator", 160, 165)
local cbxFlag = ui.Checkbox(win, "'(ERROR)' as flag", 10, 165)
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
    valAge.separator = va.SEPARATOR.space
  end

  if cbxFlag.checked then
    valAge.flag = "(ERROR)"
  else
    valAge.flag = va.FLAG.exclamationmark
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