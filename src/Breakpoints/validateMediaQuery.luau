local pkg = script.Parent
local lib = pkg.Parent

local Sift = require(lib.Parent.Sift)
local Array = Sift.Array

local types = require(pkg.types)
type MediaQuery = types.MediaQuery
type Breakpoint = types.Breakpoint

local function validateMediaQuery(
	breakpoints: { Breakpoint },
	query: MediaQuery & { currentBreakpoint: string? }
): boolean
	if query.minBreakpoint ~= nil or query.maxBreakpoint ~= nil then
		if query.currentBreakpoint == nil then
			error("<validateMediaQuery> MediaQuery should include current breakpoint.")
		end

		local currentBreakpointIndex = Array.findWhere(breakpoints, function(breakpoint)
			return breakpoint.size == query.currentBreakpoint
		end)

		if query.minBreakpoint ~= nil then
			local minBreakpointIndex = Array.findWhere(breakpoints, function(breakpoint)
				return breakpoint.size == query.minBreakpoint
			end)

			if minBreakpointIndex > currentBreakpointIndex then
				return false
			end
		end

		if query.maxBreakpoint ~= nil then
			local maxBreakpointIndex = Array.findWhere(breakpoints, function(breakpoint)
				return breakpoint.size == query.maxBreakpoint
			end)

			if maxBreakpointIndex < currentBreakpointIndex then
				return false
			end
		end
	end

	return true
end

return validateMediaQuery
