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
			t = new FlxSprite(0, 0);
			add(t);

            FlxG.playMusic(Assets.Snd_BgMusic);
		}

		override public function update():void
		{
			super.update();
		}

        public function handleMessage(msg:Message):void
        {
            if(msg.name == "Play")
            {
                SeanG.levelIndex = 0;
                FlxG.switchState(new PlayState());
            }
        }
	}
}
