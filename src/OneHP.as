package
{
    import flash.ui.Mouse;

    import org.flixel.FlxG;
    import org.flixel.FlxGame;

    import game.SeanG;
    import game.states.MenuState;
    import game.states.PlayState;
    import game.levels.Level_Level_1;

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

            createLevelList();
		}

        private function createLevelList():void
        {
            SeanG.levels.push(Level_Level_1);
            SeanG.levels.push(Level_Level_1);
            SeanG.levels.push(Level_Level_1);
        }
	}
}
