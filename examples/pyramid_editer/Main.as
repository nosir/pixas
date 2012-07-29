package  
{
	import fl.events.ColorPickerEvent;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.StageScaleMode;
	import flash.display.Sprite;
	
	import com.risonhuang.pixas.math.Coord3D;
	import com.risonhuang.pixas.math.ColorPattern;
	import com.risonhuang.pixas.colors.PyramidColor;
	import com.risonhuang.pixas.dimensions.PyramidDms;
	import com.risonhuang.pixas.objects.primitives.Pyramid;
	import com.risonhuang.pixas.objects.PixelObject;

	/**
	 * @author rison
	 */	
	public class Main extends Sprite
	{
		private var tall:Boolean;
		private var dms:uint;
		private var count:int;
		private var pyramidColor:PyramidColor;
		private var pPyramid:PixelObject;
		private var po:PixelObject;
		
		public function Main()
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			//the value of cube dimensions in Pixas coordinate system
			dms = 60;
			//enterframe count
			count = 2;
			//whether to draw tall pyramid
			tall = false;
			
			//out container
			po = new PixelObject();
			//position of out po container in Flash coordinate system
			po.x = 220;
			po.y = 140;			
			
			//pyramid primitive
			pyramidColor = PyramidColor.getByRightColor(ColorPattern.PINK);
			pPyramid = new PixelObject();
			updatePyramid();
			
			//control area
			pane.btn_big.addEventListener(MouseEvent.CLICK, __onBtnSizeClick);
			pane.btn_small.addEventListener(MouseEvent.CLICK, __onBtnSizeClick);
			color_picker.selectedColor = ColorPattern.PINK;
			color_picker.addEventListener(ColorPickerEvent.CHANGE,onColorChange);
			pane.btn_x_plus.addEventListener(MouseEvent.MOUSE_DOWN,__onBtnDown);
			pane.btn_x_plus.addEventListener(MouseEvent.MOUSE_UP,__onBtnUp);
			pane.btn_x_minus.addEventListener(MouseEvent.MOUSE_DOWN,__onBtnDown);
			pane.btn_x_minus.addEventListener(MouseEvent.MOUSE_UP, __onBtnUp);
			this.stage.addEventListener(MouseEvent.MOUSE_UP,__onBtnUp);
			
			//depth sort
			addChild(po);
			addChild(pane);
			addChild(color_picker);
		}
		
		private function onColorChange(event:ColorPickerEvent):void
		{
			pyramidColor = PyramidColor.getByRightColor(event.target.selectedColor);
			updatePyramid();
		}
		
		private function __onBtnSizeClick(e:MouseEvent):void
		{
			tall = pane.btn_big.visible;
			pane.btn_big.visible = !pane.btn_big.visible;
			updatePyramid();
		}
		
		private function __onBtnDown(e:MouseEvent):void
		{
			if (e.target.name.indexOf("plus") > 0)
			{
				count = 2;
			}
			else
			{
				count = -2;
			}
			addEventListener(Event.ENTER_FRAME,__enterFrame);
		}
		
		private function __onBtnUp(e:MouseEvent):void
		{
			removeEventListener(Event.ENTER_FRAME,__enterFrame);
		}
		
		private function __enterFrame(e:Event):void
		{
			dms += count;
			//the minimum value
			if (dms<6)
			{
				dms=6;
			}
			//the maximum value
			if (dms>300)
			{
				dms=300;
			}

			updatePyramid();
		}
		
		private function updatePyramid()
		{
			pPyramid.removeAllChildren();
			po.removeAllChildren();

			//refresh pixelobject rendering
			var pyramidDms:PyramidDms=new PyramidDms(dms,tall);
			var pyramid:Pyramid=new Pyramid(pyramidDms,pyramidColor);
			pPyramid=new PixelObject(pyramid);
			po.addChild(pPyramid);
		}
	}
}