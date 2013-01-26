package
{

    import flash.ui.Mouse;

    import game.states.MenuState;
    import game.states.PlayState;

    import org.flixel.FlxG;
    import org.flixel.FlxGame;

	[SWF(width="640", height="480", backgroundColor="#000000")]
	[Frame(factoryClass="Preloader")]

	public class OneHP extends FlxGame
	{
		public function OneHP()
		{
            // TODO: add menu state, and set first state to it
            super(320, 240, PlayState, 2);

            forceDebugger = true;
            FlxG.mouse.show();
            Mouse.show();
		}
	}
}
