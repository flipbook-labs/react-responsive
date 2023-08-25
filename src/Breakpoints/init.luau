local getBreakpointByScreenWidth = require(script.getBreakpointByScreenWidth)
local getNearestBreakpoint = require(script.getNearestBreakpoint)
local getNearestBreakpointValue = require(script.getNearestBreakpointValue)
local validateMediaQuery = require(script.validateMediaQuery)

local types = require(script.types)
export type Breakpoint = types.Breakpoint
export type MediaQuery = types.MediaQuery

return table.freeze({
	getBreakpointByScreenWidth = getBreakpointByScreenWidth,
	getNearestBreakpoint = getNearestBreakpoint,
	getNearestBreakpointValue = getNearestBreakpointValue,
	validateMediaQuery = validateMediaQuery,
})
