package
{
	public class SprCandy extends ZNode
	{
		public function SprCandy(tmpX:Number=0, tmpY:Number=0)
		{
			super(tmpX, tmpY, GSpritinator.kCandySheet);
			
			angle = Math.random()*360;
			color = Math.random()*0xffffff;
			
			alpha = 0.88;
		}
	}
}