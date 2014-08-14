--
-- Author: SureBrz
-- Date: 2014-08-12 09:36:14
--
Player = class("Player")
Player.x = 0
Player.y = 0
Player.d = 0
function Player:ctor(x, y, d)
	self.x = x
	self.y = y
	self.d = d
end
W = 16
H = 16
Map = class("Map")
Map.data = {
	{0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
}

-- 取得ray光线投射后的矩形数组
function Map.cast(player, angle, range)
	local rayInfo = {x = player.x, y = player.y, height = 0, distance = 0}
	local extraInfo = {sin = math.sin(angle), cos = math.cos(angle), noWall = {length2 = math.inte}}
	return Map.ray(rayInfo, extraInfo)
end

function Map.ray(rayInfo, extraInfo)
	
end

Light3DTestScene = class("Light3DTestScene", function()
	return display.display.newScene("Light3DTestScene")
end)

Light3DTestScene.drawNode = nil

function Light3DTestScene:ctor()
	-- 画布
	self.drawNode = CCDrawNode:create()

end

function Light3DTestScene:update(dt)
	self:drawMap()
end

function Light3DTestScene:drawMap()

end

return Light3DTestScene