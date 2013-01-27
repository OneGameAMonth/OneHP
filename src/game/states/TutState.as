package game.states
{
    import org.flixel.FlxG;
    import org.flixel.FlxSprite;
    import org.flixel.FlxState;

    import pixelsean.message.Message;
    import pixelsean.message.IMessageListener;

    import game.SeanG;
    import game.Assets;

    public class TutState extends FlxState implements IMessageListener
	{
		override public function create():void
		{
			var t:FlxSprite;
			t = new FlxSprite(0, 0, Assets.Img_Tut);
			add(t);

            SeanG.switchboard.sendMessage("Play", this, this, 4);
		}

		override public function update():void
		{
			super.update();
            SeanG.switchboard.update();
		}

        public function handleMessage(msg:Message):void
        {
            if(msg.name == "Play")
            {
                FlxG.fade(0xffd8eba2, 1.6, switchToPlay);
            }
        }

        private function switchToPlay():void
        {
            SeanG.levelIndex = 0;
            FlxG.switchState(new PlayState());
        }
	}
}
