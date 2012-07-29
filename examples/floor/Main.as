package  
{

	import flash.display.StageScaleMode;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import com.risonhuang.pixas.math.Coord3D;
	import com.risonhuang.pixas.colors.SideColor;
	import com.risonhuang.pixas.dimensions.BrickDms;
	import com.risonhuang.pixas.objects.primitives.Brick;
	import com.risonhuang.pixas.objects.PixelObject;	
	/**
	 * @author max
	 */	
	public class Main extends Sprite
	{
		private var xDms:uint;
		private var yDms:uint;
		private var zDms:uint;
		private var po:PixelObject;
		
		public function Main()
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			//the value of brick dimensions in Pixas coordinate system
			xDms = 30;
			yDms = 30;
			zDms = 0;
			
			//out container
			po = new PixelObject();
			//position of out po container in Flash coordinate system
			po.x = 220;
			po.y = 60;
			//brick dimension object
			var brickDms:BrickDms = new BrickDms(xDms,yDms);
			//brick color object pass aRGB value to assign alpha value like:0x99FFFFFF
			var sideColorA:SideColor = new SideColor(0xFF777777);
			var sideColorB:SideColor = new SideColor(0xFF777777,0xFFCCCCCC);
			//brick primitive
			var brickA:Brick = new Brick(brickDms,sideColorA);
			var brickB:Brick = new Brick(brickDms,sideColorB);

			//arrangement
			for (var i:int = 0; i <= 6; i++)
			{
				for (var j:int = 0; j <= 6; j++)
				{
					//each position in Pixas coordinate system
					var int3d_tmp:Coord3D = new Coord3D((xDms - 2) * i, (yDms - 2) * j, 0);
					//nesting each PixelObject
					var po_tmp:PixelObject;
					//alternative color 
					if ((i+j)%2==0)
					{
						po_tmp = new PixelObject(brickA,int3d_tmp);
					} else
					{
						po_tmp = new PixelObject(brickB,int3d_tmp);
					}
					po_tmp.addEventListener(MouseEvent.MOUSE_OVER, __onBrickMouseOver);
					po_tmp.addEventListener(MouseEvent.MOUSE_OUT, __onBrickMouseOut);
					po.addChild(po_tmp);
				}
			}
			addChild(po);
		}
		
		private function __onBrickMouseOver(e:MouseEvent):void
		{
			var po_tmp:PixelObject = e.target as PixelObject;
			po_tmp.positionZ = 5;
		}
		
		private function __onBrickMouseOut(e:MouseEvent):void
		{
			var po_tmp:PixelObject = e.target as PixelObject;
			po_tmp.positionZ = 0;
		}
	}
}