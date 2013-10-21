package
{
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	
	public class ZState extends FlxState
	{
		private var isControllable:Boolean;
		
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
			setUpState();
			addDebugLayer();
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
			
			add(tmpDebugLabel);
		}
		
		/**
		 * Initializes private vars.
		 */
		private function setUpState():void {
			enableControls();
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
		
		override public function update():void {
			super.update();
			if (isControllable) {
				updateControls();
			}
		}
		
		/**
		 * Override this function to specify controls.
		 * This can be toggled on and off using <code>enableControls</code>,<code>disableControls</code>
		 */
		protected function updateControls():void {
			// implemented by children
		}
		
		public function switchToStateWithFade(tmpClass:Class,tmpDuration:Number=0,tmpColor:uint=0x00000000):void {
			var tmpCallback:Function = function():void {
				FlxG.switchState(new tmpClass());
			};
			FlxG.camera.fade(tmpColor,tmpDuration,tmpCallback);
		}
	}
}