package game.damagers
{
    import game.SeanG;

    import org.flixel.FlxPoint;
    import org.flixel.FlxSprite;

    import game.Assets;

    public class Bullet extends FlxSprite
	{
		public var speed:Number;

		public function Bullet()
		{
			super();
            loadGraphic(Assets.Img_Bullet, true);
			width = 1;
            height = 1;
			offset.x = 1;
            offset.y = 1;

            addAnimation("shoot", [0]);
            addAnimation("poof", [1, 2, 3], 20, false);

			speed = 360;
		}

		override public function update():void
		{
            super.update();

            // [Behavior] die when out of screen
            if (!onScreen())
                kill();

            // [Behavior] die when collide with something
			if (!alive)
			{
				if (finished)
					exists = false;
			}
			else if (touching)
			{
				kill();
			}
		}

		override public function kill():void
        {
            if (!alive)
            	return;
            velocity.x = 0;
            velocity.y = 0;
            // TODO: Optional, play sound effect
            alive = false;
            solid = false;

            play("poof");
		}

        public static function shoot(location:FlxPoint, aim:uint):void
        {
            // TODO: play shoot sound
            var bullet:Bullet = SeanG.bullets.recycle(Bullet) as Bullet;
            bullet.reset(location.x-bullet.width/2, location.y-bullet.height/2);
            bullet.solid = true;
            switch(aim)
            {
                case LEFT:
                    bullet.play("shoot");
                    bullet.velocity.x = -bullet.speed;
                    break;
                case RIGHT:
                    bullet.play("shoot");
                    bullet.velocity.x = bullet.speed;
                    break;
            	default:
                	break;
            }
		}
	}
}
