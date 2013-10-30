package
{
	public class SprHint extends ZNode
	{
		protected var hideShowTimer:ZTimer;
		
		public function SprHint(tmpX:Number=0, tmpY:Number=0, tmpSimpleGraphic:Class=null)
		{
			super(tmpX, tmpY, GSpritinator.kControlsSheet);
			alpha = 0;
		}
		
		public function show():void {
			if (alpha != 0) {return;}
			var tmpPulse:Function = function():void {
				alpha += 0.22;
			}
			var tmpEvent:Function = function():void {
				alpha = 1;	
			}
			hideShowTimer = new ZTimer(0.22,tmpEvent,false,true,tmpPulse,null);
		}
		
		public function hide():void {
			if (alpha != 1) {return;}
			var tmpPulse:Function = function():void {
				alpha -= 0.22;
			}
			var tmpEvent:Function = function():void {
				alpha = 0;	
			}
			hideShowTimer = new ZTimer(0.22,tmpEvent,false,true,tmpPulse,null);
		}
		
		override public function update():void {
			super.update();
			if (hideShowTimer) {hideShowTimer.update();}
		}
	}
}