-- Random.lua
-- Random selection utilities for Roblox/Luau

local RandomUtil = {}

local rng = Random.new()

function RandomUtil.Choice<T>(items: {T}): T?
	if #items == 0 then
		return nil
	end

	return items[rng:NextInteger(1, #items)]
end

function RandomUtil.Shuffle<T>(items: {T}): {T}
	local result = table.clone(items)

	for i = #result, 2, -1 do
		local j = rng:NextInteger(1, i)
		result[i], result[j] = result[j], result[i]
	end

	return result
end

function RandomUtil.Range(minimum: number, maximum: number): number
	assert(minimum <= maximum, "Minimum cannot be greater than maximum")

	return rng:NextNumber(minimum, maximum)
end

function RandomUtil.Integer(minimum: number, maximum: number): number
	assert(minimum <= maximum, "Minimum cannot be greater than maximum")

	return rng:NextInteger(minimum, maximum)
end

function RandomUtil.Chance(probability: number): boolean
	assert(
		probability >= 0 and probability <= 1,
		"Probability must be between 0 and 1"
	)

	return rng:NextNumber() <= probability
end

return RandomUtil
