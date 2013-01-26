package
{
	import org.flixel.FlxState;
    import org.flixel.FlxText;

    public class PlayState extends FlxState
	{
		override public function create():void
		{
			add(new FlxText(0, 0, 100, "INSERT GAME HERE"));
		}
	}
}
