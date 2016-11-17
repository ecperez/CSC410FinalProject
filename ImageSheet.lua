--------------------------------------------------------------------------------
-----Sprites-------------------------------------------------------------------
sheetOpt = 
{
	frames = {
		---Player Ships---Frames 1 to 12
		{x = 111, y = 791, width = 112, height = 76}, --player ship type 1 blue
		{x = 111, y = 866, width = 112, height = 74}, --player ship type 1 green
		{x = 112, y = 716, width = 112, height = 75}, --player ship type 1 orange
		{x = 0, y = 941, width = 112, height = 79}, --player ship type 1 red
		{x = 211, y = 941, width = 99, height = 77}, --player ship type 2 blue
		{x = 237, y = 375, width = 99, height = 76}, --player ship type 2 green
		{x = 247, y = 84, width = 99, height = 77}, --player ship type 2 orange
		{x = 224, y = 832, width = 99, height = 75}, --player ship type 2 red
		{x = 325, y = 739, width = 98, height = 74}, --player ship type 3 blue
		{x = 346, y = 76, width = 98, height = 74}, --player ship type 3 green
		{x = 336, y = 309, width = 98, height = 74}, --player ship type 3 orange
		{x = 325, y = 0, width = 98, height = 74}, --player ship type 3 red
		---Player Ship Damage Overlays---Frames 13 to 21
		{x = 0, y = 866, width = 112, height = 75}, --type 1 light damage
		{x = 0, y = 791, width = 112, height = 75}, --type 1 moderate damage
		{x = 0, y = 716, width = 112, height = 75}, --type 1 heavy damage
		{x = 111, y = 941, width = 99, height = 76}, --type 2 light damage
		{x = 247, y = 234, width = 99, height = 75}, --type 2 moderate damage
		{x = 247, y = 160, width = 99, height = 75}, --type 2 heavy damage
		{x = 310, y = 907, width = 98, height = 74}, --type 3 light damage
		{x = 324, y = 832, width = 98, height = 74}, --type 3 moderate damage
		{x = 325, y = 665, width = 98, height = 74}, --type 3 heavy damage
		---Enemy Ships---Frames 22 to 41
		{x = 223, y = 3, width = 103, height = 83}, --enemy ship type 1 blue
		{x = 144, y = 156, width = 103, height = 83}, --enemy ship type 1 black
		{x = 224, y = 496, width = 103, height = 83}, --enemy ship type 1 green
		{x = 224, y = 580, width = 103, height = 83}, --enemy ship type 1 orange
		{x = 143, y = 294, width = 104, height = 83}, --enemy ship type 2 blue
		{x = 120, y = 605, width = 104, height = 83}, --enemy ship type 2 black
		{x = 133, y = 413, width = 104, height = 83}, --enemy ship type 2 green
		{x = 120, y = 521, width = 104, height = 83}, --enemy ship type 2 orange
		{x = 425, y = 467, width = 93, height = 85}, --enemy ship type 3 blue
		{x = 423, y = 729, width = 93, height = 85}, --enemy ship type 3 black
		{x = 425, y = 551, width = 93, height = 85}, --enemy ship type 3 green
		{x = 425, y = 383, width = 93, height = 85}, --enemy ship type 3 orange
		{x = 519, y = 409, width = 81, height = 83}, --enemy ship type 4 blue
		{x = 517, y = 324, width = 81, height = 83}, --enemy ship type 4 black
		{x = 518, y = 493, width = 81, height = 83}, --enemy ship type 4 green
		{x = 520, y = 577, width = 81, height = 83}, --enemy ship type 4 orange
		{x = 421, y = 815, width = 97, height = 85}, --enemy ship type 5 blue
		{x = 346, y = 150, width = 97, height = 83}, --enemy ship type 5 black
		{x = 408, y = 906, width = 97, height = 85}, --enemy ship type 5 green
		{x = 423, y = 644, width = 97, height = 85}, --enemy ship type 5 orange
		---Turrets---Frames 42 to 45
		{x = 443, y = 91, width = 91, height = 91}, --turret blue
		{x = 434, y = 234, width = 91, height = 91}, --turret type green
		{x = 444, y = 0, width = 91, height = 91}, --turret type red
		{x = 505, y = 898, width = 91, height = 91}, --turret type yellow
		---Power-Ups---Frames 46 to 48
		{x = 539, y = 989, width = 33, height = 35}, --Energy Power-Up
		{x = 775, y = 895, width = 35, height = 33}, --Star Power-Up
		{x = 777, y = 679, width = 34, height = 33}, --Shield Power-Up
		---Lasers---Frames 49 to 50
		{x = 835, y = 566, width = 13, height = 36}, --blue laser
		{x = 843, y = 941, width = 13, height = 36} --red laser
	}
}

sequenceData = {
	---Player Ship Sequence---
	{ name = "Player Type 1 Blue", start=1, count=1, time=0, loopCount=1 },
	{ name = "Player Type 1 Green", start=2, count=1, time=0, loopCount=1 },
	{ name = "Player Type 1 Orange", start=3, count=1, time=0, loopCount=1 },
	{ name = "Player Type 1 Red", start=4, count=1, time=0, loopCount=1 },
	{ name = "Player Type 2 Blue", start=5, count=1, time=0, loopCount=1 },
	{ name = "Player Type 2 Green", start=6, count=1, time=0, loopCount=1 },
	{ name = "Player Type 2 Orange", start=7, count=1, time=0, loopCount=1 },
	{ name = "Player Type 2 Red", start=8, count=1, time=0, loopCount=1 },
	{ name = "Player Type 3 Blue", start=9, count=1, time=0, loopCount=1 },
	{ name = "Player Type 3 Green", start=10, count=1, time=0, loopCount=1 },
	{ name = "Player Type 3 Orange", start=11, count=1, time=0, loopCount=1 },
	{ name = "Player Type 3 Red", start=12, count=1, time=0, loopCount=1 },		
	---Enemy Ship Sequence---
	{ name = "Enemy Type 1 Blue", start=22, count=1, time=0, loopCount=1 },
	{ name = "Enemy Type 1 Black", start=23, count=1, time=0, loopCount=1 },
	{ name = "Enemy Type 1 Green", start=24, count=1, time=0, loopCount=1 },
	{ name = "Enemy Type 1 Orange", start=25, count=1, time=0, loopCount=1 },
	{ name = "Enemy Type 2 Blue", start=26, count=1, time=0, loopCount=1 },
	{ name = "Enemy Type 2 Black", start=27, count=1, time=0, loopCount=1 },
	{ name = "Enemy Type 2 Green", start=28, count=1, time=0, loopCount=1 },
	{ name = "Enemy Type 2 Orange", start=29, count=1, time=0, loopCount=1 },
	{ name = "Enemy Type 3 Blue", start=30, count=1, time=0, loopCount=1 },
	{ name = "Enemy Type 3 Black", start=31, count=1, time=0, loopCount=1 },
	{ name = "Enemy Type 3 Green", start=32, count=1, time=0, loopCount=1 },
	{ name = "Enemy Type 3 Orange", start=33, count=1, time=0, loopCount=1 },
	{ name = "Enemy Type 4 Blue", start=34, count=1, time=0, loopCount=1 },
	{ name = "Enemy Type 4 Black", start=35, count=1, time=0, loopCount=1 },
	{ name = "Enemy Type 4 Green", start=36, count=1, time=0, loopCount=1 },
	{ name = "Enemy Type 4 Orange", start=37, count=1, time=0, loopCount=1 },
	{ name = "Enemy Type 5 Blue", start=38, count=1, time=0, loopCount=1 },
	{ name = "Enemy Type 5 Black", start=39, count=1, time=0, loopCount=1 },
	{ name = "Enemy Type 5 Green", start=40, count=1, time=0, loopCount=1 },
	{ name = "Enemy Type 5 Orange", start=41, count=1, time=0, loopCount=1 },
	---Turret Ship Sequence---
	{ name = "Turret Type 1 Blue", start=42, count=1, time=0, loopCount=1 },
	{ name = "Turret Type 1 Green", start=43, count=1, time=0, loopCount=1 },
	{ name = "Turret Type 1 Red", start=44, count=1, time=0, loopCount=1 },
	{ name = "Turret Type 1 yellow", start=45, count=1, time=0, loopCount=1 },
	---Power-Up Sequence---
	{ name = "Power-Up Energy", start=1, count=1, time=0, loopCount=1 },
	{ name = "Power-Up Star", start=2, count=1, time=0, loopCount=1 },
	{ name = "Power-Up Shield", start=3, count=1, time=0, loopCount=1 },
	---Laser Sequence---
	{ name = "Laser Type 1 Blue", start=49, count=1, time=0, loopCount=1 },
	{ name = "Laser Type 1 Red", start=50, count=1, time=0, loopCount=1 }
}

--define the sprite sheet
gameSheet = graphics.newImageSheet("sheet.png",sheetOpt);