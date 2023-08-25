local pkg = script.Parent
local lib = pkg.Parent

local Sift = require(lib.Parent.Sift)
local Array = Sift.Array

local types = require(pkg.types)
type Breakpoint = types.Breakpoint

local function getBreakpointByScreenWidth(breakpoints: { Breakpoint }, width: number): Breakpoint
	local breakpointByScreenWidthIndex = Array.findWhere(breakpoints, function(breakpoint)
		return width <= breakpoint.maxWidth
	end)

	return breakpoints[breakpointByScreenWidthIndex] or breakpoints[#breakpoints]
end

return getBreakpointByScreenWidth
