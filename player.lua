require 'game_element'

Player = newclass('Player', GameElement)
function Player:init(patchToImg, pos_x, pos_y, size_x, size_y, lifes)
	self.super:init(patchToImg,pos_x,pos_y,size_x,size_y)
	self.lifes = lifes
	self.points = 0
end


function Player:updatePosition()
   self:updateImage()
   -- print('(love.mouse.getX()'..love.mouse.getX())
   self:setPosX(love.mouse.getX());
end
function Player:increasePoints()
	self.points = self.points+1
end
function Player:getPoinstStr()
	return ("POINTS: "..self.points)
end
function Player:getLifesStr()
	return ("LIFES: "..self.lifes)
end
function Player:getPoints()
	return self.points
end
function Player:getLifes()
	return self.lifes
end
function Player:takeLife()
	self.lifes = self.lifes - 1
end

