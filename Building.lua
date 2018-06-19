local ItemsStatsHandler = require(game.ReplicatedStorage.Scripts.Items)
local Remotes = game.ReplicatedStorage.Remotes
local Player = game.Players.LocalPlayer
local Mouse = Player:GetMouse()

print(game.Workspace.Camera.ViewportSize)

local Surfaces = {"FrontSurface", "BackSurface", "LeftSurface", "RightSurface", "TopSurface", "BottomSurface"}

local P1, P2 -- Build Points
local P1Placed, P2Placed = false, false

local Wall, WallS1, WallS2

local SelectedBuilding = 0 -- 0 = Nothing selected

local BuildModes =
{
	[1] = 
	{
		BName = "Nothing";
		Value = 1
	};
	[2] = 
	{
		BName = "Acessories";
		Value = 2
	};
	[3] = 
	{
		BName = "Windows";
		Value = 3
	};
	[4] = 
	{
		BName = "Walls";
		Value = 4
	}
}

Mouse.Button1Down:connect(function()
	local MousePos = Mouse.Hit
	local Target = Mouse.Target
	if Target == nil then
	elseif SelectedBuilding == BuildModes[2].Value then
		--Coming soon
	elseif SelectedBuilding == BuildModes[3].Value then
		--local NewWindow = game.Repl
		--if (Mouse.Hit - )
	elseif SelectedBuilding == BuildModes[4].Value and Target.Name == "Baseplate" then
		if P1 == nil and P2Placed == false then
			local BP = Vector3.new(math.floor(MousePos.X), math.floor(MousePos.Y), math.floor(MousePos.Z))
			local NewPoint = Instance.new("Part", game.Workspace.Walls)
			NewPoint.CFrame = CFrame.new(BP.X, BP.Y + 4, BP.Z)
			NewPoint.Transparency = 1
			NewPoint.Size = Vector3.new(1, 8, 1)
			NewPoint.Anchored = true
			NewPoint.BrickColor = BrickColor.new("Bright green")
			P1 = NewPoint
			P1Placed = true
			
			local BP = Vector3.new(math.floor(MousePos.X), math.floor(MousePos.Y), math.floor(MousePos.Z))
			local NewPoint = Instance.new("Part", game.Workspace.Walls)
			NewPoint.CFrame = CFrame.new(BP.X, BP.Y + 4, BP.Z)
			NewPoint.Transparency = 1
			NewPoint.Size = Vector3.new(1, 8, 1)
			NewPoint.Anchored = true
			NewPoint.BrickColor = BrickColor.new("Bright green")
			P2 = NewPoint
			
			local Mag = (P1.Position - P2.Position).magnitude
			local MP = P1.Position:Lerp(P2.Position, 0.5) -- Get the middle point
			
			local NewWall = Instance.new("Part", game.Workspace.Walls)
			NewWall.CFrame = CFrame.new(Vector3.new(MP.X, MP.Y, MP.Z), P1.Position) * CFrame.new(0, 0, 0)
			NewWall.Size = Vector3.new(0.45, 8, Mag)
			NewWall.Transparency = 0.5
			NewWall.Anchored = true
			NewWall.BrickColor = BrickColor.new("Bright red")
			Wall = NewWall
			
			local WallSide1 = Instance.new("Part", game.Workspace.Walls)
			WallSide1.CFrame = CFrame.new(Vector3.new(MP.X, MP.Y, MP.Z), P1.Position) * CFrame.new(0.1, 0, 0)
			WallSide1.Size = Vector3.new(0.2, 8, Mag)
			WallSide1.Transparency = .4
			WallSide1.Anchored = true
			WallSide1.BrickColor = BrickColor.new("Bright yellow")
			WallS1 = WallSide1
			for _, Side in ipairs(Surfaces) do
				WallSide1[Side] = Enum.SurfaceType.SmoothNoOutlines
			end
			
			local WallSide2 = Instance.new("Part", game.Workspace.Walls)
			WallSide2.CFrame = CFrame.new(Vector3.new(MP.X, MP.Y, MP.Z), P1.Position) * CFrame.new(-0.1, 0, 0)
			WallSide2.Size = Vector3.new(0.2, 8, Mag)
			WallSide2.Transparency = .4
			WallSide2.Anchored = true
			WallSide2.BrickColor = BrickColor.new("Bright orange")
			WallS2 = WallSide2
			for _, Side in ipairs(Surfaces) do
				WallSide2[Side] = Enum.SurfaceType.SmoothNoOutlines
			end
		else
			P2Placed = true
			local P1Pos, P2Pos = P1.Position, P2.Position
			Remotes.Build:FireServer(P1Pos, P2Pos, Wall, WallS1, WallS2, Surfaces) -- Build plez...
			wait(0.1)
			P1:Destroy() P2:Destroy()
			P1 = nil P2 = nil
			P1Placed = false P2Placed = false
			Wall:Destroy() WallS1:Destroy() WallS2:Destroy()
			Wall = nil WallS1 = nil WallS2 = nil
		end
	else
	end
end)

Mouse.KeyDown:connect(function(Key)
	if Key == "f" then
		if SelectedBuilding == 4 then
			SelectedBuilding = 1
		else
			SelectedBuilding = SelectedBuilding + 1
		end
		script.BuildMode.Title.Text = "BM: " .. BuildModes[SelectedBuilding].BName
	elseif Key == "q" and (P1 ~= nil) then
		
		P1:Destroy() P2:Destroy()
		P1 = nil P2 = nil
		P1Placed = false P2Placed = false
		Wall:Destroy() WallS1:Destroy() WallS2:Destroy()
		Wall = nil WallS1 = nil WallS2 = nil
		
	end
end)

while wait(0.03) do
	local MousePos = Mouse.Hit
	local Target = Mouse.Target
	local TargetFilter = game.Workspace.Walls
	Mouse.TargetFilter = TargetFilter
	if SelectedBuilding == BuildModes[2].Value then
	elseif SelectedBuilding == BuildModes[3].Value then
		
	elseif SelectedBuilding == BuildModes[4].Value then
		if Wall ~= nil and P1 ~= nil then
			local Mag = (P1.Position - P2.Position).magnitude
			local MP = P1.Position:Lerp(P2.Position, 0.5) -- Get the middle point
			
			
			Wall.CFrame = CFrame.new(Vector3.new(MP.X, MP.Y, MP.Z), P1.Position) * CFrame.new(0, 0, 0)
			Wall.Size = Vector3.new(0.45, 8, Mag)
			
			WallS1.CFrame = CFrame.new(Vector3.new(MP.X, MP.Y, MP.Z), P1.Position) * CFrame.new(0.1, 0, 0)
			WallS1.Size = Vector3.new(0.2, 8, Mag)
			
			WallS2.CFrame = CFrame.new(Vector3.new(MP.X, MP.Y, MP.Z), P1.Position) * CFrame.new(-0.1, 0, 0)
			WallS2.Size = Vector3.new(0.2, 8, Mag)
		else
		end
		
		if (P1Placed == true and P2Placed == false) and Target.Name == "Baseplate" then
			local BP = Vector3.new(math.floor(MousePos.X), math.floor(MousePos.Y), math.floor(MousePos.Z))
			P2.CFrame = CFrame.new(BP.X, BP.Y + 4, BP.Z)
		end
	end
end
