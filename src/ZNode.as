package
{
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	
	public class ZNode extends FlxSprite
	{
		protected var _children:FlxGroup;
		
		public function ZNode(tmpX:Number=0,tmpY:Number=0,tmpSimpleGraphic:Class=null)
		{
			super(tmpX,tmpY,tmpSimpleGraphic);
			
			_children = new FlxGroup();
		}
		
		/**
		 * Add a child (a FlxSprite of some kind) to the node.
		 * It will be displayed relative to the node, though it will be physically located at the offset.
		 * 
		 * @param	tmpSpr	The sprite to be displayed
		 * 
		 */
		public function add(tmpSpr:FlxSprite):void {
			_children.add(tmpSpr);
		}
		
		/**
		 * Draws node and its children.
		 * Temporarily moves children into place, and then resets their values to their originals.
		 */
		override public function draw():void {
			super.draw();
			for (var i:uint = 0; i < _children.length; i++) {
				var tmpChild:FlxSprite = _children.members[i];
				// store original values
				var tmpX:Number = tmpChild.x;
				var tmpY:Number = tmpChild.y;
				var tmpColor:uint = tmpChild.color;
				// offset child values
				tmpChild.x = x + tmpChild.x;
				tmpChild.y = y + tmpChild.y;
				tmpChild.color = color;
				// draw child
				tmpChild.draw();
				// reset child's offset values to original values
				tmpChild.x = tmpX;
				tmpChild.y = tmpY;
				tmpChild.color = tmpColor;
			}
		}
		
		override public function update():void {
			super.update();
			updateMechanics();
			updateAV();
		}
		
		protected function updateMechanics():void {
			// implemented by children
		}
		
		protected function updateAV():void {
			// implemented by children
		}
		
		override public function postUpdate():void {
			super.postUpdate();
			for (var i:uint = 0; i < _children.length; i++) {
				var tmpChild:FlxSprite = _children.members[i];
				tmpChild.postUpdate();
			}
		}
		
		public function placeBelowSprite(tmpSpr:FlxSprite,tmpMargin:int=0):void {
			x = tmpSpr.x;
			y = tmpSpr.y + tmpSpr.height + tmpMargin;
		}
		
		public function placeAboveSprite(tmpSpr:FlxSprite,tmpMargin:int=0):void {
			x = tmpSpr.x;
			y = tmpSpr.y - height - tmpMargin;
		}
		
		public function placeRightOfSprite(tmpSpr:FlxSprite,tmpMargin:int=0):void {
			x = tmpSpr.x + tmpSpr.width + tmpMargin;
			y = tmpSpr.y;
		}
		
		public function placeLeftOfSprite(tmpSpr:FlxSprite,tmpMargin:int=0):void {
			x = tmpSpr.x - width - tmpMargin;
			y = tmpSpr.y;
		}
		
		public function placeAtScreenXPercentage(tmpPercentage:Number):void {
			x = FlxG.width*tmpPercentage - width/2.0;
		}
		
		public function placeAtScreenYPercentage(tmpPercentage:Number):void {
			y = FlxG.height*tmpPercentage - height/2.0;
		}
		
		public function centerX():void {
			placeAtScreenXPercentage(0.5);
		}
		
		public function centerY():void {
			placeAtScreenYPercentage(0.5);
		}
		
		public function centerXY():void {
			centerX();
			centerY();
		}
		
		public function placeFarLeft():void {
			x = 0;
		}
		
		public function placeFarRight():void {
			x = FlxG.width - width;
		}
		
		public function placeFarTop():void {
			y = 0;
		}
		
		public function placeFarBottom():void {
			y = FlxG.height - height;
		}
	}
}