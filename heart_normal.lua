require 'enemy'

HeartNormal = newclass('HeartNormal',Enemy)
function HeartNormal:init(i)
	local x = math.floor( math.random(0,self.getScreenWidth()) )
	local y = math.floor( (-1)*math.random(1, self.getScreenHeight()) )
	-- print('ENEMY good x = '..x..' y '..y)
	self.super:init("data/images/heart.png",x,y,50,50,i)
end	