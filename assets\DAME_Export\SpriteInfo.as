//Code generated with DAME. http://www.dambots.com

package com.DAME_Export
{
	public class SpriteInfo
	{
		var spriteList:Array = [];
		public function SpriteInfo():void
		{
			var spriteData:SpriteData;

			spriteData = new SpriteData("Platform", "Platform");
			spriteData.animData.push( new AnimData( "normal",[0,0], 0.500, false ) );
			spriteData.animData.push( new AnimData( "one-off",[1,1], 0.500, false ) );
			spriteList.push( spriteData );

		}
	}
}
