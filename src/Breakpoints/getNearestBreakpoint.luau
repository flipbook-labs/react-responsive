local pkg = script.Parent
local lib = pkg.Parent

local Sift = require(lib.Parent.Sift)
local Array = Sift.Array

local types = require(pkg.types)
type Breakpoint = types.Breakpoint

local function getNearestBreakpoint(
	breakpoints: { Breakpoint },
	breakpoint: string,
	availableBreakpoints: { string }
): string?
	local sortedBreakpoints = Array.sort(breakpoints, function(a, b)
		return a.maxWidth < b.maxWidth
	end)

	local breakpointIndex = Array.findWhere(sortedBreakpoints, function(thisBreakpoint)
		return thisBreakpoint.size == breakpoint
	end)

	local previousBreakpoints = Array.filter(sortedBreakpoints, function(thisBreakpoint)
		return thisBreakpoint.maxWidth < sortedBreakpoints[breakpointIndex].maxWidth
	end)

	local reversedBreakpoints = Array.reverse(previousBreakpoints)
	local nearestBreakpointIndex = Array.findWhere(reversedBreakpoints, function(thisBreakpoint)
		return Array.some(availableBreakpoints, function(availableBreakpoint)
			return thisBreakpoint.size == availableBreakpoint
		end)
	end)

	return nearestBreakpointIndex and reversedBreakpoints[nearestBreakpointIndex].size
end

return getNearestBreakpoint
