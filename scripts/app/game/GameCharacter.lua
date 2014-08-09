--
-- Author: SureBrz
-- Date: 2014-07-19 21:54:14
--
GameCharacter = class("GameCharacter")

-- 移动状态枚举
GameCharacter.WALK_STATES = {
	IDLE = 0,	-- 待机
	WALK = 1,	-- 行走
	JUMP = 2,	-- 跳跃

}

-- 颜色种类
GameCharacter.COLORS = {
	NONE = 0,
	BLUE = 1,
	GREEN = 2,
	RED = 3,
	YELLOW = 4
}

-- 行走速度
GameCharacter.WALK_SPEED = 8.0

-- 跳跃初速度
GameCharacter.JUMP_SPEED = 13.0

-- 重力加速度
GameCharacter.G = 0.98

-- 当前移动状态
GameCharacter.currentWalkStates = {[GameCharacter.WALK_STATES.IDLE] = true}

-- x方向速度
GameCharacter.spX = 0.0

-- y方向速度
GameCharacter.spY = 0.0

-- 对应的地图图块坐标，左上角为原点
GameCharacter.x = 0
GameCharacter.y = 0

-- 实际地图坐标， 左上角为原点
GameCharacter.real_x = 0.0
GameCharacter.real_y = 0.0

-- 主颜色
GameCharacter.mainColor = GameCharacter.COLORS.NONE

function GameCharacter:ctor()
	self.currentWalkStates = {[GameCharacter.WALK_STATES.IDLE] = true}
	self.spX = 0.0
	self.spY = 0.0
	self.x = 0
	self.y = 0
	self.real_x = 0.0
	self.real_y = 0.0
	self.mainColor = GameCharacter.COLORS.NONE
end
function GameCharacter:setPos(x, y)
	self.x = x
	self.y = y
	self.real_x = x * GameMap.TILE_WIDTH
	self.real_y = y * GameMap.TILE_WIDTH
end
-- 取当前方向
function GameCharacter:currDs()
	return {self:dirX(), self:dirY()}
end

-- 当前横向方向
function GameCharacter:dirX()
	return (self.spX >= 0.0 and DIRECTIONS.RIGHT) or DIRECTIONS.LEFT
end

-- 当前纵向方向
function GameCharacter:dirY()
	return (self.spY >= 0.0 and DIRECTIONS.DOWN) or DIRECTIONS.UP
end

-- 移动
function GameCharacter:move()
	self.real_x = self.real_x + self.spX * ((self:dirX() == DIRECTIONS.RIGHT and 1) or -1)
	self.real_y = self.real_y + self.spY
end
-- 根据主角实际坐标取得对应的地图图块坐标
function GameCharacter:adjustXY()
	self.x = (self.real_x - (self.real_x % GameData.gameMap.TILE_WIDTH)) / GameData.gameMap.TILE_WIDTH
	self.y = (self.real_y - (self.real_y % GameData.gameMap.TILE_HEIGHT)) / GameData.gameMap.TILE_HEIGHT--GameData.gameMap:height() - (self.real_y - (self.real_y % GameData.gameMap.TILE_HEIGHT)) / GameData.gameMap.TILE_HEIGHT
end

-- 更新横向速度
function GameCharacter:refreshSpXAndAjustRealX(spriteWidth)
	-- 判定左右方向上块是否可通行
	if self:dirX() == DIRECTIONS.RIGHT then
		local passable = GameData.gameMap:passable(self.x + 1, self.y)
		print("right:", passable)
		if not passable then 	-- 不可通行
			-- 碰撞判定
			if self.real_x + spriteWidth / 2 >= (self.x + 1) * GameData.gameMap.TILE_WIDTH then
				-- 调整位置
				self.real_x = (self.x + 1) * GameData.gameMap.TILE_WIDTH - spriteWidth / 2

				self.spX = 0
			end
		end
	else
		local passable = GameData.gameMap:passable(self.x - 1, self.y)
		print("left:", passable)
		if not passable then			
			-- 碰撞判定
			if self.real_x - spriteWidth / 2 <= (self.x - 1) * GameData.gameMap.TILE_WIDTH + GameData.gameMap.TILE_WIDTH then
				-- 调整位置
				self.real_x = (self.x - 1) * GameData.gameMap.TILE_WIDTH + GameData.gameMap.TILE_WIDTH + spriteWidth / 2
				-- 重置横向速度
				self.spX = 0
			end
		end
	end
end

-- 更新纵向速度
function GameCharacter:refreshSpYAndAjustRealY(spriteHeight)
	-- 判定脚下块是否可通行，头顶的块永远可通行
	if self:dirY() == DIRECTIONS.DOWN then
		local passable = GameData.gameMap:passable(self.x, self.y + 1)
		print("down:", passable, self.x, self.y, self.spX, self.spY, self.real_x, self.real_y)
		if not passable then 	-- 不可通行
			-- 碰撞判定
			if self.real_y + spriteHeight / 2 >= (self.y + 1) * GameData.gameMap.TILE_HEIGHT then
				-- 调整位置
				self.real_y = (self.y + 1) * GameData.gameMap.TILE_HEIGHT - spriteHeight / 2
				-- 重置纵向速度
				self.spY = 0
			end
		else -- 可通行，应用重力
			if self:dirY() == DIRECTIONS.UP and self:spY() == 0.0 then -- 未跳跃
				-- 脚下是空的，应用重力
				self.spY = GameCharacter.JUMP_SPEED
			else -- 跳跃中
				-- 纵向速度叠加重力
				self.spY = self.spY + GameCharacter.G
			end
		end
	else
		self.spY = self.spY + GameCharacter.G
	end
end
