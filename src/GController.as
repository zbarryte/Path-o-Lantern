package
{
	import org.flixel.FlxG;
	
	public class GController
	{
		public static const left:Array = ["LEFT","A"];
		public static const right:Array = ["RIGHT","D"];
		public static const up:Array = ["UP","W"];
		public static const down:Array = ["DOWN","S"];
		
		public static const pause:Array = ["ENTER","P","ESCAPE"];
		public static const select:Array = ["SPACE"];
		public static const back:Array = ["ESCAPE"];
		
		public static const curseBackwards:Array = left.concat(up);
		public static const curseForward:Array = right.concat(down);
		
		/**
		 * Checks whether or not any of the keys in the array is being pressed. Wraps <code>FlxG.keys.pressed</code>
		 * 
		 * @param	tmpKeys		An array of keys to check
		 * 
		 * @return	Whether any of the keys is being pressed
		 */
		public function pressed(tmpKeys:Array):Boolean {
			for (var i:uint = 0; i < tmpKeys.length; i++) {
				if (FlxG.keys.pressed(tmpKeys[i])) {
					return true;
					
					FlxG.keys.pressed
				}
			}
			return false;
		}
		
		/**
		 * Checks whether or not any of the keys in the array were just pressed. Wraps <code>FlxG.kys.justPressed</code>
		 * 
		 * @param	tmpKeys		An array of keys to check
		 * 
		 * @return 	Whether any of the keys were just pressed
		 */
		public function justPressed(tmpKeys:Array):Boolean {
			for (var i:uint = 0; i < tmpKeys.length; i++) {
				if (FlxG.keys.justPressed(tmpKeys[i])) {
					return true;
				}
			}
			return false;
		}
		
		/**
		 * Checks whether or not any of the keys in the array were just released. Wraps <code>FlxG.keys.justReleased</code>
		 * 
		 * @param	tmpKeys		An array of keys to check
		 * 
		 * @return	Whether any of the keys were just released
		 */
		public function justReleased(tmpKeys:Array):Boolean {
			for (var i:uint = 0; i <tmpKeys.length; i++) {
				if (FlxG.keys.justReleased(tmpKeys[i])) {
					return true;
				}
			}
			return false;
		}
		
		/**
		 * Checks whether or not any of the primary keys have priority over the secondary keys. Priority is given to the key last pressed and still held.
		 * 
		 * @param	tmpKeysPrimary		An array of primary keys
		 * @param 	tmpKeysSecondary	An array of secondary keys
		 * 
		 * return Whether or not the primary keys have priority over the secondary keys.
		 */
		public function pressedAfter(tmpKeysPrimary:Array,tmpKeysSecondary:Array):Boolean {
			return pressed(tmpKeysPrimary) && (justPressed(tmpKeysPrimary) || !pressed(tmpKeysSecondary));
		}
	}
}