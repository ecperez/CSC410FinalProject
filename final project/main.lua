local composer = require ("composer");
local widget = require ("widget");
local soundboard = require ("soundTable");

local switcher;

local backgroundMusic = audio.loadStream( "mainTheme.wav" );
local backgroundMusicChannel = audio.play( backgroundMusic, { channel=1, loops=-1, fadein=1000 } )

local background = display.newImageRect("background.jpg", display.contentWidth, display.contentHeight)
background.x, background.y = display.contentCenterX, display.contentCenterY;

local title = display.newImageRect("title1.png",1024, 576);
title.x, title.y = display.contentCenterX, display.contentCenterY/2;

local function titleChange(event)
	switcher = math.random(1,2);
	
	if (switcher == 1) then
		title:removeSelf();
		title = nil
		title = display.newImageRect("title1.png",1024, 576);
		title.x, title.y = display.contentCenterX, display.contentCenterY/2;
	elseif (switcher == 2) then
		title:removeSelf();
		title = nil;
		title = display.newImageRect("title2.png",1024, 576);
		title.x, title.y = display.contentCenterX, display.contentCenterY/2;
	end	
end

local titleTimer = timer.performWithDelay(100, titleChange, 0)

local options = 
	{
		time = 800;
	}
	
local optionsD = 
	{
		time = 1000;
		effect = "fromBottom";		
	}
	
local function exitSteps()
	timer.cancel(titleTimer);
	title:removeSelf();
	title = nil;
	background:removeSelf();
	startBtn:removeSelf();
	startBtn = nil;
	godBtn:removeSelf();
	godBtn = nil;
	defBtn:removeSelf();
	defBtn = nil;
end
				
local function start (event)
	composer.gotoScene("level1",options);
	exitSteps();
	print("Start Game");
end

local function godMode(event)
	composer.gotoScene("level1", options);
	exitSteps();
	print("God Mode");
	
end

local function defence(event)
	composer.gotoScene("defences", optionsD);
	exitSteps();
	print("Defences");
	
end

startBtn = widget.newButton(
	{
		shape = "circle",
		radius = 150,
		left = display.contentWidth/5,
		top = display.contentHeight/3 * 2,
		id = "startBtn",
		label = "Start",
		fontSize = 75,
		onEvent = start
	}
)

godBtn = widget.newButton(
	{
		shape = "circle",
		radius = 150,
		left = display.contentWidth/1.5,
		top = display.contentHeight/1.55,
		id = "godMode",
		label = "Kim\nMode",
		labelAlign = center,
		fontSize = 75,
		onEvent = godMode	
	}
)

defBtn = widget.newButton(
	{
		shape = "circle",
		radius = 170,
		left = display.contentWidth/2.7,
		top = display.contentHeight/1.2,
		id = "def",
		label = "Defences",
		fontSize = 75,
		onEvent = defence
	}
)