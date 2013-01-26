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

        // Hero bullet
        [Embed(source="../../assets/Bullet.png")]
        public static var Img_Bullet:Class;

        [Embed(source="../../assets/BossMantis.png")]
        public static var Img_BossMantis:Class;

        public function Assets() {}
    }
}
