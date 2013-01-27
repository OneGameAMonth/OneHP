/**
 * Sean Clover, 01/2013.
 * All rights received.
 */
package game.doodads
{
    import org.flixel.FlxBasic;
    import org.flixel.FlxG;
    import org.flixel.FlxObject;
    import org.flixel.FlxSprite;

    import game.Assets;

    public class Platform extends FlxSprite
    {
        public var gravity:Number = 100;

        private var _type:int = 0;  // 0:"normal", 1:"one-off"

        public function Platform(X:Number = 0, Y:Number = 0, type:String = "normal")
        {
            super(X, Y);
            loadGraphic(Assets.Img_Platform, true, false, 24, 8);

            // setting type for different behavior
            _type = (type=="normal") ? 0 : 1;

            // tweak bounding
            height = 5;
            offset.y = 1;

            // physics setting
            immovable = true;   // actually it is kinamatric
            moves = true;       // some platforms will move
            allowCollisions = FlxObject.UP; // you can jump through it down-up

            // animation
            addAnimation("normal", [0]);    // set normal platform sprite
            addAnimation("one-off", [1]);   // set one-off platform sprite

            play(type);
        }

        override public function update():void
        {
            super.update();
            if (!onScreen())
                kill();
        }

        public function touchedBy(obj:FlxBasic):void
        {
            FlxG.log("touched by" + obj.toString());
            // one-off platform will fall down if anyone touch it
            if (_type == 1)
            {
                acceleration.y = gravity;
            }
        }
    }
}
