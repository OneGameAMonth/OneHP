//Code generated with DAME. http://www.dambots.com

package game.levels
{
	import org.flixel.*;
	import flash.utils.Dictionary;
	// Custom imports:
import game.doodads.Platform;
	public class Level_Level_4 extends BaseLevel
	{
		//Embedded media...
		[Embed(source="../../../assets/mapCSV_Level_4_blocks.csv", mimeType="application/octet-stream")] public var CSV_blocks:Class;
		[Embed(source="../../../assets/Tileset.png")] public var Img_blocks:Class;

		//Tilemaps
		public var layerblocks:FlxTilemap;

		//Sprites
		public var PlatformsGroup:FlxGroup = new FlxGroup;

		//Properties
		public var time:Number = 20.000000;


		public function Level_Level_4(addToStage:Boolean = true, onAddCallback:Function = null, parentObject:Object = null)
		{
			// Generate maps.
			var properties:Array = [];
			var tileProperties:Dictionary = new Dictionary;

			properties = generateProperties( null );
			layerblocks = addTilemap( CSV_blocks, Img_blocks, 0.000, 0.000, 8, 8, 1.000, 1.000, false, 1, 1, properties, onAddCallback );

			//Add layers to the master group in correct order.
			masterLayer.add(PlatformsGroup);
			masterLayer.add(layerblocks);

			if ( addToStage )
				createObjects(onAddCallback, parentObject);

			boundsMinX = 0;
			boundsMinY = 0;
			boundsMaxX = 240;
			boundsMaxY = 320;
			boundsMin = new FlxPoint(0, 0);
			boundsMax = new FlxPoint(240, 320);
			bgColor = 0xff333333;
		}

		override public function createObjects(onAddCallback:Function = null, parentObject:Object = null):void
		{
			addSpritesForLayerPlatforms(onAddCallback);
			generateObjectLinks(onAddCallback);
			if ( parentObject != null )
				parentObject.add(masterLayer);
			else
				FlxG.state.add(masterLayer);
		}

		public function addSpritesForLayerPlatforms(onAddCallback:Function = null):void
		{
			addSpriteToLayer("one-off", null, Platform, PlatformsGroup , 96.000, 240.000, 0.000, 1, 1, false, 1.000, 1.000, generateProperties( { name:"type", value:"one-off" }, null ), onAddCallback );//"Platform"
			addSpriteToLayer("one-off", null, Platform, PlatformsGroup , 96.000, 176.000, 0.000, 1, 1, false, 1.000, 1.000, generateProperties( { name:"type", value:"one-off" }, null ), onAddCallback );//"Platform"
			addSpriteToLayer("one-off", null, Platform, PlatformsGroup , 144.000, 144.000, 0.000, 1, 1, false, 1.000, 1.000, generateProperties( { name:"type", value:"one-off" }, null ), onAddCallback );//"Platform"
			addSpriteToLayer("one-off", null, Platform, PlatformsGroup , 48.000, 208.000, 0.000, 1, 1, false, 1.000, 1.000, generateProperties( { name:"type", value:"one-off" }, null ), onAddCallback );//"Platform"
			addSpriteToLayer("normal", null, Platform, PlatformsGroup , 144.000, 272.000, 0.000, 1, 1, false, 1.000, 1.000, generateProperties( { name:"type", value:"normal" }, null ), onAddCallback );//"Platform"
		}

		public function generateObjectLinks(onAddCallback:Function = null):void
		{
		}

	}
}
