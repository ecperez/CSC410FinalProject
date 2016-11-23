local tower = require ("tower");
local CollisionFilters = require("CollisionFilters");
local data = require("data");
local ImageSheet = require("ImageSheet");

local goldTower = {tag="tower", HP=2, xPos=display.contentWidth/2, yPos=0,tPos=0};



function goldTower:new (o)    --constructor
  o = o or {}; 
  setmetatable(o, self);
  self.__index = self;
  return o;
end

function goldTower:spawn()
	print("created")
 self.shape = display.newSprite(gameSheet, sequenceData);
 self.shape.x = self.xPos;
 self.shape.y = self.yPos;
 self.shape.pp = self;      -- parent object
 self.shape.tag = self.tag; -- “enemy”
 self.shape.HP = self.HP; 
 self.shape.tPos = self.tPos;
 self.shape:setSequence("Turret Type 1 Yellow");
 physics.addBody(self.shape, "kinematic", {filter=CollisionFilters.tower});
 data.CurrentTowers[self.tPos] = 1; 
end

function goldTower:shoot (interval)
  interval = interval or 1200;
  local function createShot(obj)
    data.gold = data.gold + 5;
    print("total gold: " ..data.gold);
  end
  self.timerRef = timer.performWithDelay(interval, 
	function (event) createShot(self) end, -1);
		self.shape.timerRef = self.timerRef;
		self.timerR = timerRef;
		self.shape.timerR = self.timerR;
end
return goldTower;