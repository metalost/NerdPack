local Keybinds = {
	-- Pause
	{'%pause', 'keybind(alt)'},
}

local inCombat = {

}

local outCombat = {
	{Keybinds},
}

NeP.CR:Add(259, {
  name = '[NeP] Rogue - Assassination',
  ic = InCombat,
  ooc = OutCombat,
})
