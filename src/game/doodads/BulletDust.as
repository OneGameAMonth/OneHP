/**
 * Sean Clover, 01/2013.
 * All rights received.
 */
package game.doodads
{
    import org.flixel.FlxSprite;

    import game.Assets;

    public class BulletDust extends FlxSprite
    {


        public function BulletDust()
        {
            super();
            loadGraphic(Assets.ImgBulletDust, true, false, 16, 16);

            addAnimation("flow", [0, 1, 2, 2, 3, 3], 12, false);
        }

        public function emit(posX:Number, posY:Number):void
        {
            super.reset(posX, posY);
            play("flow");
        }

        override public function update():void
        {
            super.update();

            if (!onScreen())
                kill();

            if (finished)
                kill();
        }
    }
}
