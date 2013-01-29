/**
 * Sean Clover, 01/2013.
 * All rights received.
 */
package game.hud
{
    import com.greensock.TweenMax;
    import com.greensock.easing.Circ;

    import game.SeanG;

    import org.flixel.FlxG;
    import org.flixel.FlxGroup;
    import org.flixel.FlxSprite;
    import org.flixel.FlxText;

    import game.Assets;

    import pixelsean.message.IMessageListener;

    public class Panel extends FlxGroup
    {
        public var superTime:Number = 3/5;
        public var goodTime:Number = 8/9;

        private var _panel:FlxSprite;
        private var _promptText:FlxText;
        private var _promptAlphaTween:TweenMax;

        private var _result:Number = 0; // result of player

        public function Panel()
        {
            // panel window
            _panel = new FlxSprite(FlxG.width/2 - 32, FlxG.height/2 - 36);
            _panel.loadGraphic(Assets.Img_Panel, true, false, 64, 72);
            _panel.scale.make(2, 2);

            _panel.addAnimation("Super",  [0]);
            _panel.addAnimation("Good",   [1]);
            _panel.addAnimation("Normal", [2]);
            _panel.addAnimation("Lose", [3]);

            // panel prompt info
            _promptText = new FlxText(_panel.x, _panel.y + 92, 128, "PRESS ENTER");
            _promptText.color = 0x88ffffff;
            _promptAlphaTween = new TweenMax(_promptText, 0.64, {alpha:0, yoyo:1, repeat:-1});

            // hide whole panel
            _panel.visible = false;
            _promptText.visible = false;

            // add them to main group
            add(_panel);
            add(_promptText);
        }

        override public function update():void
        {
            super.update();
            if (_panel.visible)
            {
                if (FlxG.keys.justPressed("ENTER"))
                {
                    hide();
                    if (_result > 0)
                        SeanG.switchboard.sendMessage("NextLevel", FlxG.state as IMessageListener);
                    else
                        SeanG.switchboard.sendMessage("RestartLevel", FlxG.state as IMessageListener);
                }
            }
        }

        override public function destroy():void
        {
            super.destroy();
            _panel = null;
            _promptText = null;
            _promptAlphaTween = null;
        }

        public function popup(result:Number):void
        {
            _result = result;

            // show
            _panel.visible = true;
            _promptText.visible = true;
            _promptAlphaTween.restart();

            // change panel info
            if (result > 0)
            {
                if (result > superTime)
                    _panel.play("Super");
                else if (result > goodTime)
                    _panel.play("Good");
                else if (result > 0)
                    _panel.play("Normal");
            }
            else // less than 0 means failed
            {
                _panel.play("Lose");
            }
        }

        public function hide():void
        {
            _panel.visible = false;
            _promptText.visible = false;
            _promptAlphaTween.pause();
        }
    }
}
