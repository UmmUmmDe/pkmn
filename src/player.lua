require("src.tween")

Player = class("Player", {
	x = 0,
	y = 0,
	tx = nil,
	ty = nil,
	tween = nil,
	sprite = nil,
	inventory = {},
	party = {},
	quad = nil,
	speed = 100,
	lastDir = false
})

function Player:init(sprite)
	self.sprite = sprite
	self.quad = lg.newQuad(0, 0, 32, 32, 32 * 4, 32 * 4)
	table.insert(map.entities, self)
end

function Player:draw()
	local x, y = 0, 0
	if self.tween then
		x, y = self.tween.dx, self.tween.dy
		local xx, yy = self.tween.x - self.tween.tx, self.tween.y - self.tween.ty
		if xx < 0 then
			x = x - TILE
		elseif xx > 0 then
			x = x + TILE
		end
		if yy < 0 then
			y = y - TILE
		elseif yy > 0 then
			y = y + TILE
		end
	end
	x, y = math.floor(x), math.floor(y)
	if self.sprite then
		lg.draw(res.res[self.sprite], self.quad, x, y)
	else
		lg.rectangle("fill", x, y, TILE, TILE)
	end
end

function Player:update(dt, map)
	if self.tween and self.tween.done then
		self.tween = nil
	elseif not self.tween then
		local x, y = 0, 0
		if lk.isDown("w") then
			y = y - 1
		end
		if lk.isDown("s") then
			y = y + 1
		end
		if lk.isDown("a") then
			x = x - 1
		end
		if lk.isDown("d") then
			x = x + 1
		end
		if x ~= 0 or y ~= 0 then
			if x ~= 0 and y ~= 0 then
				if lastDir then
					x = 0
				else
					y = 0
				end
			end
			lastDir = x ~= 0
			if not map:isSolid(self.x + x, self.y + y) then
				self.tween = Tween(self.x * TILE, self.y * TILE, self.x * TILE + x * TILE, self.y * TILE + y * TILE, self.speed)
				self.x = self.x + x
				self.y = self.y + y
			end
		end
	end
end
