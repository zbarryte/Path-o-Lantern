package
{
	public class SprWall extends ZNode
	{
		public function SprWall(tmpX:Number=0, tmpY:Number=0)
		{
			super(tmpX,tmpY,GSpritinator.kWallSheet);
			immovable = true;
		}
	}
}