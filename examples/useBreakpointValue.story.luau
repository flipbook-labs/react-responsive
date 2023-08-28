local ReplicatedStorage = game:GetService("ReplicatedStorage")

local React = require(ReplicatedStorage.Packages.React)
local ReactRoblox = require(ReplicatedStorage.Packages.ReactRoblox)
local ReactResponsive = require(ReplicatedStorage.Packages.ReactResponsive)

local function Story()
	local textByBreakpoint = ReactResponsive.useBreakpointValue({
		md = "I'm a medium device",
		lg = "I'm a large device",
		xl = "I'm an extra large device",
		base = "I will be used in any device that is larger than md",
	})

	return React.createElement("TextLabel", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromOffset(100, 100),
		Text = textByBreakpoint,
	})
end

return function(t: GuiObject)
	local root = ReactRoblox.createRoot(t)
	root:render(React.createElement(ReactResponsive.ScreenProvider, {
		updateInterval = 0.1,
	}, {
		Story = React.createElement(Story),
	}))

	return function()
		root:unmount()
	end
end
