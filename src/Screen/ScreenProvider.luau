local pkg = script.Parent
local lib = pkg.Parent

local React = require(lib.Parent.React)

local map = require(lib.map)
local setTimeout = require(lib.setTimeout)

local ScreenContext = require(pkg.ScreenContext)
type ScreenContextData = ScreenContext.ScreenContextData

local Breakpoints = require(lib.Breakpoints)
local getBreakpointByScreenWidth = Breakpoints.getBreakpointByScreenWidth
type Breakpoint = Breakpoints.Breakpoint

local BASE_FONT_SIZE = 16
local BASE_SCREEN_SIZE = Vector2.new(1920, 1080)
local UPDATE_INTERVAL = 1
local DEFAULT_BREAKPOINTS: { Breakpoint } = {
	{ size = "sm", maxWidth = 576 },
	{ size = "md", maxWidth = 768 },
	{ size = "lg", maxWidth = 992 },
	{ size = "xl", maxWidth = 1200 },
}

export type ScreenProviderProps = {
	baseFontSize: number?,
	baseScreenSize: Vector2?,
	breakpoints: { Breakpoint }?,
	children: any,
	updateInterval: number?,
}

local function ScreenProvider(props: ScreenProviderProps)
	local baseFontSize = props.baseFontSize or BASE_FONT_SIZE
	local breakpoints = props.breakpoints or DEFAULT_BREAKPOINTS
	local baseScreenSize = props.baseScreenSize or BASE_SCREEN_SIZE
	local updateInterval = props.updateInterval or UPDATE_INTERVAL

	local getCurrentBreakpoint = React.useCallback(function()
		local width = workspace.CurrentCamera.ViewportSize.X
		return getBreakpointByScreenWidth(breakpoints, width)
	end, { breakpoints })

	local currentBreakpoint = React.useRef(nil :: Breakpoint?)
	local breakpoint, setBreakpoint = React.useState(getCurrentBreakpoint)

	local getCurrentRem = React.useCallback(function()
		local cameraSize = workspace.CurrentCamera.ViewportSize
		local size = Vector2.new(math.min(cameraSize.X, cameraSize.Y * (19 / 9)), cameraSize.Y)
		local scale = size.Magnitude / baseScreenSize.Magnitude

		if size.Y > size.X and scale < 1 then
			scale = map(scale, 0, 1, 0.25, 1)
		end

		return math.round(baseFontSize * scale)
	end, { baseFontSize, baseScreenSize })

	local currentRem = React.useRef(nil :: number?)
	local rem, setRem = React.useState(getCurrentRem)

	local handleScreenResize = React.useCallback(function()
		local screenBreakpoint = getCurrentBreakpoint()
		local screenRem = getCurrentRem()

		if screenBreakpoint ~= currentBreakpoint.current then
			setBreakpoint(screenBreakpoint)
		end

		if screenRem ~= currentRem.current then
			setRem(screenRem)
		end
	end, { getCurrentBreakpoint, getCurrentRem })

	React.useEffect(function()
		local clearTimeout = nil
		local event = workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize")
		local connection = event:Connect(function()
			if clearTimeout ~= nil then
				return
			end

			clearTimeout = setTimeout(function()
				clearTimeout = nil
				handleScreenResize()
			end, updateInterval)
		end)

		return function()
			connection:Disconnect()

			if clearTimeout ~= nil then
				clearTimeout()
			end
		end
	end, { updateInterval, handleScreenResize })

	local value: ScreenContextData = React.useMemo(function()
		return {
			baseFontSize = baseFontSize,
			breakpoint = breakpoint,
			breakpoints = breakpoints,
			rem = rem,
		}
	end, { baseFontSize, breakpoint, breakpoints, rem })

	return React.createElement(ScreenContext.Provider, {
		value = value,
	}, props.children)
end

return React.memo(ScreenProvider)
