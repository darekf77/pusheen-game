require 'game_element'

Enemy = newclass('Enemy', GameElement)
function Enemy:init(img_patch, pos_x, pos_y, size_x, size_y,i)
	self.super:init(img_patch,pos_x,pos_y,size_x,size_y)
	self.num = i
end

function Enemy:updatePosition( speed )	
	
	local xpos =  self.getPosY()	
	if  xpos == nil then	
		print('ERROR self.getPosY() == nill'); return	
	end	
    self:setPosY( xpos + speed );
    if xpos >= self:getScreenHeight() then
    	self:setVisible();		
		self:setPosY(0);
		self:setPosX(
			math.floor(
				math.random(
					1, self:getScreenWidth()
					)
				)
			);	
    end 
end

