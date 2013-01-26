package game.states
{
    import game.SeanG;
    import game.damagers.Bullet;
    import game.enemies.Boss;

    import org.flixel.FlxCamera;
    import org.flixel.FlxG;
    import org.flixel.FlxGroup;
    import org.flixel.FlxSprite;
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
        private var _objects:FlxGroup;
        private var _hazards:FlxGroup;

        // [Dev]
        private var _floor:FlxTileblock;

		override public function create():void
		{
            // create major objects
            _player = new Player(32, 160);
            FlxG.camera.follow(_player, FlxCamera.STYLE_PLATFORMER);
            SeanG.player = _player;

            _boss = new Boss(240, 100);
            SeanG.boss = _boss;

            // create major groups
            _bullets = new FlxGroup();
            _blocks = new FlxGroup();

            // meta groups for collision
            _objects = new FlxGroup();
            _hazards = new FlxGroup();

            // register objects to SeanG
            SeanG.player = _player;
            SeanG.boss = _boss;
            SeanG.blocks = _blocks;
            SeanG.bullets = _bullets;

            // [Dev]
            _floor = new FlxTileblock(0, 200, 320, 32);
            _floor.makeGraphic(320, 32, 0xcbbca0ff);

            // add objects to groups
            SeanG.blocks.add(_floor);

            // add groups by their draw order
            add(_blocks);
            add(_boss);
            add(_player);
            add(_bullets);

            // sort objects into helper groups
            _objects.add(_bullets);
            _objects.add(_player);
            _hazards.add(_boss);
		}

        override public function update():void
        {
            super.update();
            SeanG.switchboard.update();

            FlxG.collide(_blocks, _objects);
            FlxG.overlap(_objects, _hazards, overlapped);
        }

        override public function destroy():void
        {
            super.destroy();

            _player = null;
            _boss = null;
            _bullets = null;
            _blocks = null;
            _objects = null;
            _hazards = null;
        }

        private function overlapped(sprite1:FlxSprite, sprite2:FlxSprite):void
        {
            sprite1.kill();
            sprite2.kill();
        }
	}
}
