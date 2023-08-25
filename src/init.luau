local useBreakpointValue = require(script.Hooks.useBreakpointValue)
local useMediaQuery = require(script.Hooks.useMediaQuery)
local useRem = require(script.Hooks.useRem)

local ScreenProvider = require(script.Screen.ScreenProvider)
type ScreenProviderProps = ScreenProvider.ScreenProviderProps

return table.freeze({
	ScreenProvider = ScreenProvider,
	useBreakpointValue = useBreakpointValue,
	useMediaQuery = useMediaQuery,
	useRem = useRem,
})
