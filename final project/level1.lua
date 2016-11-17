local composer = require( "composer" )

local scene = composer.newScene();

local physics = require("physics");
physics.start();
physics.setDrawMode("hybrid");
physics.setGravity(0,0);

local Enemy = require ("Enemy");
local soundTable=require("soundTable");
local Square = require ("Square");
local Triangle = require ("Triangle");
local CollisionFilters = require("CollisionFilters");

local top;
local bottom;
local controlBar;


-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------




-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
	
	top = display.newRect(0,10,display.contentWidth*100, 20);
	bottom = display.newRect(0,-30, display.contentWidth*100, 2);
	bottom.tag = "bottom";
	top.anchorX = 0;top.anchorY = 0;
	bottom.anchorX = 0;bottom.anchorY = 0;
	
	physics.addBody( bottom, "static", {filter=CollisionFilters.walls});
	physics.addBody( top, "static", {filter=CollisionFilters.walls});
	
	controlBar = display.newRect(display.contentCenterX,display.contentHeight-65,display.contentWidth,70);
	controlBar:setFillColor(1,1,1,0.5);
	
	sceneGroup:insert(top);
	sceneGroup:insert(bottom);
	sceneGroup:insert(controlBar);

end


-- show()
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
		

    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen

    end
end


-- hide()
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)

    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen

    end
end


-- destroy()
function scene:destroy( event )

    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view

end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene