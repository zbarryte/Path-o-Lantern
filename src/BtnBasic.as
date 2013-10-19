package
{
	import org.flixel.FlxPoint;

	public class BtnBasic extends ZButton
	{
		private const kCurseColor:uint = 0xff8888;
		private const kUncurseColor:uint = 0xffffff;
		private const kCurseScale:FlxPoint = new FlxPoint(1.0,1.0);
		private const kUncurseScale:FlxPoint = new FlxPoint(0.88,0.88);
		
		public function BtnBasic(tmpSelectCallback:Function,tmpText:String=null,tmpX:Number=0,tmpY:Number=0)
		{
			super(tmpSelectCallback,tmpText,tmpX,tmpY,GSpritinator.kBtnMenuSheet);
		}
		
		override public function curse():void {
			color = kCurseColor;
			scale = kCurseScale;
		}
		
		override public function uncurse():void {
			color = kUncurseColor;
			scale = kUncurseScale;
		}
	}
}