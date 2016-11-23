local soundTable=require("soundTable");
local CollisionFilters = require("CollisionFilters");
local ImageSheet = require("ImageSheet");
local tower = require("tower");
local data = require("data");


local Enemy = {tag="enemy", HP=1, xPos=display.contentWidth/2, yPos=0, 
    fR=0, sR=0, bR=0, fT=200, sT=500, bT	=500,  timerR};



function Enemy:new (o)    --constructor
  o = o or {}; 
  setmetatable(o, self);
  self.__index = self;
  return o;
end

function Enemy:spawn()
 self.shape = display.newSprite(gameSheet, sequenceData);
 self.shape.x = self.xPos;
 self.shape.y = self.yPos;
 self.shape.pp = self;      -- parent object
 self.shape.tag = self.tag; -- “enemy”
 self.shape:setSequence("Enemy Type 1 Orange");
 physics.addBody(self.shape, "dynamic", {filter=CollisionFilters.enemy}); 
end


function Enemy:back ()
  transition.to(self.shape, {x= display.contentWidth/2, y=self.shape.y - 75,  
  time=self.fB,
  onComplete=function (obj) self:forward() end} );
end

function Enemy:left ()   
   transition.to(self.shape, {x=self.shape.x-200, 
   time=self.fS,
   onComplete=function (obj) self:right() end } );
end

function Enemy:right ()   
   transition.to(self.shape, {x=self.shape.x+400, 
   time=self.fS, 
   onComplete=function (obj) self:back() end } );
end

function Enemy:forward ()   
   transition.to(self.shape, {x=self.shape.x, y=self.shape.y + 350, 
   time=self.fT,
   onComplete= function (obj) self:left() end } );
end

function Enemy:move ()	
	self:forward();
end


function Enemy:hit () 
	self.HP = self.HP - 1;
	if (self.HP > 0) then 
		audio.play( soundTable["hitSound"] );
		self.shape:setFillColor(0.5,0.5,0.5);
	else 
		audio.play( soundTable["explodeSound"] );
		transition.cancel( self.shape );
		
		if (self.timerRef ~= nil) then
			timer.cancel ( self.timerRef );
		end

		-- die
		self.shape:removeSelf();
		self.shape=nil;	
		self = nil;  
	end		
end

function Enemy:shoot (interval)
  interval = interval or 1500;
  local function createShot(obj)
    local p = display.newSprite(gameSheet, sequenceData);
    p.x = obj.shape.x;
    if(obj.shape.y ~= nil)then
        p.y = obj.shape.y+50;
    end
    p.anchorY=0;
    p:setSequence("Laser Type 1 Red");
    physics.addBody(p, "dynamic", {filter=CollisionFilters.enemyBullet});
    p:applyForce(0, 15, p.x, p.y);
		p.tag = "shot";

    local function shotHandler (event)
        if (self.shape == nil) then
	
        else 
          if (event.phase == "began") then
              event.target:removeSelf();
            event.target = nil;

            if(event.other.tag == "tower")then
              event.other.HP = event.other.HP - 1;

                if (event.other.HP > 0) then 
                  audio.play( soundTable["hitSound"] );

                else 
                  audio.play( soundTable["explodeSound"] );

                  --tower die
                  if (event.other.timerRef ~= nil) then
                    print("I got in here boy");
                    timer.cancel ( event.other.timerRef );
                  end
                  data.CurrentTowers[event.other.tPos] = 0;
                  print(event.other.tPos .. "  " .. data.CurrentTowers[event.other.tPos]);
                  event.other:removeSelf();
                  event.other=nil; 
                  --event = nil;  
                end 
            end
        end
      end
    end
    p:addEventListener("collision", shotHandler);		
  end
  self.timerRef = timer.performWithDelay(interval, 
	function (event) createShot(self) end, -1);
  self.shape.timerRef = self.timerRef;
  self.timerR = timerRef;
  self.shape.timerR = self.timerR;
end

return Enemy;