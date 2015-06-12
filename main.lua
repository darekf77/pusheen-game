require 'conf'
require 'game';

local game	



function love.load()
	game = Game:new()
	game:initFriendEnemies()
	game:initEnemies()
	game:initPlayer()
	game:initLabels()
	print('READY TO DRAW')
end

function love.mousepressed(x, y, button)
	if game.buttonPLAY:isActive() then
		if game.buttonPLAY:checkIsClicked(x,y) then
			game = Game:new()
			game:initFriendEnemies()
			game:initEnemies()
			game:initPlayer()
			game:initLabels()
			game.state = 1
		end
	end

	if game.buttonPLAYAGAIN:isActive() then
		if game.buttonPLAYAGAIN:checkIsClicked(x,y) then
			game = Game:new()
			game:initFriendEnemies()
			game:initEnemies()
			game:initPlayer()
			game:initLabels()
			game.state = 1
		end
	end

	if game.buttonQUIT:isActive() then
		if game.buttonQUIT:checkIsClicked(x,y) then
			love.event.quit()
		end
	end
end

function love.keypressed(key)
   if key == 'escape' then
      love.event.quit()
   end
end

-- function love.update(dt)
-- 	 if not game:getIsGameOver() then
-- 	 	game:drawFriendEnemies();
-- 		game:drawEnemies();
-- 	 end
-- end




function love.draw()



	if game:getIsMenu() then
		game:updateMenu();
		-- print('menu')
	end

	if game:getIsPlaying() then

		game:updateBackground();
		game:updateFriendEnemies();
		game:updateEnemies();
		game:updatePlayer();
		game:collizionDetection(); 
		game:updateLabels()
		-- print('play')
		

	end

	if game:getIsGameOver() then
		game:updateMenuGameOver()
		-- print('isover')

	end
	
	if game:getIsWin() then
		game:updateMenuWin()
		-- print('menu win')
	end




	-- game:updateBackground();
	-- if not game:getIsGameOver() then
	-- 	game:updateFriendEnemies();
	-- 	game:updateEnemies();
	-- 	game:updatePlayer();
	-- 	game:collizionDetection();  
	-- end
	-- game:updateLabels();   
end





function love.quit()
  print("Thanks for playing! Come back soon!")
end