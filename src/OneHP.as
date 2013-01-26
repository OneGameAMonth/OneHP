package
{
	import org.flixel.FlxGame;

	[SWF(width="640", height="480", backgroundColor="#000000")]
	[Frame(factoryClass="Preloader")]

	public class OneHP extends FlxGame
	{
		public function OneHP()
		{
			super(320, 240, MenuState, 2);
		}
	}
}
