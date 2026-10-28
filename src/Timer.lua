-- Timer.lua
-- Lightweight timer utility for Roblox/Luau

local Timer = {}
Timer.__index = Timer

function Timer.new(duration: number)
	assert(duration >= 0, "Duration must be 0 or greater")

	local self = setmetatable({}, Timer)

	self.Duration = duration
	self._startedAt = nil
	self._pausedAt = nil
	self._pausedDuration = 0

	return self
end

function Timer:Start()
	self._startedAt = os.clock()
	self._pausedAt = nil
	self._pausedDuration = 0
end

function Timer:IsRunning(): boolean
	return self._startedAt ~= nil and not self:IsFinished()
end

function Timer:GetElapsed(): number
	if not self._startedAt then
		return 0
	end

	local currentTime = self._pausedAt or os.clock()

	return currentTime - self._startedAt - self._pausedDuration
end

function Timer:GetRemaining(): number
	return math.max(0, self.Duration - self:GetElapsed())
end

function Timer:IsFinished(): boolean
	return self:GetElapsed() >= self.Duration
end

function Timer:Pause()
	if self._startedAt and not self._pausedAt then
		self._pausedAt = os.clock()
	end
end

function Timer:Resume()
	if self._pausedAt then
		self._pausedDuration += os.clock() - self._pausedAt
		self._pausedAt = nil
	end
end

function Timer:Reset()
	self._startedAt = nil
	self._pausedAt = nil
	self._pausedDuration = 0
end

return Timer
