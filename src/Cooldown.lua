
-- Cooldown.lua
-- Simple cooldown utility for Roblox/Luau

local Cooldown = {}
Cooldown.__index = Cooldown

function Cooldown.new(duration: number)
	assert(duration > 0, "Cooldown duration must be greater than 0")

	local self = setmetatable({}, Cooldown)

	self.Duration = duration
	self._lastUsed = {}

	return self
end

function Cooldown:IsReady(key: any): boolean
	local lastUsed = self._lastUsed[key]

	if lastUsed == nil then
		return true
	end

	return os.clock() - lastUsed >= self.Duration
end

function Cooldown:Use(key: any): boolean
	if not self:IsReady(key) then
		return false
	end

	self._lastUsed[key] = os.clock()
	return true
end

function Cooldown:GetRemaining(key: any): number
	local lastUsed = self._lastUsed[key]

	if lastUsed == nil then
		return 0
	end

	return math.max(0, self.Duration - (os.clock() - lastUsed))
end

function Cooldown:Reset(key: any)
	self._lastUsed[key] = nil
end

function Cooldown:ResetAll()
	table.clear(self._lastUsed)
end

return Cooldown
