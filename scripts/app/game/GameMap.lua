--
-- Author: SureBrz
-- Date: 2014-07-20 00:09:59
--
GameMap = class("GameMap")
GameMap.BaseFolder = "map/"
GameMap.FileExtensionName = ".tmx"
-- 图块大小定义
GameMap.TILE_WIDTH = 32
GameMap.TILE_HEIGHT = 32

-- 当前地图信息
GameMap.mapId = 0
GameMap.tmxMap = nil

-- 事件层
GameMap.events = nil
-- 图块层
GameMap.tilemapLayers = nil

-- 显示用的坐标
GameMap.displayX = 0.0
GameMap.displayY = 0.0

function GameMap:ctor()
	self.mapId = 0
	self.tmxMap = nil

	self.events = nil
	self.tilemapLayers = nil

	self.displayX = 0.0
	self.displayY = 0.0
end

-- 使用地图编号初始化gamemap
function GameMap:setup(mapId)
	self.mapId = mapId
	self.tmxMap = CCTMXTiledMap:create(GameMap.BaseFolder..tostring(mapId)..GameMap.FileExtensionName)
	
	self.events = self.tmxMap:objectGroupNamed("events")
	dump(self.events)
	self.tilemapLayers = {self.tmxMap:layerNamed("layer1"), self.tmxMap:layerNamed("layer2"), self.tmxMap:layerNamed("layer3")}
	dump(self.tilemapLayers)
	print(self.tmxMap:getMapSize().width, self.tmxMap:getMapSize().height)
	self:passable(22, 7)
end

-- 取得地图大小
function GameMap:width()
	return self.tmxMap:getMapSize().width
end
function GameMap:height()
	return self.tmxMap:getMapSize().height
end

-- 指定坐标的可通行度
function GameMap:passable(x, y)
	for i = 1, 3 do
		local gid = self.tilemapLayers[i]:tileGIDAt(ccp(x, y))
		if gid ~= 0 then
			local prop = self.tmxMap:propertiesForGID(gid)
			if prop and prop:objectForKey("passable") and prop:objectForKey("passable"):getCString() == "0" then
				return false
			end
		end
	end
	return true
end