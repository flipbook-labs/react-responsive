local pkg = script.Parent
local lib = pkg.Parent

local React = require(lib.Parent.React)

local ScreenContext = require(lib.Screen.ScreenContext)
type ScreenContextData = ScreenContext.ScreenContextData

local function useRem()
	local context: ScreenContextData? = React.useContext(ScreenContext)
	if context == nil then
		error("`useRem()` must be used in a component that's a descendant of <ScreenProvider />.")
	end

	local memoizedUseRem = React.useCallback(function(value: number)
		return value * context.rem
	end, { context.rem })

	return memoizedUseRem
end

return useRem
