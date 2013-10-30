package
{
	public class SprHouse extends ZNode
	{
		protected var _radius:Number = 66;
		
		public function SprHouse(tmpX:Number=0, tmpY:Number=0)
		{
			super(tmpX,tmpY,GSpritinator.kHouseSheet);
			
			var tmpRoof:ZNode = new ZNode();
			tmpRoof.loadGraphic(GSpritinator.kHouseRoofSheet);
			tmpRoof.y = -height + tmpRoof.height/2.0;
			add(tmpRoof);
		}
		
		public function get radius():Number {
			return _radius;
		}
	}
}