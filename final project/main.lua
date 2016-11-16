local physics = require("physics");
physics.start();
physics.setDrawMode("hybrid");
physics.setGravity(0,0);

local Enemy = require ("Enemy");
local soundTable=require("soundTable");
local Square = require ("Square");
local Triangle = require ("Triangle");
local CollisionFilters = require("CollisionFilters");
--- Arena

local top = display.newRect(0,-30,display.contentWidth, 20);
local bottom = display.newRect(0,display.contentHeight-30, 
				display.contentWidth*100, 20);
bottom.tag = "bottom";
top.anchorX = 0;top.anchorY = 0;
bottom.anchorX = 0;bottom.anchorY = 0;

physics.addBody( bottom, "static", {filter=CollisionFilters.walls});
physics.addBody( top, "static", {filter=CollisionFilters.walls});


local controlBar = display.newRect (display.contentCenterX, display.contentHeight-65, display.contentWidth, 70);

controlBar:setFillColor(1,1,1,0.5);

---- Main Player

local cube = display.newCircle (display.contentCenterX, display.contentHeight-150, 25);

physics.addBody (cube, "kinematic", {filter=CollisionFilters.player});

local function move ( event )
	 if event.phase == "began" then		
		cube.markX = cube.x 
	 elseif event.phase == "moved" then	 	
	 	local x = (event.x - event.xStart) + cube.markX	 	
	 	
	 	if (x <= 20 + cube.width/2) then
		   cube.x = 20+cube.width/2;
		elseif (x >= display.contentWidth-20-cube.width/2) then
		   cube.x = display.contentWidth-20-cube.width/2;
		else
		   cube.x = x;		
		end

	 end
end

controlBar:addEventListener("touch", move);


-- Projectile 
local cnt = 0;
local function fire (event) 
  if (cnt < 3) then
    cnt = cnt+1;

	local p = display.newCircle (cube.x, cube.y-30, 5);
	p.anchorY = 1;
	p:setFillColor(0,1,0);
	physics.addBody (p, "dynamic", {radius=5, filter=CollisionFilters.bullet} );
	p:applyForce(0, -2, p.x, p.y);

	audio.play( soundTable["shootSound"] );
	

    local function removeProjectile (event)
      if (event.phase=="began") then
	   	 event.target:removeSelf();
         event.target=nil;
         cnt = cnt - 1;

         if (event.other.tag == "enemy") then

         	event.other.pp:hit();
         	
         end
      end
    end
    p:addEventListener("collision", removeProjectile);
  end
end

controlBar:addEventListener("tap", fire)

local function onBottomCollision(event)

	--if(event.other.tag == "shot") then
		--do nothing
		print("hit");
	--else
	    if ( event.phase == "began") then
	        print(  "collision began with " .. event.other.pp.tag )
	        event.other:removeSelf();
            event.other=nil;
	    elseif ( event.phase == "ended" ) then
	        print( ": collision ended with " .. event.other.pp.tag )
	    end
	--end
end
bottom:addEventListener("collision", onBottomCollision);

local scoreText = 
    display.newEmbossedText( "Hit: 0", 200, 50,
                             native.systemFont, 40 );

scoreText:setFillColor( 0,0.5,0 );

local color = 
{
	highlight = {0,1,1},   
	shadow = {0,1,1}  
}
scoreText:setEmbossColor( color );

scoreText.hit = 0;



---- Enemy Creation

local x = Enemy:new({xPos=500, yPos=300});
x:spawn();
x:move();
--x:shoot(500);

local sq = Square:new({xPos=150, yPos=200});
sq:spawn();
sq:move();
--sq:shoot(500);

local sq2 = Square:new({xPos=150, yPos=250});
sq2:spawn();
sq2:move();

local tr = Triangle:new({xPos=25, yPos=300});
tr:spawn();
tr:move();
--tr:shoot(500);
