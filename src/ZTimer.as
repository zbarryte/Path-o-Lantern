package
{
	import org.flixel.*;
	
	public class ZTimer extends FlxBasic
	{
		protected var time:Number; // the amount of time elapsed, in seconds
		protected var period:Number; // the amount of time to complete 1 cycle, in seconds
		protected var event:Function; // the event fired each period
		protected var pulse:Function // fired each cycle
		protected var resetPulse:Function // resets the pulse 
		protected var isLooped:Boolean; // does the cycle repeat?
		protected var isPlaying:Boolean; // is the cycle progressing?
		protected var direction:int; // the direction of the cycle, +/- 1
		
		public function ZTimer(_period:Number,_event:Function,_isLooped:Boolean=true,_isAutomatic:Boolean=true,_pulse:Function=null,_resetPulse:Function=null)
		{
			time = 0;
			direction = 1;
			period = _period;
			event = _event;
			pulse = _pulse;
			resetPulse = _resetPulse;
			isLooped = _isLooped;
			isPlaying = _isAutomatic;
			
			// reset
			if (resetPulse!=null) {resetPulse();}
			
			super();
		}
		
		public function start():void {
			isPlaying = true;
		}
		
		public function stop():void {
			isPlaying = false;
			// restart the timer and dir
			time = 0;
			direction = 1;
			// reset
			if (resetPulse!=null) {resetPulse();}
		}
		
		public function reset():void {
			stop();
			start();
		}
		
		override public function update():void {
			// start timing if playing
			if (isPlaying) {
				time += FlxG.elapsed;
				// every cycle
				if (pulse!=null) {pulse(direction);}
				// every period...
				if (time >= period) {
					// restart the timer and fire the event
					time = 0;
					direction *= -1;
					event();
					// stop non-looping events after the first cycle
					if (!isLooped) {
						stop();
					}
				}
			}
		}
	}
}