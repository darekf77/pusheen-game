require 'enemy'

HeartBroken = newclass('HeartBroken',Enemy)
function HeartBroken:init(i)

	local x = math.floor( math.random(0,self.getScreenWidth()) )
	local y = math.floor( (-1)*math.random(1, self.getScreenHeight()) )
	print('ENEMY bad x = '..x..' y '..y)
	-- love.event.quit()
	self.super:init("data/images/brokenheart.png",x,y,50,50,i)
end	