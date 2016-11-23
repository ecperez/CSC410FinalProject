--RICKY, BRANDON, ROLANDO--
--DR. Kim--
--FINAL PROJECT--


local composer = require ("composer");
local widget = require ("widget");
local soundboard = require ("soundTable");

--variable to hold random number in titleChange function
local switcher;
--loading main music
local backgroundMusic = audio.loadStream( "mainTheme2.wav" );
--having it play on 1 channel and repeating
local backgroundMusicChannel = audio.play( backgroundMusic, { channel=1, loops=-1, fadein=1000 } )

local background = display.newImageRect("background.jpg", display.contentWidth, display.contentHeight)
background.x, background.y = display.contentCenterX, display.contentCenterY;

local title = display.newImageRect("title1.png",1024, 576);
title.x, title.y = display.contentCenterX, display.contentCenterY/2;

--function used by timer to change title image
local function titleChange(event)
	--used to determine which image to use
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
	--defBtn:removeSelf();
	--defBtn = nil;
end

local function stopAudio()
	audio.stop( backgroundMusicChannel )
	backgroundMusicChannel = nil
	audio.dispose(backgroundMusic);
	backgroundMusic = nil;
end
				
local function start (event)
	composer.gotoScene("level1",options);
	exitSteps();
	stopAudio();
	print("Start Game");
end

local function godMode(event)
	composer.gotoScene("level1", options);
	exitSteps();
	stopAudio();
	print("God Mode");
	
end

local function defence(event)
	composer.gotoScene("defences", optionsD);
	exitSteps();
	print("Defences");
	
end

startBtn = widget.newButton(
	{
		width = 350,
        height = 291,
		defaultFile = "meteorGrey_big3.png",
		id = "startBtn",
		label = "Start",
		labelColor = { default={ 1, 1, 1 }},
		fontSize = 75,
		onEvent = start
	}
)
startBtn.x = display.contentCenterX*.5
startBtn.y = display.contentCenterY*1.48

godBtn = widget.newButton(
	{
		width = 350,
        height = 291,
		defaultFile = "meteorBrown_big1.png",
		id = "godMode",
		label = "Kim\nMode",
		labelColor = { default={ 1, 1, 1 }},
		fontSize = 75,
		onEvent = godMode,
		
	}
)
godBtn.x = display.contentCenterX*1.5
godBtn.y = display.contentCenterY*1.5

--[[defBtn = widget.newButton(
	{
		width = 365,
        height = 304,
		defaultFile = "meteorGreen_big3.png",
		id = "def",
		label = "Defences",
		labelColor = { default={ 1, 1, 1 }},
		fontSize = 75,
		onEvent = defence
	}
)
defBtn.x = display.contentCenterX
defBtn.y = display.contentCenterY*1.7
]]--