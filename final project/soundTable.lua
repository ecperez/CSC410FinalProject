local soundTable = {

	-------------------------
	---Shooting--------------
    shoot1 = audio.loadSound( "shoot.wav" ),
    shoot2 = audio.loadSound("shoot_2.wav"),
    shoot3 = audio.loadSound("shoot_3.wav"),
    shoot4 = audio.loadSound("shoot_4.wav"),
    bombDrop = audio.loadSound("bomb_drop.wav"),
    enemyShoot = audio.loadSound("enemy_shoot.wav"),

    -------------------------
    ---Laser contact---------
    hitSound = audio.loadSound( "hit.wav" ),
    explodeSound = audio.loadSound( "explode.wav" ),

    -------------------------
    ---Using a powerup-------
    powerupGet = audio.loadSound("powerup.wav"),
    powerupGet2 = audio.loadSound("powerup_2.wav"),
    powerupGet3 = audio.loadSound("powerup_3.wav"),
    powerupGet4 = audio.loadSound("powerup_4.wav"),
    powerupGet5 = audio.loadSound("powerup_5.wav"),
}

--audio.play(soundTable[""]);

return soundTable;
