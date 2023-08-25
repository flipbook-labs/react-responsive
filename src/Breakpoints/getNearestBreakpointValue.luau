local pkg = script.Parent
local lib = pkg.Parent

local getNearestBreakpoint = require(pkg.getNearestBreakpoint)

local Sift = require(lib.Parent.Sift)
local Dictionary = Sift.Dictionary

local types = require(pkg.types)
type Breakpoint = types.Breakpoint

local function getNearestBreakpointValue<T>(
	breakpoints: { Breakpoint },
	breakpoint: string,
	values: { [string]: T, base: T }
): T
	local value = values[breakpoint]
	if value == nil then
		local nearestBreakpoint = getNearestBreakpoint(breakpoints, breakpoint, Dictionary.keys(values))
		return if nearestBreakpoint ~= nil then values[nearestBreakpoint] else values.base
	end

	return value
end

return getNearestBreakpointValue
