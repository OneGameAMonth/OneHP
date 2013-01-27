package game.states
{
    import org.flixel.FlxEmitter;
    import org.flixel.FlxG;
    import org.flixel.FlxGroup;
    import org.flixel.FlxSprite;
    import org.flixel.FlxState;
    import org.flixel.FlxTileblock;
    import org.flixel.FlxTilemap;
    import org.flixel.plugin.photonstorm.FX.BlurFX;
    import org.flixel.plugin.photonstorm.FlxSpecialFX;

    import pixelsean.message.IMessageListener;

    import game.Player;
    import game.SeanG;
    import game.Assets;
    import game.doodads.Platform;
    import game.enemies.Boss;

    import pixelsean.message.Message;

    public class PlayState extends FlxState implements IMessageListener
	{
        private var _player:Player;
        private var _boss:Boss;
        private var _blocks:FlxGroup;
        private var _bullets:FlxGroup;
        private var _objects:FlxGroup;
        private var _hazards:FlxGroup;
        private var _platforms:FlxGroup;
        private var _effects:FlxGroup;
        private var _bossExplosionGibs:FlxEmitter;
        private var _blur:BlurFX;
        private var _blurSprite:FlxSprite;

        // Tilemaps
        public var layerLevel_1blocks:FlxTilemap;

        // [Dev]
        private var _floor:FlxTileblock;

		override public function create():void
		{
            // system setup
            if (FlxG.getPlugin(FlxSpecialFX) == null)
            {
                FlxG.addPlugin(new FlxSpecialFX);
            }

            // state setup
//            FlxG.bgColor = 0x445566ff;
            FlxG.bgColor = 0xff282a2b;
            FlxG.worldBounds.make(0, 0, 240, 320);

            // create major objects
            _player = new Player(32, 160);
            SeanG.player = _player;

            _boss = new Boss(0, 36);
            _boss.x = FlxG.width/2-_boss.width/2;
            SeanG.boss = _boss;

            _bossExplosionGibs = new FlxEmitter();
            _bossExplosionGibs.setXSpeed(-120, 120);
            _bossExplosionGibs.setYSpeed(-160, 0);
            _bossExplosionGibs.setRotation(-180, 180);
            _bossExplosionGibs.gravity = 160;
            _bossExplosionGibs.makeParticles(Assets.Img_BossGibs, 64, 1, true, 0.1);

            _blur = FlxSpecialFX.blur();
            _blurSprite = _blur.create(240, 320, 4, 4, 4);
            _blur.start();

            // create major groups
            _bullets = new FlxGroup();
            _blocks = new FlxGroup();
            _effects = new FlxGroup();

            // meta groups for collision
            _objects = new FlxGroup();
            _hazards = new FlxGroup();
            _platforms = new FlxGroup();

            // register objects to SeanG
            SeanG.player = _player;
            SeanG.boss = _boss;
            SeanG.blocks = _blocks;
            SeanG.bullets = _bullets;
            SeanG.platforms = _platforms;
            SeanG.bossExplosionGibs = _bossExplosionGibs;
            SeanG.blur = _blur;

            // load map
            layerLevel_1blocks = new FlxTilemap;
            layerLevel_1blocks.loadMap( new Assets.CSV_Level_1blocks, Assets.Img_Level_1blocks, 8, 8, FlxTilemap.OFF, 0, 1, 1 );
            // - add platforms, TODO: load platform from level files
            _platforms.add(new Platform(48.000, 112.000, "one-off"));
            _platforms.add(new Platform(48.000, 240.000, "normal"));
            _platforms.add(new Platform(112.000, 208.000, "one-off"));
            _platforms.add(new Platform(48.000, 176.000, "normal"));
            _platforms.add(new Platform(176.000, 176.000, "normal"));
            _platforms.add(new Platform(176.000, 240.000, "normal"));
            _platforms.add(new Platform(112.000, 144.000, "one-off"));
            _platforms.add(new Platform(176.000, 112.000, "normal"));

            // add objects to groups
            _blocks.add(layerLevel_1blocks);
            _effects.add(_bossExplosionGibs);
            _effects.add(_blurSprite);

            // add groups by their draw order
            add(_blocks);
            add(_boss);
            add(_player);
            add(_platforms);
            add(_bullets);
            add(_effects);

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
            FlxG.collide(_platforms, _player, touchPlatform);
            FlxG.overlap(_objects, _hazards, overlapped);
        }

        override public function destroy():void
        {
            super.destroy();

            FlxSpecialFX.clear();

            _player = null;
            _boss = null;
            _bullets = null;
            _blocks = null;
            _objects = null;
            _hazards = null;
            _platforms = null;
            _bossExplosionGibs = null;
            _blur = null;
            _blurSprite = null;
        }

        public function handleMessage(msg:Message):void
        {
            if (msg.name == "BossKilled" || msg.name == "PlayerKilled")
            {
                // slow motion
                FlxG.timeScale = 0.1;
                SeanG.switchboard.sendMessage("RestoreTimeScale", this, this, 1.6);
                FlxG.camera.shake(0.05, 0.1);
                FlxG.camera.flash(0xffd8eba2, 0.12);
            }
            else if (msg.name == "RestoreTimeScale")
            {
                FlxG.timeScale = 1;
            }
        }

        private function overlapped(sprite1:FlxSprite, sprite2:FlxSprite):void
        {
            sprite1.hurt(1);
            sprite2.hurt(1);
        }

        private function touchPlatform(sprite1:FlxSprite, sprite2:FlxSprite):void
        {
            (sprite1 as Platform).touchedBy(sprite2);
        }
	}
}
