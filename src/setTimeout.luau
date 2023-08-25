local RunService = game:GetService("RunService")

local function setTimeout(callback: () -> (), timeout: number): { Disconnect: () -> () }
	local timer = 0
	local connection = nil
	connection = RunService.Heartbeat:Connect(function(dt: number)
		timer += dt

		if timer >= timeout then
			connection:Disconnect()
			callback()
		end
	end)

	return {
		Disconnect = function()
			connection:Disconnect()
		end,
	}
end

return setTimeout
