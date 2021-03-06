package
{
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxPoint;
	import org.flixel.FlxTilemap;
	
	public class GLeveler
	{
		public var points:uint;
		
		public static const kTileLength:uint = 16;
		
		public var lvlNum:uint;
		private const lvlNumTopCap:uint = 22;
		//private const lvlNumTopCap:uint = 0;
		private function get lvlPercentageToMaxDifficulty():Number {
			if (lvlNum > lvlNumTopCap) {return 1.0;}
			var tmpVal:Number = 1.0 - Number(lvlNumTopCap - lvlNum)/Number(lvlNumTopCap);
			return tmpVal;
		}
		
		/*
		public function log():void {
			FlxG.log(lvlPercentageToMaxDifficulty);
		}
		*/
		
		public static const kArraySpawnPumpkin:Array = [kSpawnFuncPumpkin];
		public static const kArraySpawnWall:Array = [kSpawnFuncWall];
		public static const kArraySpawnHouse:Array = [kSpawnFuncHouse];
		public static const kArraySpawnHorror:Array = [kSpawnFuncHorror];
		public static const kArraySpawnCandy:Array = [kSpawnFuncHorror,kSpawnFuncEmpty];
		
		private static const kSpawnFuncEmpty:uint = 2;
		private static const kSpawnFuncWall:uint = 3;
		private static const kSpawnFuncPumpkin:uint = 4;
		private static const kSpawnFuncHouse:uint = 5;
		private static const kSpawnFuncHorror:uint = 6;
		
		[Embed(source="assets/tileset_functional.png")] private const kTilesetFuncSheet:Class;
		
		/**
		 * Width or height of a dig box, measured in tiles.
		 */
		private const kNumTilesPerDigBox:uint = 5;
		
		private const kNumDigBoxesMax:uint = 22;
		private const kNumDigBoxesMin:uint = 5;
		
		/**
		 * Width or Height of tile map, measured in tiles.
		 */
		private function get numTilesAcross():uint {
			return (kNumDigBoxesMin + int((kNumDigBoxesMax - kNumDigBoxesMin)*lvlPercentageToMaxDifficulty))*kNumTilesPerDigBox;
		}
		
		/**
		 * Width of tile map, measured in tiles.
		 */
		private function get widthInTiles():uint {
			return numTilesAcross;
		}
		
		/**
		 * Height of tile map, measured in tiles.
		 */
		private function get heightInTiles():uint {
			return numTilesAcross;
		}
		
		/**
		 * Width of tile map, measured in dig boxes.
		 */
		private function get widthInDigBoxes():uint {
			return widthInTiles/kNumTilesPerDigBox;
		}
		
		/**
		 * Height of tile map, measured in dig boxes.
		 */
		private function get heightInDigBoxes():uint {
			return heightInTiles/kNumTilesPerDigBox;
		}
		
		public function GLeveler()
		{
			super();
			reset();
		}
		
		/**
		 * Resets starting level to level 0.
		 */
		public function reset():void {
			lvlNum = 0;
			points = 0;
		}
		
		/**
		 * Automatically generates the functional tilemap based on the level number (difficulty).
		 * Calls on <code>generateLvlData</code> to create the array, so that actually does most of the work.
		 * This is mostly just the parser for <code>generateLvlData</code> or something like that.
		 */
		public function get levelFunc():FlxTilemap {
			var tmpTilemap:FlxTilemap = new FlxTilemap();
			
			var lvlData:Array = generateLvlData();
			
			var tmpLvlCSV:String = FlxTilemap.arrayToCSV(lvlData,widthInTiles,true);
			tmpTilemap.loadMap(tmpLvlCSV,kTilesetFuncSheet,kTileLength,kTileLength);
			
			FlxG.log(widthInDigBoxes);
			
			return tmpTilemap;
		}
		
		/**
		 * Max number of digs made in the walls.
		 */
		private function get maxDigs():uint {
			return widthInDigBoxes*heightInDigBoxes*0.7;
		}
		
		private const kNumHorrorsMax:uint = 22;
		private function get numHorrors():uint {
			return lvlPercentageToMaxDifficulty*kNumHorrorsMax;
		}
		
		/**
		 * Internal
		 * 
		 * Modifies the array to spec.
		 * Starts at a random point in the array, and then digs through.
		 * 
		 */
		private function generateLvlData():Array {
			var tmpArray:Array = initArray();
			var tmpPoint:FlxPoint = randomPointInRange();
			var tmpNextPoint:FlxPoint;
			var tmpPtArray:Array;
			
			// dig this many times
			for (var i:uint = 0; i < maxDigs; i++) {
				tmpPtArray = nextRandomDigPointInRange(tmpPoint,tmpArray);
				tmpPoint = tmpPtArray[0];
				tmpNextPoint = tmpPtArray[1];
				putSpawnPointsBetweenCenterPointsInArray(tmpArray,kSpawnFuncEmpty,tmpPoint,tmpNextPoint);
				var tmpSpawn:uint = (i >= maxDigs -1) ? kSpawnFuncHouse : kSpawnFuncEmpty;
				
				putSpawnAtPointInArray(tmpArray,tmpSpawn,tmpNextPoint);
				tmpPoint = tmpNextPoint;
			}
			
			for (var j:uint = 0; j < numHorrors; j++) {
				putSpawnInAnyEmpty(tmpArray,kSpawnFuncHorror);
			}
			
			putSpawnInAnyEmpty(tmpArray,kSpawnFuncPumpkin);
			//putSpawnInAnyEmpty(tmpArray,kSpawnFuncHouse);
			
			return tmpArray;
		}
		
		/**
		 * Inits the array. Starts with wall tiles, so that it can be dug.
		 * 
		 */
		private function initArray():Array {
			var tmpArray:Array = new Array();
			for (var i:uint = 0; i < widthInTiles*heightInTiles; i++) {
				tmpArray.push(kSpawnFuncWall);
			}
			return tmpArray;
		}
		
		/**
		 * Picks a random dig box column.
		 */
		private function randomXInRange():uint {
			var tmpX:uint = Math.random()*widthInDigBoxes;
			return tmpX*kNumTilesPerDigBox;
		}
		
		/**
		 * Picks a random dig box row.
		 */
		private function randomYInRange():uint {
			var tmpY:uint = Math.random()*heightInDigBoxes;
			return tmpY*kNumTilesPerDigBox;
		}
		
		/**
		 * Picks a random dig box.
		 */
		private function randomPointInRange():FlxPoint {
			var tmpX:uint = randomXInRange();
			var tmpY:uint = randomYInRange();
			var tmpPoint:FlxPoint = new FlxPoint(tmpX,tmpY);
			return tmpPoint;
		}
		
		private function putSpawnInAnyEmpty(tmpArray:Array,tmpSpawn:uint):void {
			var tmpPoint:FlxPoint = randomPointInRange();
			var tmpIndex:uint = arrayIndexForDigBoxCoordsCenter(tmpPoint.x,tmpPoint.y);
			if (tmpArray[tmpIndex] == kSpawnFuncEmpty) {
				tmpArray[tmpIndex] = tmpSpawn;
			} else {
				putSpawnInAnyEmpty(tmpArray,tmpSpawn);
			}
		}
		
		private function putSpawnAtPointInArray(tmpArray:Array,tmpSpawn:uint,tmpPoint:FlxPoint):void {
			var tmpArrayIndex:uint = arrayIndexForDigBoxCoordsCenter(tmpPoint.x,tmpPoint.y);
			if (tmpArray[tmpArrayIndex] == kSpawnFuncPumpkin || tmpArray[tmpArrayIndex] == kSpawnFuncHouse) {return;}
			tmpArray[tmpArrayIndex] = tmpSpawn;
			
			tmpSpawn = kSpawnFuncEmpty;
			// also fill the square around it, this is messy
			var tmpOtherIndex:uint;
			tmpOtherIndex = tmpArrayIndex + 1;
			tmpArray[tmpOtherIndex] = tmpSpawn;
			tmpOtherIndex = tmpArrayIndex - 1;
			tmpArray[tmpOtherIndex] = tmpSpawn;
			tmpOtherIndex = tmpArrayIndex + widthInTiles;
			tmpArray[tmpOtherIndex] = tmpSpawn;
			tmpOtherIndex = tmpArrayIndex - widthInTiles;
			tmpArray[tmpOtherIndex] = tmpSpawn;
			tmpOtherIndex = tmpArrayIndex + widthInTiles + 1;
			tmpArray[tmpOtherIndex] = tmpSpawn;
			tmpOtherIndex = tmpArrayIndex + widthInTiles - 1;
			tmpArray[tmpOtherIndex] = tmpSpawn;
			tmpOtherIndex = tmpArrayIndex - widthInTiles + 1;
			tmpArray[tmpOtherIndex] = tmpSpawn;
			tmpOtherIndex = tmpArrayIndex - widthInTiles - 1;
			tmpArray[tmpOtherIndex] = tmpSpawn;
		}
		
		private function putSpawnPointsBetweenCenterPointsInArray(tmpArray:Array,tmpSpawn:uint,tmpStart:FlxPoint,tmpEnd:FlxPoint):void {
			
			if (Math.abs(tmpStart.x-tmpEnd.x) > kNumTilesPerDigBox || Math.abs(tmpStart.y-tmpEnd.y) > kNumTilesPerDigBox) {return;}
			
			var i:uint;
			var tmpPoint:FlxPoint;
			var tmpArrayIndex:uint;
			
			// up or down
			if (tmpStart.x == tmpEnd.x) {
				// up
				if (tmpStart.y > tmpEnd.y) {
					for (i = tmpEnd.y; i < tmpStart.y; i++) {
						tmpPoint = new FlxPoint(tmpStart.x,i);
						tmpArrayIndex = arrayIndexForDigBoxCoordsCenter(tmpPoint.x,tmpPoint.y);
						tmpArray[tmpArrayIndex+1] = tmpSpawn;
						tmpArray[tmpArrayIndex-1] = tmpSpawn;
						if (tmpArray[tmpArrayIndex] == kSpawnFuncPumpkin || tmpArray[tmpArrayIndex] == kSpawnFuncHouse) {continue;}
						tmpArray[tmpArrayIndex] = tmpSpawn;
					}
				}
				// down
				else if (tmpStart.y < tmpEnd.y) {
					for (i = tmpStart.y; i < tmpEnd.y; i++) {
						tmpPoint = new FlxPoint(tmpEnd.x,i);
						tmpArrayIndex = arrayIndexForDigBoxCoordsCenter(tmpPoint.x,tmpPoint.y);
						tmpArray[tmpArrayIndex+1] = tmpSpawn;
						tmpArray[tmpArrayIndex-1] = tmpSpawn;
						if (tmpArray[tmpArrayIndex] == kSpawnFuncPumpkin || tmpArray[tmpArrayIndex] == kSpawnFuncHouse) {continue;}
						tmpArray[tmpArrayIndex] = tmpSpawn;
					}
				}
			}
			// left or right
			else if (tmpStart.y == tmpEnd.y) {
				
				var tmpArrayStart:uint = arrayIndexForDigBoxCoordsCenter(tmpStart.x,tmpStart.y);
				var tmpArrayEnd:uint = arrayIndexForDigBoxCoordsCenter(tmpEnd.x,tmpEnd.y);
				
				// left
				if (tmpStart.x > tmpEnd.x) {
					for (i = tmpArrayEnd; i < tmpArrayStart; i++) {
						if (tmpArray[i] == kSpawnFuncPumpkin || tmpArray[i] == kSpawnFuncHouse) {continue;}
						tmpArray[i] = tmpSpawn;
						tmpArray[i+widthInTiles] = tmpSpawn;
						tmpArray[i-widthInTiles] = tmpSpawn;
					}
				}
				// right
				else if (tmpStart.x < tmpEnd.x) {
					for (i = tmpArrayStart; i < tmpArrayEnd; i++) {
						if (tmpArray[i] == kSpawnFuncPumpkin || tmpArray[i] == kSpawnFuncHouse) {continue;}
						tmpArray[i] = tmpSpawn;
						tmpArray[i+widthInTiles] = tmpSpawn;
						tmpArray[i-widthInTiles] = tmpSpawn;
					}
				}
			}
		}
		
		/**
		 * Internal
		 * 
		 * Digs. Won't dig if it would go out of bounds to do so.
		 * 
		 */
		private function nextRandomDigPointInRange(tmpPoint:FlxPoint,tmpArray:Array):Array {
			
			var returnPoint:FlxPoint = null;
			
			while (returnPoint == null) {
								
				var randomDir:uint = Math.random()*4;
								
				// up
				if (randomDir == 0) {
					if (tmpPoint.y - kNumTilesPerDigBox >= 0) {
						returnPoint = new FlxPoint(tmpPoint.x,tmpPoint.y - kNumTilesPerDigBox);
					}
				}
				// down
				else if (randomDir == 1) {
					if (tmpPoint.y + kNumTilesPerDigBox < heightInTiles) {
						returnPoint = new FlxPoint(tmpPoint.x,tmpPoint.y + kNumTilesPerDigBox);
					}
				}
				// left
				else if (randomDir == 2) {
					if (tmpPoint.x - kNumTilesPerDigBox >= 0) {
						returnPoint = new FlxPoint(tmpPoint.x - kNumTilesPerDigBox,tmpPoint.y);
					}
				}
				// right
				else if (randomDir == 3) {
					if (tmpPoint.x + kNumTilesPerDigBox < widthInTiles) {
						returnPoint = new FlxPoint(tmpPoint.x + kNumTilesPerDigBox,tmpPoint.y);
					}
				}
				else {
					FlxG.log("ERROR: randomDir == "+randomDir);
				}
				
				if (isPointAlreadyDugInArray(returnPoint,tmpArray)) {
					returnPoint = null;
					tmpPoint = randomPointAlreadyDugInArray(tmpArray);
				}
			}
			
			return [tmpPoint,returnPoint];
		}
		
		private function isPointAlreadyDugInArray(tmpPoint:FlxPoint,tmpArray:Array):Boolean {
			if (tmpPoint == null) return false;
			var tmpArrayIndex:uint = arrayIndexForDigBoxCoordsCenter(tmpPoint.x,tmpPoint.y);
			return (tmpArray[tmpArrayIndex] == kSpawnFuncEmpty);
		}
		
		private function randomPointAlreadyDugInArray(tmpArray:Array):FlxPoint {
			var tmpPoint:FlxPoint = null;
			
			while (tmpPoint == null) {
				var randPoint:FlxPoint = randomPointInRange();			
				var randArrayIndex:uint = arrayIndexForDigBoxCoordsCenter(randPoint.x,randPoint.y);
				if (tmpArray[randArrayIndex] == kSpawnFuncEmpty) {
					tmpPoint = randPoint;
				}
			}
			
			return tmpPoint;
		}
		
		/**
		 * Internal
		 * 
		 * Mostly used for debugging, since it makes it pretty clear where centers are.
		 * 
		 */
		private function putSpawnAtEachCenterOfArray(tmpArray:Array,tmpSpawn:uint):void {
			for (var row:uint = 0; row < widthInDigBoxes; row++) {
				for (var col:uint = 0; col < heightInDigBoxes; col++) {
					var tmpX:uint = row*kNumTilesPerDigBox;
					var tmpY:uint = col*kNumTilesPerDigBox;
					var tmpArrayIndex:uint = arrayIndexForDigBoxCoordsCenter(tmpX,tmpY);
					tmpArray[tmpArrayIndex] = tmpSpawn;
				}
			}
		}
		
		private function arrayIndexForDigBoxCoordsUpperLeft(tmpX:uint,tmpY:uint):uint {
			return tmpY*widthInTiles + tmpX;
		}
		
		private function arrayIndexForDigBoxCoordsCenter(tmpX:uint,tmpY:uint):uint {
			tmpX += kNumTilesPerDigBox/2.0;
			tmpY += kNumTilesPerDigBox/2.0;
			return tmpY*widthInTiles + tmpX;
		}
		
		/**
		 * Centers a tilemap on the screen
		 */
		public static function center(tmpLvl:FlxTilemap):void {
			tmpLvl.x = FlxG.width/2.0 - tmpLvl.width/2.0;
			tmpLvl.y = FlxG.height/2.0 - tmpLvl.height/2.0;
		}
		
		/**
		 * Creates an object of the specified class at each spawn point.
		 * Returns the group of objects.
		 */
		public static function groupFromSpawn(tmpSpawn:Array,tmpClass:Class,tmpLvl:FlxTilemap):FlxGroup {
			var tmpGroup:FlxGroup = new FlxGroup();
			for (var i:uint = 0; i < tmpSpawn.length; i++) {
				var tmpArray:Array = tmpLvl.getTileInstances(tmpSpawn[i]);
				if (tmpArray) {
					for (var j:uint = 0; j < tmpArray.length; j++) {
						var tmpPoint:FlxPoint = pointForTile(tmpArray[j],tmpLvl);
						var tmpObject:FlxObject = new tmpClass(tmpPoint.x,tmpPoint.y);
						tmpObject.x += (tmpLvl.width/tmpLvl.widthInTiles)/2.0 - tmpObject.width/2.0;
						tmpObject.y += (tmpLvl.width/tmpLvl.widthInTiles)/2.0 - tmpObject.height/2.0;
						tmpGroup.add(tmpObject);
					}
				}
			}
			return tmpGroup;
		}
		
		/** 
		 * Internal
		 * 
		 * Gets the screen point, given a tile index
		 * 
		 */
		public static function pointForTile(tmpTile:uint,tmpMap:FlxTilemap):FlxPoint {
			var tmpX:Number = (tmpMap.width/tmpMap.widthInTiles)*(int)(tmpTile%tmpMap.widthInTiles);
			var tmpY:Number = (tmpMap.width/tmpMap.widthInTiles)*(int)(tmpTile/tmpMap.widthInTiles);
			var tmpPoint:FlxPoint = new FlxPoint(tmpX+tmpMap.x,tmpY+tmpMap.y);
			return tmpPoint;
		}
	}
}