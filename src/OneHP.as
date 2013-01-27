package
{

    import flash.ui.Mouse;

    import game.SeanG;

    import game.states.MenuState;
    import game.states.PlayState;

    import org.flixel.FlxG;
    import org.flixel.FlxGame;

    import pixelsean.message.Switchboard;

    [SWF(width="480", height="640", backgroundColor="#000000")]
	[Frame(factoryClass="Preloader")]

	public class OneHP extends FlxGame
	{
		public function OneHP()
		{
            // TODO: add menu state, and set first state to it
            super(240, 320, PlayState, 2);

            forceDebugger = true;
            FlxG.mouse.show();
            Mouse.show();
		}
	}
}
