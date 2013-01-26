package game.states
{
    import game.SeanG;

    import org.flixel.FlxCamera;
    import org.flixel.FlxG;
    import org.flixel.FlxGroup;
    import org.flixel.FlxState;
    import org.flixel.FlxTileblock;

    import game.Player;
    import game.SeanG;

    public class PlayState extends FlxState
	{
        // [Dev]
        private var _floor:FlxTileblock;

		override public function create():void
		{
            // create major objects
            var player:Player = new Player(20, 20);
            FlxG.camera.follow(player, FlxCamera.STYLE_PLATFORMER);
            SeanG.player = player;

            // create major groups
            SeanG.bullets = new FlxGroup();
            SeanG.blocks = new FlxGroup();

            // [Dev]
            _floor = new FlxTileblock(0, 80, 160, 16);
            _floor.makeGraphic(160, 16, 0xcbbca0ff);

            // add objects to groups
            SeanG.blocks.add(_floor);

            // add groups
            add(SeanG.blocks);
            add(SeanG.bullets);
            add(SeanG.player);
		}

        override public function update():void
        {
            super.update();

            FlxG.collide(_floor, SeanG.player);
        }
	}
}
