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
GameMap.tmxNode = nil

function GameMap:ctor()
	GameMap.mapId = 0
	GameMap.tmxNode = nil
end

-- 使用地图编号初始化gamemap
function GameMap:setup(mapId)
	self.mapId = mapId
	self.tmxNode = CCTMXTiledMap:create(GameMap.BaseFolder..tostring(mapId)..GameMap.FileExtensionName)
	
end