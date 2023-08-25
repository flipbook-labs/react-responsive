local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage.Packages.Responsive
local Breakpoints = require(lib.Breakpoints)
local getNearestBreakpoint = Breakpoints.getNearestBreakpoint

local BREAKPOINTS = {
	{ size = "sm", maxWidth = 576 },
	{ size = "md", maxWidth = 768 },
	{ size = "lg", maxWidth = 992 },
	{ size = "xl", maxWidth = 1200 },
}

warn("\n\t\t\t\tgetNearestBreakpoint:")

warn("it should return 'nil' when availableBreakpoints are empty.")
print(`{getNearestBreakpoint(BREAKPOINTS, "xl", {}) == nil}`)

warn("it should return the nearest breakpoint.")
print(`{getNearestBreakpoint(BREAKPOINTS, "xl", { "sm", "md", "lg", "xl" }) == "lg"}`)
print(`{getNearestBreakpoint(BREAKPOINTS, "lg", { "sm", "md", "lg", "xl" }) == "md"}`)
print(`{getNearestBreakpoint(BREAKPOINTS, "md", { "sm", "md", "lg", "xl" }) == "sm"}`)
