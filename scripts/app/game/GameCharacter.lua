--
-- Author: SureBrz
-- Date: 2014-07-19 21:54:14
--
GameCharacter = class("GameCharacter")

-- 移动状态枚举
GameCharacter.WALK_STATES = {
	IDLE,	-- 待机
	WALK,	-- 行走
	JUMP,	-- 跳跃

}
GameCharacter.DIRECTIONS = {
	LEFT,
	UP,
	RIGHT,
	DOWN,
}

-- 颜色种类
GameCharacter.COLORS = {
	NONE,
	BLUE,
	GREEN,
	RED,
	YELLOW
}

-- 行走速度
GameCharacter.WALK_SPEED = 8.0

-- 跳跃初速度
GameCharacter.JUMP_SPEED = 24.0

-- 重力加速度
GameCharacter.G = 9.8

-- 当前移动状态
GameCharacter.currentWalkStates = {GameCharacter.WALK_STATES.IDLE}

-- x方向速度
GameCharacter.spX = 0.0

-- y方向速度
GameCharacter.spY = 0.0

-- 对应的地图图块坐标
GameCharacter.x = 0
GameCharacter.y = 0

-- 实际地图坐标
GameCharacter.real_x = 0.0
GameCharacter.real_y = 0.0

-- 主颜色
GameCharacter.mainColor = GameCharacter.COLORS.NONE

-- 取当前方向
function GameCharacter:currDs()
	local res = {}
	table.insert(res, self.spX >= 0.0 ? GameCharacter.DIRECTIONS.RIGHT : GameCharacter.DIRECTIONS.LEFT)
	table.insert(res, self.spY >= 0.0 ? GameCharacter.DIRECTIONS.UP : GameCharacter.DIRECTIONS.DOWN)
	return res
end

-- 根据主角实际坐标取得对应的地图图块坐标
function GameCharacter:adjustXY()
	self.x = (self.real_x - (self.real_x % GameMap.TILE_WIDTH)) / GameMap.TILE_WIDTH
	self.y = Global.gameMap.height - (self.real_y - (self.real_y % GameMap.TILE_HEIGHT)) / GameMap.TILE_HEIGHT
end