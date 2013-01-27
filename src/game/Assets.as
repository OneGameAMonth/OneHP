/**
 * Sean Clover, 01/2013.
 * All rights received.
 */
package game
{
    public class Assets
    {
        // Hero assets
        [Embed(source="../../assets/Player.png")]
        public static var Img_Hero:Class;
        [Embed(source="../../assets/shoot.mp3")]
        public static var Snd_Shoot:Class;

        // Hero bullet
        [Embed(source="../../assets/Bullet.png")]
        public static var Img_Bullet:Class;

        // Boss assets
        [Embed(source="../../assets/BossMantis.png")]
        public static var Img_BossMantis:Class;
        [Embed(source="../../assets/gibs.png")]
        public static var Img_BossGibs:Class;

        // Platform assets
        [Embed(source="../../assets/Platform.png")]
        public static var Img_Platform:Class;

        // Level files
        [Embed(source="../../assets/mapCSV_Level_1_blocks.csv", mimeType="application/octet-stream")]
        public static var CSV_Level_1blocks:Class;
        [Embed(source="../../assets/Tileset.png")]
        public static var Img_Level_1blocks:Class;

        public function Assets() {}
    }
}
