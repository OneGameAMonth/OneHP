package game.states
{
    import game.SeanG;
    import game.enemies.Boss;

    import org.flixel.FlxCamera;
    import org.flixel.FlxG;
    import org.flixel.FlxGroup;
    import org.flixel.FlxState;
    import org.flixel.FlxTileblock;

    import game.Player;
    import game.SeanG;

    public class PlayState extends FlxState
	{
        private var _player:Player;
        private var _boss:Boss;
        private var _blocks:FlxGroup;
        private var _bullets:FlxGroup;

        // [Dev]
        private var _floor:FlxTileblock;

		override public function create():void
		{
            // create major objects
            _player = new Player(120, 20);
            FlxG.camera.follow(_player, FlxCamera.STYLE_PLATFORMER);
            SeanG.player = _player;

            _boss = new Boss(120, 20);
            SeanG.boss = _boss;

            // create major groups
            _bullets = new FlxGroup();
            _blocks = new FlxGroup();

            // register objects to SeanG
            SeanG.player = _player;
            SeanG.boss = _boss;
            SeanG.blocks = _blocks;
            SeanG.bullets = _bullets;

            // [Dev]
            _floor = new FlxTileblock(0, 80, 320, 16);
            _floor.makeGraphic(320, 16, 0xcbbca0ff);

            // add objects to groups
            SeanG.blocks.add(_floor);

            // add groups by their draw order
            add(_blocks);
            add(_boss);
            add(_player);
            add(_bullets);
		}

        override public function update():void
        {
            super.update();

            FlxG.collide(_blocks, _player);
        }

        override public function destroy():void
        {
            super.destroy();

            _player = null;
            _boss = null;
            _bullets = null;
            _blocks = null;
        }
	}
}
