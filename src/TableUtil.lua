-- TableUtil.lua
-- Useful table helpers for Roblox/Luau

local TableUtil = {}

function TableUtil.Count(dictionary: {[any]: any}): number
	local count = 0

	for _ in pairs(dictionary) do
		count += 1
	end

	return count
end

function TableUtil.Contains<T>(items: {T}, value: T): boolean
	return table.find(items, value) ~= nil
end

function TableUtil.Reverse<T>(items: {T}): {T}
	local result = {}

	for i = #items, 1, -1 do
		table.insert(result, items[i])
	end

	return result
end

function TableUtil.Copy<T>(items: {T}): {T}
	return table.clone(items)
end

function TableUtil.Filter<T>(items: {T}, callback: (T) -> boolean): {T}
	local result = {}

	for _, value in ipairs(items) do
		if callback(value) then
			table.insert(result, value)
		end
	end

	return result
end

function TableUtil.Map<T, U>(items: {T}, callback: (T) -> U): {U}
	local result = {}

	for _, value in ipairs(items) do
		table.insert(result, callback(value))
	end

	return result
end

function TableUtil.Clear(dictionary: {[any]: any})
	table.clear(dictionary)
end

return TableUtil
