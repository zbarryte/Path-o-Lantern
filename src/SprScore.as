package
{
	import org.flixel.FlxText;

	public class SprScore extends ZNode
	{
		protected var _text:FlxText;
		
		public function SprScore(tmpX:Number=0, tmpY:Number=0)
		{
			super(tmpX, tmpY, GSpritinator.kScoreSheet);
			
			_text = new FlxText(0,0,width);
			_text.y = height/2.0 - _text.height/2.0;
			_text.x = 4;
			_text.scrollFactor.x = 0;
			_text.scrollFactor.y = 0;
			
			add(_text);
			
			scrollFactor.x = 0;
			scrollFactor.y = 0;
		}
		
		public function set score(tmpScore:uint):void {
			_text.text = "SCORE : "+tmpScore;
		}
	}
}