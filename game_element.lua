require 'class_yet'


screen_width = 1024
screen_height = 608


GameElement = newclass('GameElement');
function GameElement:init(pathToImage, pos_x, pos_y, size_x, size_y)	
	self.pos_x = pos_x;
    self.pos_y = pos_y;

    self.size_x = size_x;
    self.size_y = size_y; 
	if pathToImage == nil then
		print('ERROR pathToImage == nil');
		return;
	end 
	if love.filesystem.exists(pathToImage) then
		-- print('plik '..pathToImage..' JEST')
		-- print('pathToImage = '..tostring(pathToImage))
		self.img = love.graphics.newImage( tostring(pathToImage) )
	   	
	   	if self.img:getWidth() ~= nil then
	   		self.size_x = self.img:getWidth()
	   	end 
	   	if self.img:getHeight() ~= nil then
	   		self.size_y = self.img:getHeight()
	   	end    
	    
	    self.isHidden = false;
	else 
		print('ERROR pliku '..pathToImage..' NIEMA')
		love.event.quit()
	end
	
end




function GameElement:setVisible()
	self.isHidden = false
end
function GameElement:setInvisible()
	self.isHidden = true
end
function GameElement:getIsVisible()
	return not self.isHidden
end
function GameElement:getSizeX()
	return self.size_x
end
function GameElement:getSizeY()
	return self.size_y
end
function GameElement:getPosX()
	return self.pos_x
end
function GameElement:getPosY()
	return self.pos_y
end
function GameElement:setPosX( pos_x )
	self.pos_x=pos_x
end
function GameElement:setPosY( pos_y )
	self.pos_y=pos_y
end
function GameElement:getScreenWidth()
	return screen_width
end
function GameElement:getScreenHeight()
	return screen_height
end
function GameElement:updateImage() 
	if not self.isHidden then 
		if self.img == nil then 
			print('ERROR self.img == nil');
			return;
		else 
			-- print('self.img NOT NILLL')
		end
		if self.pos_x == nil or self.pos_y == nil   then 
			print('ERROR self.pos == nil');
			return;
		else 
			-- print('self.pos NOT NILLL')
		end
		-- print('Posx '..self.pos_x..' Posy '..self.pos_y )
		love.graphics.draw(self.img, self.pos_x, self.pos_y )
	end
end