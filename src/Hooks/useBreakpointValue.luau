local pkg = script.Parent
local lib = pkg.Parent

local React = require(lib.Parent.React)

local Breakpoints = require(lib.Breakpoints)
local getNearestBreakpointValue = Breakpoints.getNearestBreakpointValue
type Breakpoint = Breakpoints.Breakpoint

local ScreenContext = require(lib.Screen.ScreenContext)
type ScreenContextData = ScreenContext.ScreenContextData

local function useBreakpointValue<T>(values: { [string]: T, base: T }): T
	local context: ScreenContextData? = React.useContext(ScreenContext)
	if context == nil then
		error("`useBreakpointValue()` must be used in a component that's a descendant of <ScreenProvider />.")
	end

	local memoizedNearestValue = React.useMemo(function()
		return getNearestBreakpointValue(context.breakpoints, context.breakpoint.size, values)
	end, { context.breakpoint, context.breakpoints, values })

	return memoizedNearestValue
end

return useBreakpointValue
