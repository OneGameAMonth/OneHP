/**
 * Sean Clover, 01/2013.
 * All rights received.
 */
package game.enemies
{
    import org.flixel.FlxG;
    import org.flixel.FlxSprite;

    import game.SeanG;
    import game.Assets;

    import pixelsean.message.IMessageListener;

    public class RestartMan extends FlxSprite
    {
        private var _popPanel:FlxSprite;

        public function RestartMan(X:Number = 0, Y:Number = 0)
        {
            super(X, Y);
            loadGraphic(Assets.Img_RestartMan, true, false, 16, 16);
            _popPanel = new FlxSprite(X + 8, Y - 34, Assets.Img_RestartPop);
            FlxG.state.add(_popPanel);

            addAnimation("shoot", [0, 1], 2);
            health = 1;

            play("shoot");
        }

        override public function destroy():void
        {
            super.destroy();
            _popPanel = null;
        }

        override public function kill():void
        {
            super.kill();
            SeanG.switchboard.sendMessage("RestartLevel", FlxG.state as IMessageListener, this);
        }
    }
}
