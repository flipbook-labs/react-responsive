local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage.Packages.Responsive
local Breakpoints = require(lib.Breakpoints)
local getNearestBreakpointValue = Breakpoints.getNearestBreakpointValue

local BREAKPOINTS = {
	{ size = "sm", maxWidth = 576 },
	{ size = "md", maxWidth = 768 },
	{ size = "lg", maxWidth = 992 },
	{ size = "xl", maxWidth = 1200 },
}

warn("\n\t\t\t\tgetNearestBreakpointValue:")

warn("it should return the breakpoint value.")
print(`{getNearestBreakpointValue(BREAKPOINTS, "sm", { sm = 100, base = 50 }) == 100}`)

warn("it should return the nearest breakpoint value when the breakpoint has no value.")
print(`{getNearestBreakpointValue(BREAKPOINTS, "md", { sm = 100, base = 50 }) == 100}`)

warn("it should return the base breakpoint value when the breakpoint doesn't exist.")
print(`{getNearestBreakpointValue(BREAKPOINTS, "sm", { base = 50 }) == 50}`)

warn("it should return the base breakpoint value when the breakpoint doesn't have the nearest breakpoint.")
print(`{getNearestBreakpointValue(BREAKPOINTS, "sm", { base = 50 }) == 50}`)
