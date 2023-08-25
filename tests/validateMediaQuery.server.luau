local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage.Packages.Responsive
local Breakpoints = require(lib.Breakpoints)
local validateMediaQuery = Breakpoints.validateMediaQuery

local BREAKPOINTS = {
	{ size = "sm", maxWidth = 576 },
	{ size = "md", maxWidth = 768 },
	{ size = "lg", maxWidth = 992 },
	{ size = "xl", maxWidth = 1200 },
}

warn("\n\t\t\t\tvalidateMediaQuery:")
warn("it should throw an error when provide a breakpoint without 'currentBreakpoint'.")
local _, errorMsg = pcall(function()
	validateMediaQuery(BREAKPOINTS, { minBreakpoint = "md" })
end)
print(
	errorMsg
		== "ReplicatedStorage.Packages.Responsive.breakpoints.validateMediaQuery:14: <validateMediaQuery> MediaQuery should include current breakpoint."
)

warn("it should return 'true' if no params as provided.")
print(`{validateMediaQuery(BREAKPOINTS, {}) == true}`)

warn("it should return 'false' if minBreakpoint is bigger than current breakpoint.")
print(`{validateMediaQuery(BREAKPOINTS, { minBreakpoint = "lg", currentBreakpoint = "sm" }) == false}`)

warn("it should return 'true' if minBreakpoint is lower than current breakpoint.")
print(`{validateMediaQuery(BREAKPOINTS, { minBreakpoint = "lg", currentBreakpoint = "xl" }) == true}`)

warn("it should return 'true' if maxBreakpoint is bigger than current breakpoint.")
print(`{validateMediaQuery(BREAKPOINTS, { maxBreakpoint = "lg", currentBreakpoint = "sm" }) == true}`)

warn("it should return 'false' if maxBreakpoint is lower than current breakpoint.")
print(`{validateMediaQuery(BREAKPOINTS, { maxBreakpoint = "lg", currentBreakpoint = "xl" }) == false}`)
