package
{
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxPoint;
	
	public class ZState extends FlxState
	{
		private var isControllable:Boolean;
		private var isPlayable:Boolean;
		private var isUpdatable:Boolean;
		
		public function ZState()
		{
			super();
		}
		
		/**
		 * Overridden create method.
		 * 
		 * WARNING: if you call this directly, you'll miss some of the ZState wrapping unless you remember to call super.
		 * So don't.
		 */
		override public function create():void
		{
			createObjects();
			addDebugLayer();
			
			resume();
			enableControls();
			enableUpdate();
		}
		
		/**
		 * Creates the objects to use in the state.
		 * This function is called by <code>create</code>. Override this, NOT <code>create</code>.
		 */
		protected function createObjects():void {
			// implemented by children
		}
		
		/**
		 * Adds a label to remind that we're in debug mode.
		 */
		private function addDebugLayer():void {
			
			if (!Glob.kDebugOn) {return;}
			
			var tmpDebugLabel:FlxText = new FlxText(0,0,FlxG.width);
			tmpDebugLabel.text = "** DEBUG MODE **";
			tmpDebugLabel.alignment = "center";
			tmpDebugLabel.scrollFactor = new FlxPoint(0,0);
			
			add(tmpDebugLabel);
		}
		
		/**
		 * Enables control input on state, provided all controls are in <code>updateControls</code>
		 */
		public function enableControls():void {
			isControllable = true;
		}
		
		/**
		 * Disables control input on state, provided all controls are in <code>updateControls</code>
		 */ 
		public function disableControls():void {
			isControllable = false;
		}
		
		/**
		 * Enables control input on state, provided all controls are in <code>updatePlay</code>
		 */
		public function resume():void {
			isPlayable = true;
		}
		
		/**
		 * Disables control input on state, provided all controls are in <code>updatePlay</code>
		 */ 
		public function pause():void {
			isPlayable = false;
		}
		
		/**
		 * Contains some update logic.
		 * Overriding this function will obfuscate the logic unless you call <code>super</code>
		 */
		override public function update():void {
			if (!isUpdatable) {return;}
			
			if (isPlayable) {
				super.update();
				updatePlay();
				if (isControllable) {
					updateControls();
				}
			} else {
				updatePause();
			}
		}
		
		/**
		 * Called when playing.
		 * Overide this function to specify play.
		 * This can be turned on and off using <code>resume</code>,<code>pause</code>
		 */
		protected function updatePlay():void {
			// implemented by children
		}
		
		/**
		 * Override this function to specify controls.
		 * This can be turned on and off using <code>enableControls</code>,<code>disableControls</code>
		 */
		protected function updateControls():void {
			// implemented by children
		}
		
		/**
		 * Called when not playing.
		 * Override this function to specify updates while paused.
		 * This can be turned on and off using <code>pause</code>,<code>resume</code>
		 */
		protected function updatePause():void {
			// implemented by children
		}
		
		public function switchToStateWithFade(tmpClass:Class,tmpDuration:Number=0,tmpColor:uint=0x00000000):void {
			var tmpCallback:Function = function():void {
				FlxG.switchState(new tmpClass());
			};
			FlxG.camera.fade(tmpColor,tmpDuration,tmpCallback);
		}
		
		/**
		 * Call to allow updating in general
		 */
		protected function enableUpdate():void {
			isUpdatable = true;
		}
		
		/**
		 * Call to stop updating in general
		 */
		protected function disableUpdate():void {
			isUpdatable = false;
		}
	}
}