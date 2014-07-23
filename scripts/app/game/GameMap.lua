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

-- 事件组
GameMap.events = nil

-- 显示用的坐标
GameMap.displayX = 0.0
GameMap.displayY = 0.0

function GameMap:ctor()
	self.mapId = 0
	self.tmxMap = nil

	self.events = {}

	self.displayX = 0.0
	self.displayY = 0.0
end

-- 使用地图编号初始化gamemap
function GameMap:setup(mapId)
	self.mapId = mapId
	self.tmxMap = CCTMXTiledMap:create(GameMap.BaseFolder..tostring(mapId)..GameMap.FileExtensionName)
	
	self.events = self.tmxMap:objectGroupNamed("events")
	dump(self.events)
end