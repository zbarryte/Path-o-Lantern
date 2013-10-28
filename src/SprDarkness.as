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
			tmpGfx.beginFill(0xffffff,0.5);
			tmpGfx.drawCircle(tmpPoint.x,tmpPoint.y,tmpRadius);
			tmpGfx.beginFill(0xffffff,0.75);
			tmpGfx.drawCircle(tmpPoint.x,tmpPoint.y,tmpRadius*0.97);
			tmpGfx.beginFill(0xffffff,1);
			tmpGfx.drawCircle(tmpPoint.x,tmpPoint.y,tmpRadius*0.84);
			tmpGfx.endFill();
			
			_pixels.draw(FlxG.flashGfxSprite);
			dirty = true;
		}
		
		public function drawHoleAtNode(tmpNode:ZNode,tmpRadius:Number):void {
			//var tmpPoint:FlxPoint = new FlxPoint(tmpNode.x+tmpNode.width/2.0,tmpNode.y+tmpNode.height/2.0);
			var tmpPoint:FlxPoint = tmpNode.getScreenXY();
			tmpPoint.x += tmpNode.width/2.0;
			tmpPoint.y += tmpNode.height/2.0;
			drawHole(tmpPoint,tmpRadius);
		}
	}
}