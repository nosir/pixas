package  
{

	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import flash.display.Sprite;
	
	import com.risonhuang.pixas.math.Coord3D;
	import com.risonhuang.pixas.math.ColorPattern;
	import com.risonhuang.pixas.colors.CubeColor;
	import com.risonhuang.pixas.dimensions.CubeDms;
	import com.risonhuang.pixas.objects.primitives.Cube;
	import com.risonhuang.pixas.objects.PixelObject;
	/**
	 * @author max
	 */	
	public class Main extends Sprite
	{
		private static const WOOD_WIDTH:uint = 124;
		private static const WOOD_HEIGHT:uint = 8;
		private static const WOOD_LENGTH:uint = 14;
		private static const WOOD_COLOR:uint = 0xFFECA0;
		private static const WOOD_SPACE:uint = 20;
		private static const WOOD_NUMBER:uint = 50;
		private static const STEEL_WIDTH:uint = 8;
		private static const STEEL_HEIGHT:uint = 12;
		private static const STEEL_SPACE:uint = 60;
		private static const STEEL_COLOR:uint = 0xEEEEEE;
		private static const NAIL_WIDTH:uint = 6;
		private static const NAIL_HEIGHT:uint = 4;
		private static const NAIL_LENGTH:uint = 6;
		private static const NAIL_PADDING:uint = 4;
		private static const NAIL_COLOR:uint = 0xEEEEEE;
		
		public function Main()
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			var i:uint = 0;
			var j:uint = 0;
			
			var steel_padding:uint = (WOOD_WIDTH - STEEL_WIDTH * 2 - STEEL_SPACE) / 2;
			
			var poRail:PixelObject = new PixelObject();
			//wood primitive
			var woodDms:CubeDms = new CubeDms(WOOD_LENGTH,WOOD_WIDTH,WOOD_HEIGHT);
			var woodColor:CubeColor = CubeColor.getByHorizontalColor(WOOD_COLOR);
			var cubeWood:Cube = new Cube(woodDms,woodColor);
			//nail primitive
			var cubeNail:Cube = new Cube(new CubeDms(6,6,4),CubeColor.getByHorizontalColor(NAIL_COLOR));
			var poNail:PixelObject;
			for (i = 0; i <= WOOD_NUMBER; i++)
			{
				poNail = new PixelObject(cubeNail,new Coord3D((WOOD_SPACE + WOOD_LENGTH) * i+NAIL_PADDING,NAIL_PADDING,WOOD_HEIGHT));
				var poWood:PixelObject = new PixelObject(cubeWood, new Coord3D((WOOD_SPACE + WOOD_LENGTH) * i, 0, 0));
				poRail.addChild(poWood);
				poRail.addChild(poNail);
			}
			//steel primitive
			var cubeSteel: Cube = new Cube(new CubeDms((WOOD_SPACE + WOOD_LENGTH) * i, STEEL_WIDTH, STEEL_HEIGHT),CubeColor.getByHorizontalColor(STEEL_COLOR));
			var poSteelA:PixelObject = new PixelObject(cubeSteel,new Coord3D(0,WOOD_WIDTH - steel_padding,WOOD_HEIGHT));
			var poSteelB:PixelObject = new PixelObject(cubeSteel,new Coord3D(0,steel_padding,WOOD_HEIGHT));
			poRail.addChild(poSteelA);
			poRail.addChild(poSteelB);

			//add outside nail
			for (i = 0; i <= WOOD_NUMBER; i++)
			{
				poNail = new PixelObject(cubeNail,new Coord3D((WOOD_SPACE + WOOD_LENGTH) * i+NAIL_PADDING,WOOD_WIDTH-NAIL_PADDING - NAIL_WIDTH,WOOD_HEIGHT));
				poRail.addChild(poNail);
			}
			poRail.positionZ = 20 ;
			
			addChild(poRail);
		}
	}
}











