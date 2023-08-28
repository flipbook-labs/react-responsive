local ReplicatedStorage = game:GetService("ReplicatedStorage")

local React = require(ReplicatedStorage.Packages.React)
local ReactRoblox = require(ReplicatedStorage.Packages.ReactRoblox)
local ReactResponsive = require(ReplicatedStorage.Packages.ReactResponsive)

local function Story()
	local rem = ReactResponsive.useRem()

	return React.createElement("TextLabel", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromOffset(rem(10), rem(10)),
		Text = rem(1),
	})
end

return function(t: GuiObject)
	local root = ReactRoblox.createRoot(t)
	root:render(React.createElement(ReactResponsive.ScreenProvider, nil, {
		Story = React.createElement(Story),
	}))

	return function()
		root:unmount()
	end
end
