package
{
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;

	public class ZMenu extends FlxGroup
	{
		protected var _buttonIndex:int;
		protected var _overlay:FlxSprite;
		
		public function ZMenu()
		{
			super();
			reset();
			
			_overlay = new FlxSprite();
			_overlay.makeGraphic(FlxG.width,FlxG.height,0xff000000);
			_overlay.alpha = 0.5;
		}
		
		/**
		 * Adds a button to the menu.
		 * It must be a <code>ZButton</code>
		 * 
		 * @param	tmpBtn	The button to be added.
		 * 
		 */
		public function addButton(tmpBtn:ZButton):void {
			if (isEmpty()) {tmpBtn.curse()}
			add(tmpBtn);
		}
		
		/**
		 * Curse next button, going forward. Uncurse previous button.
		 */
		public function curseForward():void {
			if (isEmpty()) {return;}
			button.uncurse();
			buttonIndex ++;
			button.curse();
			
		}
		
		/**
		 * Curse next button, going backwards. Uncurse previous button.
		 */
		public function curseBackwards():void {
			if (isEmpty()) {return;}
			button.uncurse();
			buttonIndex --;
			button.curse();
		}
		
		/**
		 * The button currently cursed.
		 * It's located by button index.
		 */
		public function get button():ZButton {
			var tmpBtn:ZButton = members[buttonIndex];
			return tmpBtn;
		}
		
		/**
		 * The button Index marks which button is currently cursed.
		 */
		public function get buttonIndex():int {
			return _buttonIndex;
		}
		
		/**
		 * Sets the button Index without going out of bounds.
		 */
		public function set buttonIndex(tmpButtonIndex:int):void {
			_buttonIndex = tmpButtonIndex;
			if (_buttonIndex > length - 1) {_buttonIndex = 0;}
			if (_buttonIndex < 0) {_buttonIndex = length - 1;}
		}
		
		/**
		 * Returns whether or not there are any buttons in the menu.
		 */
		private function isEmpty():Boolean {
			return length == 0;
		}
		
		/**
		 * Select the current button.
		 */
		public function select():void {
			button.select();
		}
		
		/**
		 * Reset the cursed button to be the first.
		 */
		public function reset():void {
			_buttonIndex = 0;
			if (!isEmpty()) {button.curse();}
			for (var i:uint = 1; i < length; i++) {
				var tmpBtn:ZButton = members[i];
				tmpBtn.uncurse();
			}
		}
		
		/**
		 * Overridden draw, draws the overlay under the buttons.
		 * Do not override this in children, unless you call <code>super</code>
		 */
		override public function draw():void {
			_overlay.draw();
			super.draw();
		}
	}
}