local composer = require( "composer" )

local scene = composer.newScene();

local physics = require("physics");
physics.start();
--physics.setDrawMode("hybrid");
physics.setGravity(0,0);

local widget = require("widget");
local Enemy = require ("Enemy");
local tower = require ("tower");
local goldTower = require ("goldTower");
local blueTower = require ("blueTower");
local soundTable=require("soundTable");
local Square = require ("Square");
local Triangle = require ("Triangle");
local CollisionFilters = require("CollisionFilters");
local data = require("data");
local ImageSheet = require("ImageSheet");
local instructionText;

-- Menu
local nextBtn;
local towerBtn;
local itemTab;
local scoreText;

--Tower Buttons
local towerPlacementbtn1;
local towerPlacementbtn2;
local towerPlacementbtn3;
local towerPlacementbtn4;

local baseHP;

--Function
local towerPurchase;
local towerOption2 = {};
local roundEnd;

local cube;

local towerOptionbtn1;
local towerOption2 = {};

local towerPlacement1 = {};
local towerPlacement2 = {};
local towerPlacement3 = {};
local towerPlacement4 = {};

towerPlacement1.contains = 0;
towerPlacement2.contains = 0;
towerPlacement3.contains = 0;
towerPlacement4.contains = 0;

-- game variables
local itemSelected = 0;
local round = 1;
data.enemyCount = round;
print(data.enemyCount)

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
	


--ARENA
top = display.newRect(0,10,display.contentWidth*100, 2);
bottom = display.newRect(0,display.contentHeight+1, display.contentWidth*100, 500);
bottom.tag = "bottom";
top.anchorX = 0;top.anchorY = 0;
bottom.anchorX = 0;bottom.anchorY = 0;

physics.addBody( bottom, "kinematic", {filter=CollisionFilters.walls});
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
	
	nextBtn = widget.newButton(
	{
		x = display.contentWidth/1.3,
		y = display.contentHeight/3,
		width = 350,
		height = 291,
		defaultFile = "meteorGrey_big3.png",
		id = "startBtn",
		label = "Next",
		labelColor = { default={ 1, 1, 1 }},
		fontSize = 75,
		onEvent = roundStart
	}
	)
	nextBtn.isVisible = false;
	
	towerBtn = widget.newButton(
		{
			x = display.contentWidth/3.3,
			y = display.contentHeight/3,
			width = 350,
			height = 291,
			defaultFile = "meteorGreen_big3.png",
			id = "towerBtn",
			label = "Towers",
			labelColor = { default={ 1, 1, 1 }},
			fontSize = 75,
			onEvent = towerPage
		}
	)
	towerBtn.isVisible = false;
	
towerOptionbtn1 = widget.newButton(
{
	x = display.contentWidth/1.5,
	y = display.contentHeight/1.8,
	id = "option1",
	--optionNum = 1,
	label = "Damage Tower",
	onEvent = towerPurchase,
	emboss = false,
	shape = "roundedRect",
	width = display.contentWidth/10,
	height = display.contentHeight/16,
	cornerRadius = 2,
	fillColor = { default={1,0,0,1}, over={1,0.1,0.7,0.4} },
    strokeColor = { default={1,0.4,0,1}, over={0.8,0.8,1,1} },
    strokeWidth = 4
});
towerOptionbtn1.isVisible = false;
sceneGroup:insert(towerOptionbtn1);
	
towerOptionbtn2 = widget.newButton(
{
	x = display.contentWidth/3.1,
	y = display.contentHeight/1.8,
	id = "option2",
	--optionNum = 2,
	label = "Gold Tower",
	onEvent = gTowerPurchase,
	emboss = false,
	shape = "roundedRect",
	width = display.contentWidth/10,
	height = display.contentHeight/16,
	cornerRadius = 2,
	fillColor = { default={1,0,0,1}, over={1,0.1,0.7,0.4} },
    strokeColor = { default={1,0.4,0,1}, over={0.8,0.8,1,1} },
    strokeWidth = 4
});
towerOptionbtn2.isVisible = false;
sceneGroup:insert(towerOptionbtn2)

towerOptionbtn3 = widget.newButton(
{
	x = display.contentWidth/2,
	y = display.contentHeight/2,
	id = "option3",
	--optionNum = 3,
	label = "Blue Tower",
	onEvent = bTowerPurchase,
	emboss = false,
	shape = "roundedRect",
	width = display.contentWidth/10,
	height = display.contentHeight/16,
	cornerRadius = 2,
	fillColor = { default={0,0,1,1}, over={1,0.1,0.7,0.4} },
    strokeColor = { default={1,0.4,0,1}, over={0.8,0.8,1,1} },
    strokeWidth = 4
});
towerOptionbtn3.isVisible = false;
sceneGroup:insert(towerOptionbtn3)

towerPlacementbtn1 = widget.newButton(
{
	x = display.contentWidth/6,
	y = display.contentHeight/1.2,
	id = "towerBtn1",
	--optionNum = 2,
	label = " ",
	onEvent = towerCreate,
	emboss = false,
	shape = "circle",
	radius = display.contentWidth/14,
	fillColor = { default={1,0,0,1}, over={1,0.1,0.7,0.4} },
    strokeColor = { default={1,0.4,0,1}, over={0.8,0.8,1,1} },
    strokeWidth = 4
});
towerPlacementbtn1.isVisible = false;
sceneGroup:insert(towerPlacementbtn1);

towerPlacementbtn2 = widget.newButton(
{
	x = display.contentWidth/3.4,
	y = display.contentHeight/1.3,
	id = "towerBtn2",
	--optionNum = 2,
	label = " ",
	onEvent = towerCreate,
	emboss = false,
	shape = "circle",
	radius = display.contentWidth/14,
	fillColor = { default={1,0,0,1}, over={1,0.1,0.7,0.4} },
    strokeColor = { default={1,0.4,0,1}, over={0.8,0.8,1,1} },
    strokeWidth = 4
});
towerPlacementbtn2.isVisible = false;
sceneGroup:insert(towerPlacementbtn2);

towerPlacementbtn3 = widget.newButton(
{
	x = display.contentWidth/1.4,
	y = display.contentHeight/1.3,
	id = "towerBtn3",
	--optionNum = 2,
	label = " ",
	onEvent = towerCreate,
	emboss = false,
	shape = "circle",
	radius = display.contentWidth/14,
	fillColor = { default={1,0,0,1}, over={1,0.1,0.7,0.4} },
    strokeColor = { default={1,0.4,0,1}, over={0.8,0.8,1,1} },
    strokeWidth = 4
});
towerPlacementbtn3.isVisible = false;
sceneGroup:insert(towerPlacementbtn3);

towerPlacementbtn4 = widget.newButton(
{
	x = display.contentWidth/1.15,
	y = display.contentHeight/1.2,
	id = "towerBtn4",
	--optionNum = 2,
	label = " ",
	onEvent = towerCreate,
	emboss = false,
	shape = "circle",
	radius = display.contentWidth/14,
	fillColor = { default={1,0,0,1}, over={1,0.1,0.7,0.4} },
    strokeColor = { default={1,0.4,0,1}, over={0.8,0.8,1,1} },
    strokeWidth = 4
});
towerPlacementbtn4.isVisible = false;
sceneGroup:insert(towerPlacementbtn4);


local function towerCreate(event)

	print(event.target.id);
	if(event.target.id == "towerBtn1") then
		towerPlacement1.contains = 1;
		towerPlacement1.shape = tower:new({xPos=display.contentWidth/6, yPos=display.contentHeight/1.2});
		towerPlacement1.shape:spawn();
		towerPlacement1.shape:shoot(800);

		data.gold = data.gold - 100;
		scoreText.text = "Gold: " .. data.gold;

		towerPlacementbtn1.isVisible = false;
		towerPlacementbtn1:removeEventListener( "tap", towerCreate);
	elseif(event.target.id == "towerBtn2")then
		towerPlacement2.contains = 1;
		towerPlacement2.shape = tower:new({xPos=display.contentWidth/3.4, yPos=display.contentHeight/1.3});
		towerPlacement2.shape:spawn();
		towerPlacement2.shape:shoot(800);

		data.gold = data.gold - 100;
		scoreText.text = "Gold: " .. data.gold;

		towerPlacementbtn2.isVisible = false;
		towerPlacementbtn2:removeEventListener( "tap", towerCreate);
	elseif(event.target.id == "towerBtn3")then
		towerPlacement3.contains = 1;
		towerPlacement3.shape = tower:new({xPos=display.contentWidth/1.4, yPos=display.contentHeight/1.3});
		towerPlacement3.shape:spawn();
		towerPlacement3.shape:shoot(800);

		data.gold = data.gold - 100;
		scoreText.text = "Gold: " .. data.gold;

		towerPlacementbtn3.isVisible = false;
		towerPlacementbtn3:removeEventListener( "tap", towerCreate);
	elseif(event.target.id == "towerBtn4")then
		towerPlacement4.contains = 1;
		towerPlacement4.shape = tower:new({xPos=display.contentWidth/1.15, yPos=display.contentHeight/1.2});
		towerPlacement4.shape:spawn();
		towerPlacement4.shape:shoot(800);

		data.gold = data.gold - 100;
		scoreText.text = "Gold: " .. data.gold;

		towerPlacementbtn4.isVisible = false;
		towerPlacementbtn4:removeEventListener( "tap", towerCreate);
	end

	if(towerPlacement1.contains == 0) then
		towerPlacementbtn1.isVisible = false;
		towerPlacementbtn1:removeEventListener( "tap", towerCreate);
	end

	if(towerPlacement2.contains == 0) then
		towerPlacementbtn2.isVisible = false;
		towerPlacementbtn2:removeEventListener( "tap", towerCreate);
	end

	if(towerPlacement3.contains == 0) then
		towerPlacementbtn3.isVisible = false;
		towerPlacementbtn3:removeEventListener( "tap", towerCreate);

	end

	if(towerPlacement4.contains == 0) then
		towerPlacementbtn4.isVisible = false;
		towerPlacementbtn4:removeEventListener( "tap", towerCreate);

	end

end

local function gTowerCreate(event)

	print("made it");
	if(event.target.id == "towerBtn1") then
		towerPlacement1.contains = 1;
		towerPlacement1.shape = goldTower:new({xPos=display.contentWidth/6, yPos=display.contentHeight/1.2});
		towerPlacement1.shape:spawn();
		towerPlacement1.shape:shoot(1200);

		data.gold = data.gold - 200;
		scoreText.text = "Gold: " .. data.gold;

		towerPlacementbtn1.isVisible = false;
		towerPlacementbtn1:removeEventListener( "tap", gTowerCreate);
	elseif(event.target.id == "towerBtn2")then
		towerPlacement2.contains = 1;
		towerPlacement2.shape = goldTower:new({xPos=display.contentWidth/3.4, yPos=display.contentHeight/1.3});
		towerPlacement2.shape:spawn();
		towerPlacement2.shape:shoot(1200);

		data.gold = data.gold - 200;
		scoreText.text = "Gold: " .. data.gold;

		towerPlacementbtn2.isVisible = false;
		towerPlacementbtn2:removeEventListener( "tap", gTowerCreate);
	elseif(event.target.id == "towerBtn3")then
		towerPlacement3.contains = 1;
		towerPlacement3.shape = goldTower:new({xPos=display.contentWidth/1.4, yPos=display.contentHeight/1.3});
		towerPlacement3.shape:spawn();
		towerPlacement3.shape:shoot(1200);

		data.gold = data.gold - 200;
		scoreText.text = "Gold: " .. data.gold;

		towerPlacementbtn3.isVisible = false;
		towerPlacementbtn3:removeEventListener( "tap", gTowerCreate);
	elseif(event.target.id == "towerBtn4")then
		towerPlacement4.contains = 1;
		towerPlacement4.shape = goldTower:new({xPos=display.contentWidth/1.15, yPos=display.contentHeight/1.2});
		towerPlacement4.shape:spawn();
		towerPlacement4.shape:shoot(1200);

		data.gold = data.gold - 200;
		scoreText.text = "Gold: " .. data.gold;

		towerPlacementbtn4.isVisible = false;
		towerPlacementbtn4:removeEventListener( "tap", gTowerCreate);
	end

	if(towerPlacement1.contains == 0) then
		towerPlacementbtn1.isVisible = false;
		towerPlacementbtn1:removeEventListener( "tap", gTowerCreate);
	end

	if(towerPlacement2.contains == 0) then
		towerPlacementbtn2.isVisible = false;
		towerPlacementbtn2:removeEventListener( "tap", gTowerCreate);
	end

	if(towerPlacement3.contains == 0) then
		towerPlacementbtn3.isVisible = false;
		towerPlacementbtn3:removeEventListener( "tap", gTowerCreate);

	end

	if(towerPlacement4.contains == 0) then
		towerPlacementbtn4.isVisible = false;
		towerPlacementbtn4:removeEventListener( "tap", gTowerCreate);

	end
end


local function bTowerCreate(event)

	print(event.target.id);
	if(event.target.id == "towerBtn1") then
		towerPlacement1.contains = 1;
		towerPlacement1.shape = blueTower:new({xPos=display.contentWidth/6, yPos=display.contentHeight/1.2});
		towerPlacement1.shape:spawn();
		towerPlacement1.shape:shoot(500);

		data.gold = data.gold - 100;
		scoreText.text = "Gold: " .. data.gold;

		towerPlacementbtn1.isVisible = false;
		towerPlacementbtn1:removeEventListener( "tap", bTowerCreate);
		
	elseif(event.target.id == "towerBtn2")then
		towerPlacement2.contains = 1;
		towerPlacement2.shape = blueTower:new({xPos=display.contentWidth/3.4, yPos=display.contentHeight/1.3});
		towerPlacement2.shape:spawn();
		towerPlacement2.shape:shoot(500);

		data.gold = data.gold - 100;
		scoreText.text = "Gold: " .. data.gold;

		towerPlacementbtn2.isVisible = false;
		towerPlacementbtn2:removeEventListener( "tap", bTowerCreate);
		
	elseif(event.target.id == "towerBtn3")then
		towerPlacement3.contains = 1;
		towerPlacement3.shape = blueTower:new({xPos=display.contentWidth/1.4, yPos=display.contentHeight/1.3});
		towerPlacement3.shape:spawn();
		towerPlacement3.shape:shoot(500);

		data.gold = data.gold - 100;
		scoreText.text = "Gold: " .. data.gold;

		towerPlacementbtn3.isVisible = false;
		towerPlacementbtn3:removeEventListener( "tap", bTowerCreate);
		
	elseif(event.target.id == "towerBtn4")then
		towerPlacement4.contains = 1;
		towerPlacement4.shape = blueTower:new({xPos=display.contentWidth/1.15, yPos=display.contentHeight/1.2});
		towerPlacement4.shape:spawn();
		towerPlacement4.shape:shoot(500);

		data.gold = data.gold - 100;
		scoreText.text = "Gold: " .. data.gold;

		towerPlacementbtn4.isVisible = false;
		towerPlacementbtn4:removeEventListener( "tap", bTowerCreate);
	end

	if(towerPlacement1.contains == 0) then
		towerPlacementbtn1.isVisible = false;
		towerPlacementbtn1:removeEventListener( "tap", bTowerCreate);
	end

	if(towerPlacement2.contains == 0) then
		towerPlacementbtn2.isVisible = false;
		towerPlacementbtn2:removeEventListener( "tap", bTowerCreate);
	end

	if(towerPlacement3.contains == 0) then
		towerPlacementbtn3.isVisible = false;
		towerPlacementbtn3:removeEventListener( "tap", bTowerCreate);

	end

	if(towerPlacement4.contains == 0) then
		towerPlacementbtn4.isVisible = false;
		towerPlacementbtn4:removeEventListener( "tap", bTowerCreate);

	end

end


local function cancelTowerPurchase(event)
	if(event.target:getLabel() == "Gold Tower")then
		if(itemSelected == 0)then
			print("here I am")
			towerOptionbtn1:addEventListener("tap",towerPurchase);
			towerOptionbtn1:removeEventListener("tap",cancelTowerPurchase);
			towerOptionbtn2:addEventListener("tap",gTowerPurchase);
			towerOptionbtn2:removeEventListener("tap",cancelTowerPurchase);
			towerOptionbtn3:addEventListener("tap",bTowerPurchase);
			towerOptionbtn3:removeEventListener("tap",cancelTowerPurchase);
		else
			print("whaddup")
			if(towerPlacement1.contains == 0) then
				towerPlacementbtn1.isVisible = false;
				towerPlacementbtn1:removeEventListener( "tap", gTowerCreate);
				towerPlacementbtn1:removeEventListener( "tap", towerCreate);
				towerPlacementbtn1:removeEventListener( "tap", bTowerCreate);
			end

			if(towerPlacement2.contains == 0) then
				towerPlacementbtn2.isVisible = false;
				towerPlacementbtn2:removeEventListener( "tap", gTowerCreate);
				towerPlacementbtn2:removeEventListener( "tap", towerCreate);
				towerPlacementbtn2:removeEventListener( "tap", bTowerCreate);
			end

			if(towerPlacement3.contains == 0) then
				towerPlacementbtn3.isVisible = false;
				towerPlacementbtn3:removeEventListener( "tap", gTowerCreate);
				towerPlacementbtn3:removeEventListener( "tap", towerCreate);
				towerPlacementbtn3:removeEventListener( "tap", bTowerCreate);

			end

			if(towerPlacement4.contains == 0) then
				towerPlacementbtn4.isVisible = false;
				towerPlacementbtn4:removeEventListener( "tap", gTowerCreate);
				towerPlacementbtn4:removeEventListener( "tap", towerCreate);
				towerPlacementbtn4:removeEventListener( "tap", bTowerCreate);
			end
			itemSelected = 0;
		end
	else
		if(itemSelected == 0)then
			towerOptionbtn1:addEventListener("tap",towerPurchase);
			towerOptionbtn1:removeEventListener("tap",cancelTowerPurchase);
			towerOptionbtn2:addEventListener("tap",gTowerPurchase);
			towerOptionbtn2:removeEventListener("tap",cancelTowerPurchase);
			towerOptionbtn3:addEventListener("tap",bTowerPurchase);
			towerOptionbtn3:removeEventListener("tap",cancelTowerPurchase);
		else
			print("whaddup")
			if(towerPlacement1.contains == 0) then

				towerPlacementbtn1.isVisible = false;
				towerPlacementbtn1:removeEventListener( "tap", towerCreate);
				towerPlacementbtn1:removeEventListener( "tap", gTowerCreate);
				towerPlacementbtn1:removeEventListener( "tap", bTowerCreate);
			end

			if(towerPlacement2.contains == 0) then
				towerPlacementbtn2.isVisible = false;
				towerPlacementbtn2:removeEventListener( "tap", towerCreate);
				towerPlacementbtn2:removeEventListener( "tap", gTowerCreate);
				towerPlacementbtn2:removeEventListener( "tap", bTowerCreate);
			end

			if(towerPlacement3.contains == 0) then
				towerPlacementbtn3.isVisible = false;
				towerPlacementbtn3:removeEventListener( "tap", towerCreate);
				towerPlacementbtn3:removeEventListener( "tap", gTowerCreate);
				towerPlacementbtn3:removeEventListener( "tap", bTowerCreate);
			end

			if(towerPlacement4.contains == 0) then
				towerPlacementbtn4.isVisible = false;
				towerPlacementbtn4:removeEventListener( "tap", towerCreate);
				towerPlacementbtn4:removeEventListener( "tap", gTowerCreate);
				towerPlacementbtn4:removeEventListener( "tap", bTowerCreate);
			end
			itemSelected = 0;
		end
	end
end

function towerPurchase(event)
	if(itemSelected == 1)then
		towerOptionbtn1:removeEventListener("tap",towerPurchase);
		towerOptionbtn1:addEventListener("tap",cancelTowerPurchase);
		towerOptionbtn2:removeEventListener("tap",gTowerPurchase);
		towerOptionbtn2:addEventListener("tap",cancelTowerPurchase);
		towerOptionbtn3:removeEventListener("tap",bTowerPurchase);
		towerOptionbtn3:addEventListener("tap",cancelTowerPurchase);
	else
		if(data.gold < 100) then
			--do nothing place holder
		else

			local temp = event.target:getLabel();
			print(temp)
			local parameters = {};
			if(towerPlacement1.contains == 0)then

				towerPlacementbtn1:setLabel(temp);
				towerPlacementbtn1.isVisible = true;
				towerPlacementbtn1:addEventListener("tap",towerCreate);

			end

			if(towerPlacement2.contains == 0)then
		
				towerPlacementbtn2:setLabel(temp);
				towerPlacementbtn2.isVisible = true;
				towerPlacementbtn2:addEventListener("tap",towerCreate);
			end

			if(towerPlacement3.contains == 0)then
				towerPlacementbtn3:setLabel(temp);
				towerPlacementbtn3.isVisible = true;
				towerPlacementbtn3:addEventListener("tap",towerCreate);
			end

			if(towerPlacement4.contains == 0)then

				towerPlacementbtn4:setLabel(temp);
				towerPlacementbtn4.isVisible = true;
				towerPlacementbtn4:addEventListener("tap",towerCreate);
			end
			itemSelected = 1;
		end
	end
end

function gTowerPurchase(event)
	if(itemSelected == 1)then
		towerOptionbtn1:removeEventListener("tap",towerPurchase);
		towerOptionbtn1:addEventListener("tap",cancelTowerPurchase);
		towerOptionbtn2:removeEventListener("tap",gTowerPurchase);
		towerOptionbtn2:addEventListener("tap",cancelTowerPurchase);
		towerOptionbtn3:removeEventListener("tap",bTowerPurchase);
		towerOptionbtn3:addEventListener("tap",cancelTowerPurchase);
	else
		if(data.gold < 200) then
			--do nothing place holder
		else

			local temp = event.target:getLabel();
			print(temp)
			local parameters = {};
			if(towerPlacement1.contains == 0)then

				towerPlacementbtn1:setLabel(temp);
				towerPlacementbtn1.isVisible = true;
				towerPlacementbtn1:addEventListener("tap",gTowerCreate);

			end

			if(towerPlacement2.contains == 0)then
		
				towerPlacementbtn2:setLabel(temp);
				towerPlacementbtn2.isVisible = true;
				towerPlacementbtn2:addEventListener("tap",gTowerCreate);
			end

			if(towerPlacement3.contains == 0)then
				towerPlacementbtn3:setLabel(temp);
				towerPlacementbtn3.isVisible = true;
				towerPlacementbtn3:addEventListener("tap",gTowerCreate);
			end

			if(towerPlacement4.contains == 0)then

				towerPlacementbtn4:setLabel(temp);
				towerPlacementbtn4.isVisible = true;
				towerPlacementbtn4:addEventListener("tap",gTowerCreate);
			end
			itemSelected = 1;

		end
	end
end

function bTowerPurchase(event)
	if(itemSelected == 1)then
		towerOptionbtn1:removeEventListener("tap",towerPurchase);
		towerOptionbtn1:addEventListener("tap",cancelTowerPurchase);
		towerOptionbtn2:removeEventListener("tap",gTowerPurchase);
		towerOptionbtn2:addEventListener("tap",cancelTowerPurchase);
		towerOptionbtn3:removeEventListener("tap",bTowerPurchase);
		towerOptionbtn3:addEventListener("tap",cancelTowerPurchase);
	else
		if(data.gold < 200) then
			--do nothing place holder
		else

			local temp = event.target:getLabel();
			print(temp)
			local parameters = {};
			if(towerPlacement1.contains == 0)then

				towerPlacementbtn1:setLabel(temp);
				towerPlacementbtn1.isVisible = true;
				towerPlacementbtn1:addEventListener("tap",bTowerCreate);

			end

			if(towerPlacement2.contains == 0)then
		
				towerPlacementbtn2:setLabel(temp);
				towerPlacementbtn2.isVisible = true;
				towerPlacementbtn2:addEventListener("tap",bTowerCreate);
			end

			if(towerPlacement3.contains == 0)then
				towerPlacementbtn3:setLabel(temp);
				towerPlacementbtn3.isVisible = true;
				towerPlacementbtn3:addEventListener("tap",bTowerCreate);
			end

			if(towerPlacement4.contains == 0)then

				towerPlacementbtn4:setLabel(temp);
				towerPlacementbtn4.isVisible = true;
				towerPlacementbtn4:addEventListener("tap",bTowerCreate);
			end
			itemSelected = 1;

		end
	end
end


        -- Code here runs when the scene is still off screen (but is about to come on screen)
		cube = display.newSprite(gameSheet, sequenceData);
		cube.x = display.contentCenterX;
		cube.y = display.contentHeight-150;
		cube.hp = 10;
		cube:setSequence("Player Type 1 Blue");
		
		sceneGroup:insert(cube);

		baseHP = 20;

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

    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
		local function roundStart()

		if(round ~= 1)then

			towerOptionbtn1.isVisible = false;
			towerOptionbtn2.isVisible = false;
			towerOptionbtn3.isVisible = false;

			nextBtn.isVisible = false;

			scoreText:removeSelf();
			scoreText=nil;

			towerBtn.isVisible = false;
			data.enemyCount = round;
		end

		local currentEnemy = {};
		local enemyI = 1;
		print("Round Began");

		local roundTimer = timer.performWithDelay(2500, 
			function ()
				local spawnTable = {};

				spawnTable[1] = Enemy:new({xPos=500, yPos=300});
				spawnTable[2] = Square:new({xPos=150, yPos=200});
				spawnTable[3] = Triangle:new({xPos=25, yPos=300});

				currentEnemy[enemyI] = spawnTable[math.random(1, 3)]; 
				currentEnemy[enemyI]:spawn();
				currentEnemy[enemyI]:move();
				currentEnemy[enemyI]:shoot(800);

				enemyI = enemyI + 1;
				
			

		end, round);
		
		endCheck = timer.performWithDelay(10,
			function ()
				if(data.enemyCount == 0) then
					roundEnd();
				end
			end,-1);
end
		
		local function towerPage()
			towerOptionbtn1.isVisible = true;
			towerOptionbtn1:addEventListener("tap",towerPurchase);

			towerOptionbtn2.isVisible = true;
			towerOptionbtn2:addEventListener("tap",towerPurchase);
			
			towerOptionbtn3.isVisible = true;
			towerOptionbtn3:addEventListener("tap",towerPurchase);
	
			print("Tower page");
		end
		
		function roundEnd()
		
			if(towerPlacement1.contains == 1)then
			timer.pause(towerPlacement1.shape.timerRef);
			end
			if(towerPlacement2.contains == 1)then
				timer.pause(towerPlacement2.shape.timerRef);
			end
			if(towerPlacement3.contains == 1)then
				timer.pause(towerPlacement3.shape.timerRef);
			end
			if(towerPlacement4.contains == 1)then
				timer.pause(towerPlacement4.shape.timerRef);
			end

			timer.pause(endCheck);
			round = round + 1;
			print("round ended")
			
			nextBtn.isVisible = true;
			nextBtn:addEventListener("tap", roundStart);
			towerBtn.isVisible = true;
			towerBtn:addEventListener("tap", towerPage);
			scoreText = display.newText( "Gold: " .. data.gold, 200, 50,
									 native.systemFont, 40 );
		end
		
		-- Projectile 
		local cnt = 0;
		local function fire (event) 
		  if (cnt < 4) then
			cnt = cnt+1;

			local p = display.newCircle (cube.x, cube.y-30, 5);
			p.anchorY = 1;
			p:setFillColor(0,1,0);
			physics.addBody (p, "dynamic", {radius=10, filter=CollisionFilters.bullet} );
			p:applyForce(0, -4, p.x, p.y);

			audio.play( soundTable["shootSound"] );
			

			local function removeProjectile (event)
			  if (event.phase=="began") then
				 event.target:removeSelf();
				 event.target=nil;
				 cnt = cnt - 1;

				 if (event.other.tag == "enemy") then

					event.other.pp:hit();

					if(event.other.pp.HP == 0) then
						data.gold = data.gold + 20;
						data.enemyCount = data.enemyCount - 1;
						print("Enemies: " ..data.enemyCount);
						print("Gold: " ..data.gold);
					end
					
					if(data.enemyCount == 0) then
						roundEnd();
					end

				 end
			  end
			end
			p:addEventListener("collision", removeProjectile);
		  end
		end

		controlBar:addEventListener("tap", fire)

		local function onBottomCollision(event)

			if ( event.phase == "began") then
				if (event.other.tag == "enemy") then
					print("Before: " .. baseHP);
					baseHP = baseHP - event.other.pp.HP;
					print("After: " .. baseHP);
					data.enemyCount = data.enemyCount - 1;
					print("Enemies: " ..data.enemyCount);
					event.other:removeSelf();
					event.other=nil;

					if(data.enemyCount == 0) then
						roundEnd();
					end
				else
					event.other:removeSelf();
					event.other=nil;
				end
			elseif ( event.phase == "ended" ) then

			end
		end

		bottom:addEventListener("collision", onBottomCollision);

		roundStart();		
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