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

function GameCharacter:ctor()
	self.currentWalkStates = {GameCharacter.WALK_STATES.IDLE}
	self.spX = 0.0
	self.spY = 0.0
	self.x = 0
	self.y = 0
	self.real_x = 0.0
	self.real_y = 0.0
	self.mainColor = GameCharacter.COLORS.NONE
end
-- 取当前方向
function GameCharacter:currDs()
	-- local res = {}
	-- table.insert(res, (self.spX >= 0.0 and DIRECTIONS.RIGHT) or DIRECTIONS.LEFT)
	-- table.insert(res, (self.spY >= 0.0 and DIRECTIONS.UP) or DIRECTIONS.DOWN)
	-- return res
	return {self:dirX(), self:dirY()}
end

-- 当前横向方向
function GameCharacter:dirX()
	return (self.spX >= 0.0 and DIRECTIONS.RIGHT) or DIRECTIONS.LEFT
end

-- 当前纵向方向
function GameCharacter:dirY()
	(self.spY >= 0.0 and DIRECTIONS.UP) or DIRECTIONS.DOWN
end

-- 根据主角实际坐标取得对应的地图图块坐标
function GameCharacter:adjustXY()
	self.x = (self.real_x - (self.real_x % GameData.gameMap.TILE_WIDTH)) / GameData.gameMap.TILE_WIDTH
	self.y = GameData.gameMap.height - (self.real_y - (self.real_y % GameData.gameMap.TILE_HEIGHT)) / GameData.gameMap.TILE_HEIGHT
end

-- 更新横向速度
function GameCharacter:refreshSpX()
	self:adjustXY()
	
end

-- 更新纵向速度
function GameCharacter:refreshSpY()
	self:adjustXY()

end
