package
{
	import org.flixel.FlxText;
	import org.flixel.FlxG;

	public class ZButton extends ZNode
	{
		protected var _selectCallback:Function;
		
		public function ZButton(tmpSelectCallback:Function,tmpText:String=null,tmpX:Number=0,tmpY:Number=0,tmpSimpleGraphic:Class=null)
		{
			super(tmpX,tmpY,tmpSimpleGraphic);
			
			_selectCallback = tmpSelectCallback;
			
			if (tmpText) {
				var tmpLabel:FlxText = new FlxText(0,0,width);
				tmpLabel.text = tmpText;
				tmpLabel.alignment = "center";
				tmpLabel.size = height/3.0;
				tmpLabel.y = height/2.0 - tmpLabel.height/2.0;
				add(tmpLabel);
				tmpLabel.scrollFactor.x = 0;
				tmpLabel.scrollFactor.y = 0;
			}
			
			uncurse();
			scrollFactor.x = 0;
			scrollFactor.y = 0;
		}
		
		/**
		 * Curses the button.
		 * Override this function to specify how the button reacts to being cursed.
		 */
		public function curse():void {
			// implemented by children
		}
		
		/** 
		 * Uncurses the button.
		 * Override this function to specify how the button reacts to being uncursed.
		 */
		public function uncurse():void {
			// implemented by children
		}
		
		/**
		 * Selects the button.
		 * Overriding this function will change any behavior specified by the button's selectCallback unless <code>super</code> is called.
		 * So call <code>super</code> if you're going to override this.
		 */
		public function select():void {
			if (_selectCallback!=null) {_selectCallback();}
		}
	}
}