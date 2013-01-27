package game.states
{
    import org.flixel.FlxG;
    import org.flixel.FlxState;
    import org.flixel.FlxText;

    import game.SeanG;
    import game.Assets;

    public class MenuState extends FlxState
	{
		override public function create():void
		{
			var t:FlxText;
			t = new FlxText(0, FlxG.height/2-36, FlxG.width, "One HP");
			t.size = 21;
			t.alignment = "center";
			add(t);
			t = new FlxText(FlxG.width/2-50, FlxG.height-120, 100, "Press Enter");
			t.alignment = "center";
			add(t);

            t = new FlxText(FlxG.width/2, FlxG.height - 96, 100, "Music by Jake Allison");
            t.alignment = "center";
            t.color = 0xff335599;
            add(t);
		}

		override public function update():void
		{
			super.update();

			if(FlxG.keys.justPressed("ENTER"))
			{
				FlxG.switchState(new TutState());
			}
		}
	}
}
