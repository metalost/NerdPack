local _, NeP = ...

NeP.FakeUnits = {}
NeP.Globals.FakeUnits = NeP.FakeUnits
local Units = {}

local function _add(name, func)
	if not Units[name] then
		Units[name] = func
	end
end

function NeP.FakeUnits.Add(_, name, func)
	if type(name) == 'table' then
		for i=1, #name do
			_add(name[i], func)
		end
	elseif type(name) == 'string' then
		_add(name, func)
	else
		NeP.Core:Print("ERROR! tried to add an invalid fake unit")
	end
end

local function process(unit)
	-- Find and remove num and arg
	local arg = unit:match('%((.+)%)')
	local num = unit:match("%d+") or 1
	local funit = unit:gsub(arg or '', ''):gsub(num or '', '')
	return Units[funit] and Units[funit](tonumber(num), arg) or unit
end

function NeP.FakeUnits.Filter(_, unit)
	if type(unit) == 'table' then
		local tmp = {}
		for i=1, #unit do
			-- If the fake unit returns a table then we need
			-- to merge it, EX: {tank, enemies}
			-- tank is a single unit while enemie is a table
			local tmp_unit = process(unit)
			if type(tmp_unit)=='table' then
				for i=1, #tmp_unit do
					tmp[#tmp+1] = tmp_unit[i]
				end
			else
				tmp[#tmp+1] = tmp_unit
			end
		end
		return tmp
	end
	return process(unit)
end
