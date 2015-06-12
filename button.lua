require 'game_element'

Button = newclass('Button');
function Button:init( posx, posy, width, height, label )
	self.label = label;
	self.posx = posx;
	self.posy = posy;
	self.width = width;
	self.height = height;
	self.active = true;
	self.clicked = false;
		
end

function Button:checkIsClicked(x,y)
	return ( x >= self.posx and x <= self.posx + self.width 
		and y >= self.posy and y <= self.posy + self.height 	)
end

function Button:update()
	
	love.graphics.print( self.label, self.posx, self.posy )		
end

function Button:setIsActive( activeactive )
	self.active = active;
end

function Button:isActive()
	return self.active;
end

function Button:isClicked()
	return self.clicked;
end
