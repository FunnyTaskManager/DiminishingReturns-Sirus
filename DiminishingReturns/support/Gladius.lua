local addon = DiminishingReturns
if not addon then return end

addon:RegisterAddonSupport('Gladius', function()

	local db = addon.db:RegisterNamespace('Gladius', {profile={
		enabled = true,
		iconSize = 32,
		direction = 'LEFT',
		spacing = 2,
		anchorPoint = 'TOPRIGHT',
		relPoint = 'TOPLEFT',
		xOffset = -10,
		yOffset = 0,
	}})

	local function GetDatabase() 
		return db.profile, db
	end

	addon:RegisterFrameConfig('Gladius', GetDatabase)

	local registered = {}

	local function SetupFrame(frame)
		local anchor = frame:GetParent()
		if not anchor or anchor == UIParent then
			anchor = frame
		end
		return addon:SpawnFrame(anchor, frame, GetDatabase)
	end

	local function RegisterSecure(secure)
		if type(secure) ~= "table" or not secure.GetName then return end
		local name = secure:GetName()
		if not name and secure.GetParent then
			secure = secure:GetParent()
			name = secure and secure.GetName and secure:GetName()
		end
		if not name or registered[name] then return end
		registered[name] = true
		addon:RegisterFrame(name, SetupFrame)
	end

	local function AttachUnit(unit)
		if not unit or not Gladius then return end
		local button = Gladius.buttons and Gladius.buttons[unit]
		if not button then
			button = _G["GladiusButton"..unit] or _G["GladiusButtonFrame"..unit]
		end
		if not button then return end
		RegisterSecure(button.secure or button)
	end

	local function OnGladiusUpdate(gladius, unit)
		AttachUnit(unit)
	end

	local function TryHook(method)
		if type(Gladius) == "table" and type(Gladius[method]) == "function" then
			hooksecurefunc(Gladius, method, OnGladiusUpdate)
		end
	end

	for i = 1, 5 do
		RegisterSecure(_G["GladiusButton"..i])
		RegisterSecure(_G["GladiusButtonarena"..i])
		AttachUnit("arena"..i)
		AttachUnit(i)
	end

	if type(Gladius) == "table" and type(Gladius.buttons) == "table" then
		for unit in pairs(Gladius.buttons) do
			AttachUnit(unit)
		end
	end

	TryHook("CreateButton")
	TryHook("UpdateAttribute")
	TryHook("UpdateUnit")
	TryHook("UpdateFrame")
	
end)
