require 'game_element'
require 'heart_normal'
require 'heart_broken'
require 'player'
require 'button'

local game_state = {
	menu = 0,
	play = 1,
	win = 2,
	loose = 3
};	








print('state ='.. game_state.play);


Game = newclass('Game',GameElement)

function Game:init()
	self.super:init("data/images/tlo.png",0,0,
		self:getScreenWidth(),self:getScreenHeight());
    -- size(screen_width,screen_height);
    -- smooth();
	love.mouse.setVisible(false)
	self.mHowManyFriendEnemies = 5
	self.mHowManyEnemies = 5
	self.state = game_state.menu
	-- self.isEnd = false;
	self.sLoose = "";
	self.sWin = "";
	self.mFriend = {}
	self.mEnemy = {}
	self.buttonPLAY = Button:new( self.getScreenWidth()/2-50, self.getScreenHeight()/2-100,300,100,"PLAY")
	self.buttonPLAYAGAIN = Button:new( self.getScreenWidth()/2-100, self.getScreenHeight()/2-100,300,100,"PLAYAGAIN")
	self.buttonQUIT = Button:new( self.getScreenWidth()/2-50, self.getScreenHeight()/2,300,100,"QUIT")

	self.mainFont = love.graphics.newFont("data/BrainFlowerEuro.ttf", 20);
	-- print('GAME CONSTRUCTOR')
end

function getPLAYbutton()
	return self.buttonPLAY;
end

function getPLAYAGAINbutton()
	return self.buttonPLAYAGAIN;
end

function getQUITbutton()
	return self.buttonQUIT;
end

function Game:getIsGameOver()

	return ( self.state == game_state.loose ) -- self.isEnd;
end

function Game:getIsMenu()

	return ( self.state == game_state.menu ) -- self.isEnd;
end

function Game:getIsPlaying()

	return ( self.state == game_state.play ) -- self.isEnd;
end

function Game:getIsWin()

	return ( self.state == game_state.win ) -- self.isEnd;
end



function Game:GameOver()
	--self.isEnd = true;
	print('is over')
	self.state = game_state.loose
    self.sLoose = "I'M SORRY, YOU LOOSE ...";
    love.mouse.setVisible(true)
end

function Game:Win()
	--self.isEnd = true;
	self.state = game_state.win;
    self.sWin = "EXCELENT, YOU WIN !";
    love.mouse.setVisible(true)
end

function Game:initFriendEnemies() 
	

    for i=0,(self.mHowManyFriendEnemies-1) do
    	self.mFriend[i] = HeartNormal:new(i);	
    end
end


function Game:initEnemies() 

    for i=0,(self.mHowManyEnemies-1) do
    	self.mEnemy[i] = HeartBroken:new(i);	
    end
end

function Game:initPlayer()
	local playerX = math.floor(self.getScreenWidth()/2);
	local playerY = self.getScreenHeight()-170;
	-- print('playe pos x'..playerX)
	-- print('playe pos y'..playerY)
--	return;
	self.player = Player:new("data/images/pusheen.png",
		playerX,playerY,0,249,5)
end

function Game:updateBackground()
	self.updateImage();
end


function Game:updatePlayer()
	-- print('UPDATE PLAYER')
	self.player:updatePosition();   
end


function Game:updateFriendEnemies()
	for i=0,(self.mHowManyFriendEnemies-1) do	
		-- print('Update friend '..i)	
		self.mFriend[i]:updateImage();
		self.mFriend[i]:updatePosition(2);
	end
end

function Game:updateEnemies()
	for i=0,(self.mHowManyEnemies-1) do
		-- print('Update enemyd '..i)	
		self.mEnemy[i]:updateImage();
		self.mEnemy[i]:updatePosition(2);
	end
end

-- function Game:drawFriendEnemies()
-- 	for i=0,(self.mHowManyFriendEnemies-1) do	
-- 		-- print('Update friend '..i)	
		
-- 	end
-- end

-- function Game:drawEnemies()
-- 	for i=0,(self.mHowManyEnemies-1) do
-- 		-- print('Update enemyd '..i)	
		
-- 	end
-- end

function Game:isCollision(elem1, elem2)
	
	if elem1 == nil or elem2 == nil then
		return;
	end
	-- print('elem 1 '..type(elem1)..' elem2 '..type(elem2))
	-- print('elem1.getPosX()'..elem1:getPosX())
	-- print('elem1.getSizeX()'..elem1:getSizeX())
	-- print('elem2.getPosX()'..elem2:getPosX())

	if 	elem1:getPosX() + elem1:getSizeX() > elem2:getPosX() 
		and elem1:getPosX() < elem2:getPosX() + elem2:getSizeX() 
		and elem1:getPosY() + elem1:getSizeY() > elem2:getPosY() 
		and elem1:getPosY() < elem2:getPosY() + elem2:getSizeY() 
      	and elem2:getIsVisible() 
      	then
	  	return true;
	else 
		return false
	end
end

function Game:collizionDetection() 

    for i = 0,self.mHowManyEnemies-1 do

        if self:isCollision(self.player,self.mEnemy[i]) then
			self.player:takeLife();
			self.mEnemy[i]:setInvisible();
			if self.player:getLifes()==0 then  
				self:GameOver();
			end
        end
    end

    for i = 0, self.mHowManyFriendEnemies-1 do
      if self:isCollision(self.player,self.mFriend[i]) then
        self.player:increasePoints();
        self.mFriend[i]:setInvisible();
        if self.player:getPoints()==100 then  
        	self:Win();
        end
      end
    end

end

function Game:initLabels()
    self.mLabelPoints = love.graphics.newFont("data/BrainFlowerEuro.ttf",52);
    self.mLabelLifes = love.graphics.newFont("data/BrainFlowerEuro.ttf",52);
    self.mLabelWinnerMessage = love.graphics.newFont("data/BrainFlowerEuro.ttf",72);
    self.mLabelLooserMessage = love.graphics.newFont("data/BrainFlowerEuro.ttf",72);

    self.menuNewGame = love.graphics.newFont("data/BrainFlowerEuro.ttf",72);
--     -- fill(50);
end




function Game:updateLabels() 
	love.mouse.setVisible(true)
	myColor = {0, 0,0, 155}
	love.graphics.setColor(myColor)


	love.graphics.setFont(self.mLabelPoints)
    love.graphics.print(self.player:getPoinstStr(),100,100)

    love.graphics.setFont(self.mLabelLifes)
    love.graphics.print(self.player:getLifesStr(),100,150)

    

    


   	myColor = {255, 255,255, 255}
	love.graphics.setColor(myColor)
end

function Game:updateMenu()

	love.mouse.setVisible(true)
	myColor = {255, 255, 255, 155}
	love.graphics.setColor(myColor) 
	love.graphics.setFont( self.menuNewGame )

	-- if self.buttonPLAY:isActive() then
	-- 	if self.buttonPLAY:isClicked() then
	-- 		print('PLAY')
	-- 	end
	-- end 

	-- if self.buttonPLAYAGAIN:isActive() then
	-- 	if self.buttonPLAYAGAIN:isClicked() then
	-- 		print('PLAY AGAIN')
	-- 	end
	-- end 

	-- if self.buttonQUIT:isActive() then
	-- 	if self.buttonQUIT:isClicked() then
	-- 		print('QUIT')			
	-- 	end
	-- end 

	--self.buttonPLAYAGAIN:update()
	self.buttonPLAY:update()
	self.buttonQUIT:update()

    myColor = {255, 255,255, 255}
	love.graphics.setColor(myColor)


end

function Game:updateMenuGameOver()

	love.mouse.setVisible(true)
	myColor = {255, 255, 255, 155}
	love.graphics.setColor(myColor)
	love.graphics.setFont(self.menuNewGame)   


	self.buttonPLAYAGAIN:update()
	--self.buttonPLAY:update()
	self.buttonQUIT:update()

	love.graphics.setFont(self.mLabelLooserMessage)   
    love.graphics.print(self.sLoose,
    	self.getScreenWidth()/2-200, self.getScreenHeight()/2-200)

	-- love.graphics.print("GAME OVER",
 --    	self.getScreenWidth()/2-50, self.getScreenHeight()/2-200)
 --    love.graphics.print("PLAY AGAIN",
 --    	self.getScreenWidth()/2-50, self.getScreenHeight()/2-100)
 --    love.graphics.print("QUIT",
 --    	self.getScreenWidth()/2-50, self.getScreenHeight()/2)

    myColor = {255, 255,255, 255}
	love.graphics.setColor(myColor)
end

function Game:updateMenuWin()

	love.mouse.setVisible(true)
	myColor = {255, 255, 255, 155}
	love.graphics.setColor(myColor)
	love.graphics.setFont(self.menuNewGame)   

    -- love.graphics.print("YOU WIN ! :)",
    -- 	self.getScreenWidth()/2-50, self.getScreenHeight()/2-200)
    -- love.graphics.print("PLAY AGAIN",
    -- 	self.getScreenWidth()/2-50, self.getScreenHeight()/2-100)
    -- love.graphics.print("QUIT",
    -- 	self.getScreenWidth()/2-50, self.getScreenHeight()/2)
	

	love.graphics.setFont(self.mLabelWinnerMessage)
   	love.graphics.print(self.sWin,
    	self.getScreenWidth()/2-200, self.getScreenHeight()/2-200) 

	self.buttonPLAYAGAIN:update()
	--self.buttonPLAY:update()
	self.buttonQUIT:update()

    myColor = {255, 255,255, 255}
	love.graphics.setColor(myColor)
	
end



