package game.states
{
    import org.flixel.FlxCamera;
    import org.flixel.FlxEmitter;
    import org.flixel.FlxG;
    import org.flixel.FlxGroup;
    import org.flixel.FlxSprite;
    import org.flixel.FlxState;
    import org.flixel.FlxText;
    import org.flixel.plugin.photonstorm.FX.BlurFX;
    import org.flixel.plugin.photonstorm.FlxSpecialFX;

    import pixelsean.message.IMessageListener;
    import pixelsean.message.Message;

    import game.Player;
    import game.SeanG;
    import game.Assets;
    import game.doodads.Platform;
    import game.hud.Panel;
    import game.enemies.Boss;

    public class PlayState extends FlxState implements IMessageListener
	{
        private var _player:Player;
        private var _boss:Boss;
        private var _blocks:FlxGroup;
        private var _bullets:FlxGroup;
        private var _huds:FlxGroup;
        private var _objects:FlxGroup;
        private var _hazards:FlxGroup;
        private var _platforms:FlxGroup;
        private var _effects:FlxGroup;
        private var _bossExplosionGibs:FlxEmitter;
        private var _blur:BlurFX;
        private var _blurSprite:FlxSprite;
        private var _totalTime:Number;  // total time of current level

        private var _timeCounter:Number;
        private var _timeCounterText:FlxText;
        private var _infoPanel:Panel;

		override public function create():void
		{
            // system setup
            if (FlxG.getPlugin(FlxSpecialFX) == null)
            {
                FlxG.addPlugin(new FlxSpecialFX);
            }

            // state setup
            FlxG.bgColor = 0xff282a2b;
            FlxG.camera.setBounds(0, 0, 240, 320, true);
            FlxG.camera.follow(_player,FlxCamera.STYLE_PLATFORMER);

            // create major objects
            _player = new Player(32, 180);
            SeanG.player = _player;

            _boss = new Boss(0, 36);
            _boss.x = FlxG.width/2-_boss.width/2;
            SeanG.boss = _boss;

            _timeCounterText = new FlxText(_boss.x + 16, _boss.y - 16, 64, "00.00");
            _timeCounterText.color = 0xffaabcde;
            _infoPanel = new Panel();

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
            _huds = new FlxGroup();

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
            var _map:*= new SeanG.levels[SeanG.levelIndex];
            _platforms.add(_map.PlatformsGroup);

            // add objects to groups
            _blocks.add(_map.layerblocks);
            _effects.add(_bossExplosionGibs);
            _effects.add(_blurSprite);
            _huds.add(_timeCounterText);
            _huds.add(_infoPanel);

            // add groups by their draw order
            add(_blocks);
            add(_boss);
            add(_player);
            add(_platforms);
            add(_bullets);
            add(_effects);
            add(_huds);

            // sort objects into helper groups
            _objects.add(_bullets);
            _objects.add(_player);
            _hazards.add(_boss);

            // other settings
            _blur.addSprite(_timeCounterText);
            _timeCounter = _map.time;
            _totalTime = _map.time;
		}

        override public function update():void
        {
            super.update();
            SeanG.switchboard.update();

            FlxG.collide(_blocks, _objects);
            FlxG.collide(_platforms, _player, touchPlatform);
            FlxG.overlap(_objects, _hazards, overlapped);

            // update time counter
            _timeCounter -= FlxG.elapsed;
            if (_timeCounter < 0)
            {
                _timeCounter = 0;
                // TODO: player lose
            }

            // update time counter text
            _timeCounterText.text = _timeCounter.toFixed(2);
            _timeCounterText.x = _boss.x + 17;
            _timeCounterText.y = _boss.y - 12;
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
            _timeCounterText = null;
            _infoPanel = null;
        }

        public function handleMessage(msg:Message):void
        {
            if (msg.name == "PlayerKilled")
            {
                // lose effect
                winOrLoseEffect();
                // lose info panel
                _infoPanel.popup(-1);
            }
            else if (msg.name == "BossKilled")
            {
                // win effect
                winOrLoseEffect();
                // victory info panel
                _infoPanel.popup(_timeCounter/_totalTime);
            }
            else if (msg.name == "RestoreTimeScale")
            {
                FlxG.timeScale = 1;
            }
            else if (msg.name == "NextLevel")
            {
//                FlxG.fade(0xffd8eba2, 2.4, loadNextLevel);
                // [Debug]
                FlxG.log("NextLevel");
            }
            else if (msg.name == "RestartLevel")
            {
//                FlxG.fade(0xffd8eba2, 2.4, restartLevel);
                //[ [Debug]
                FlxG.log("RestartLevel");
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

        private function winOrLoseEffect():void
        {
            // slow motion
            FlxG.timeScale = 0.1;
            SeanG.switchboard.sendMessage("RestoreTimeScale", this, this, 1.6);
            FlxG.camera.shake(0.05, 0.1);
            FlxG.camera.flash(0xffd8eba2, 0.12);

            // disable player's control, remove time counter and popup score panel
            SeanG.player.controllable = false;
            _blur.removeSprite(_timeCounterText);
            _timeCounterText.kill();
        }

        private function loadNextLevel():void
        {
            SeanG.levelIndex += 1;
            if (SeanG.levelIndex < SeanG.levels.length)
                FlxG.switchState(new PlayState());
        }

        private function restartLevel():void
        {
            FlxG.resetState();
        }
	}
}
