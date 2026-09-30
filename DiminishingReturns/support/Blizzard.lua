local addon = DiminishingReturns
if not addon then return end

-- FrameXML is a internal fake to have this working like other support
addon:RegisterAddonSupport('FrameXML', function()
	
	local db = addon.db:RegisterNamespace('Blizzard', {profile={
		target = {
			enabled = false,
			iconSize = 16,
			direction = 'BOTTOM',
			spacing = 2,
			anchorPoint = 'TOPLEFT',
			relPoint = 'TOPRIGHT',
			xOffset = -25,
			yOffset = -20,
		},
		focus = {
			enabled = false,
			iconSize = 16,
			direction = 'RIGHT',
			spacing = 2,
			anchorPoint = 'TOPLEFT',
			relPoint = 'BOTTOMLEFT',
			xOffset = 14,
			yOffset = 28,
		},
		player = {
			enabled = false,
			iconSize = 16,
			direction = 'BOTTOM',
			spacing = 2,
			anchorPoint = 'TOPLEFT',
			relPoint = 'TOPRIGHT',
			xOffset = -25,
			yOffset = -20,
		},
		party1 = {
			enabled = false,
			iconSize = 16,
			direction = 'RIGHT',
			spacing = 2,
			anchorPoint = 'RIGHT',
			relPoint = 'LEFT',
			xOffset = 0,
			yOffset = 0,
		},
		party2 = {
			enabled = false,
			iconSize = 16,
			direction = 'RIGHT',
			spacing = 2,
			anchorPoint = 'RIGHT',
			relPoint = 'LEFT',
			xOffset = 0,
			yOffset = 0,
		},
		party3 = {
			enabled = false,
			iconSize = 16,
			direction = 'RIGHT',
			spacing = 2,
			anchorPoint = 'RIGHT',
			relPoint = 'LEFT',
			xOffset = 0,
			yOffset = 0,
		},
		party4 = {
			enabled = false,
			iconSize = 16,
			direction = 'RIGHT',
			spacing = 2,
			anchorPoint = 'RIGHT',
			relPoint = 'LEFT',
			xOffset = 0,
			yOffset = 0,
		},
		party5 = {
			enabled = false,
			iconSize = 16,
			direction = 'RIGHT',
			spacing = 2,
			anchorPoint = 'RIGHT',
			relPoint = 'LEFT',
			xOffset = 0,
			yOffset = 0,
		}
	}})

	-- После контроля враждебный неймплейт пропадает. Иконка остаётся на фрейме цели и фокуса.
	if not db.profile.trackControlledTarget then
		db.profile.target.enabled = true
		db.profile.focus.enabled = true
		db.profile.trackControlledTarget = true
	end
	
	local function RegisterFrame(name, unit)
		local function GetDatabase() return db.profile[unit], db end
		addon:RegisterFrameConfig('Blizzard: '..addon.L[unit], GetDatabase)
		addon:RegisterFrame(name, function(frame)
			return addon:SpawnFrame(frame, frame, GetDatabase)
		end)
	end

	RegisterFrame('TargetFrame', 'target')
	RegisterFrame('FocusFrame', 'focus')
	RegisterFrame('PlayerFrame', 'player')
	for i = 1,5 do
		RegisterFrame('PartyMemberFrame'..i, 'party'..i)
	end
end)

