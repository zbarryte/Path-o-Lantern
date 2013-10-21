package
{
	import flash.display.BitmapData;
	import flash.display.Graphics;
	
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	
	public class SprDarkness extends ZNode
	{
		protected var _pixelsOriginal:BitmapData;
		
		public function SprDarkness()
		{
			super();
			
			makeGraphic(FlxG.width,FlxG.height,0xff000000);
			scrollFactor = new FlxPoint(0,0);
			blend = "multiply";
			
			_pixelsOriginal = _pixels;
		}
		
		public function fillHoles():void {
			_pixels = _pixelsOriginal.clone();
		}
		
		public function drawHole(tmpPoint:FlxPoint,tmpRadius:Number):void {
			
			var tmpGfx:Graphics = FlxG.flashGfx;
			tmpGfx.clear();
			tmpGfx.beginFill(0xffffff,1);
			tmpGfx.drawCircle(tmpPoint.x,tmpPoint.y,tmpRadius);
			tmpGfx.endFill();
			
			_pixels.draw(FlxG.flashGfxSprite);
			dirty = true;
		}
	}
}