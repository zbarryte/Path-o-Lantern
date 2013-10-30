package
{
	public class SprHouse extends ZNode
	{
		protected var _radius:Number = 66;
		
		public function SprHouse(tmpX:Number=0, tmpY:Number=0)
		{
			super(tmpX,tmpY,GSpritinator.kHouseSheet);
		}
		
		public function get radius():Number {
			return _radius;
		}
	}
}