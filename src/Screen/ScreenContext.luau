local pkg = script.Parent
local lib = pkg.Parent

local React = require(lib.Parent.React)

local Breakpoints = require(lib.Breakpoints)
type Breakpoint = Breakpoints.Breakpoint

export type ScreenContextData = {
	baseFontSize: number,
	breakpoint: Breakpoint,
	breakpoints: { Breakpoint },
	rem: number,
}

local ScreenContext = React.createContext({} :: ScreenContextData)
ScreenContext.displayName = "ScreenContext"

return ScreenContext
