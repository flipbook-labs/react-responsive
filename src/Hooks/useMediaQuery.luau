local pkg = script.Parent
local lib = pkg.Parent

local React = require(lib.Parent.React)

local Sift = require(lib.Parent.Sift)
local Dictionary = Sift.Dictionary

local Breakpoints = require(lib.Breakpoints)
local validateMediaQuery = Breakpoints.validateMediaQuery
type MediaQuery = Breakpoints.MediaQuery

local ScreenContext = require(lib.Screen.ScreenContext)
type ScreenContextData = ScreenContext.ScreenContextData

local function useMediaQuery(query: MediaQuery): boolean
	local context: ScreenContextData? = React.useContext(ScreenContext)
	if context == nil then
		error("`useMediaQuery()` must be used in a component that's a descendant of <ScreenProvider />.")
	end

	local memoizedValidation = React.useMemo(function()
		return validateMediaQuery(
			context.breakpoints,
			Dictionary.join(query, {
				currentBreakpoint = context.breakpoint.size,
			})
		)
	end, { context.breakpoint, context.breakpoints, query })

	return memoizedValidation
end

return useMediaQuery
