package  
{
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.StageQuality;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	
	import flash.display.BitmapData;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import com.risonhuang.pixas.math.Coord3D;
	import com.risonhuang.pixas.colors.CubeColor;
	import com.risonhuang.pixas.dimensions.CubeDms;
	import com.risonhuang.pixas.objects.primitives.Cube;
	import com.risonhuang.pixas.objects.PixelObject;
	/**
	 * @author max
	 */	
	public class MainMovie extends Sprite
	{
		private var bmd:BitmapData;
		//side
		private var movWidth:uint;
		private var movHeight:uint;
		//dimension
		private var xDms:uint;
		private var yDms:uint;
		private var zDms:uint;
		//out po
		private var po:PixelObject;
		//frame po
		private var poFrame:PixelObject;
		//black po
		private var poBlack:PixelObject;
		//mov po
		private var poUncle:PixelObject;
		//frame cube
		private var cubeFrame:Cube;
		//timer
		private var timer:Timer;
		//tmp mc
		private var tmpFrame:Shape;
		//data pool
		private var colors:Array = [];
		private var cubes:Array = [];
		private var black:Object= {};
		//ask unclebig2d why -.-
		private static const SEP:uint = 4;
		//enlarge rate
		private static const RATE:uint = 2;
		//every block cube EACH_BLOCK_MINUS_SIZE
		private static const EACH_BLOCK_MINUS_SIZE:uint = 4;		
		
		public function MainMovie()
		{
			//out container
			po = new PixelObject();
			//carton po
			poUncle = new PixelObject();
			//black po
			poBlack = new PixelObject();
			//bottom
			poFrame = new PixelObject();
			//add to stage
			po.addChild(poFrame);
			po.addChild(poUncle);
			addChild(po);
			
			//stage
			stage.quality = StageQuality.LOW;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.RESIZE,__onStageSizeChange);	
			__onStageSizeChange(null);
			tit.b1.addEventListener(MouseEvent.MOUSE_UP, __onB1MouseUp);
			tit.b2.addEventListener(MouseEvent.MOUSE_UP, __onB2MouseUp);
			
			//dimension
			xDms = 6;
			yDms = 6;
			zDms = 10;

			movWidth = mov.width;
			movHeight = mov.height;
			mov.visible = false;
			
			buildFrame();
			//dispatchEvent(new Event("_blackDown"));
			mov.addEventListener("_o", __onUncleChange);
			mov.addEventListener("_blackUp", _blackUp);
			mov.addEventListener("_blackDown", _blackDown);
			mov.addEventListener("_blackBlock", _blackBlock);
			mov.addEventListener("_blackRemove", _blackRemove);
			
		}
		private function __onB1MouseUp(e:MouseEvent):void
		{
			navigateToURL(new URLRequest("http://weibo.com/unclebig2d"), "_blank");
		}
		private function __onB2MouseUp(e:MouseEvent):void
		{
			navigateToURL(new URLRequest("http://code.google.com/p/pixas/"), "_blank");
		}
		
		private function __onStageSizeChange(e:Event = null):void
		{
			tit.x = stage.stageWidth - 10;
			po.x = Math.floor(stage.stageWidth / 2);
			po.y = Math.floor((stage.stageHeight - 350) / 2);
		}

		private function buildFrame():void
		{
			poFrame.removeAllChildren();
			poUncle.removeAllChildren();
			var cubeFrameDms:CubeDms = new CubeDms((xDms*RATE-2-EACH_BLOCK_MINUS_SIZE)*(movWidth/SEP+3),(yDms*RATE-2-EACH_BLOCK_MINUS_SIZE)*(movHeight/SEP+3),zDms);
			var cubeColor:CubeColor = CubeColor.getByHorizontalColor(0xF6F6F6);
			cubeFrame = new Cube(cubeFrameDms, cubeColor,false);
			var pos3d:Coord3D = new Coord3D(-1.5*(xDms*RATE-2-EACH_BLOCK_MINUS_SIZE), -1.5*(yDms*RATE-2-EACH_BLOCK_MINUS_SIZE), -zDms);
			poFrame.addChild(new PixelObject(cubeFrame, pos3d));
			poFrame.addChild(poBlack);
			//mov.gotoAndPlay(1520);
		}
		private function _blackRemove(e:Event):void
		{
			poBlack.removeAllChildren();
		}
		private function _blackBlock(e:Event):void
		{
			mov.stop();
			poUncle.removeAllChildren();
			poBlack.removeAllChildren();
			var cubeBlackDms:CubeDms = new CubeDms((xDms*RATE-2-EACH_BLOCK_MINUS_SIZE)*(movWidth/SEP) + 2,(yDms*RATE-2-EACH_BLOCK_MINUS_SIZE)*(movHeight/SEP) + 2,zDms);
			var cubeBlack:Cube = new Cube(cubeBlackDms, CubeColor.getByHorizontalColor(0x000000), false);
			poBlack.addChild(new PixelObject(cubeBlack));
			mov.play();
		}
		private function _blackDown(e:Event):void
		{
			mov.stop();
			black.status = "v_down";
			timer = new Timer(30, 0);
			timer.addEventListener(TimerEvent.TIMER, __onBlackVTimer);
			timer.start();
		}
		private function _blackUp(e:Event):void
		{
			mov.stop();
			black.status = "v_up";
			timer = new Timer(50, 0);
			timer.addEventListener(TimerEvent.TIMER, __onBlackVTimer);
			timer.start();
		}
		private function __onBlackVTimer(e:TimerEvent):void
		{
			poBlack.removeAllChildren();
			var line:uint;
			if (black.status == "v_down")
			{
				line = Math.max(1,Math.min(timer.currentCount * 4,movHeight/SEP));
			}
			if (black.status == "v_up")
			{
				line = Math.max(1,Math.min(movHeight/SEP - timer.currentCount * 4,movHeight/SEP));
			}
			var cubeBlackDms:CubeDms = new CubeDms((xDms*RATE-2-EACH_BLOCK_MINUS_SIZE)*(movWidth/SEP) + 2,(yDms*RATE-2-EACH_BLOCK_MINUS_SIZE)*line + 2,zDms);
			var cubeBlack:Cube = new Cube(cubeBlackDms, CubeColor.getByHorizontalColor(0x000000), false);
			poBlack.addChild(new PixelObject(cubeBlack));
			black.count = line;
			__onUncleChange(null);
			if ((black.status == "v_up" && line == 1) || (black.status == "v_down" && line == movHeight / SEP))
			{
				if (line == 1) { poBlack.removeAllChildren(); }
				timer.reset();
				black.status = "-"
				mov.play();
			}
		}		
		//when carton frame changed
		private function __onUncleChange(e:Event = null):void
		{
			poUncle.removeAllChildren();
			
			bmd = new BitmapData(movWidth,movHeight);
			bmd.draw(mov);

			for (var p_y:uint = ((black.status == "v_down" || black.status == "v_up") ?black.count :0); p_y < movHeight / SEP; p_y++)
			{
				for (var p_x:uint = (black.status == "h" ?black.count :0); p_x< movWidth/SEP; p_x++)
				{
					handlePixel(p_x, p_y);
				}
			}
			bmd.dispose();
		}
		
		private function handlePixel(p_x:uint, p_y:uint):void
		{
			//construct cube primitive pool
			var now_color:uint = bmd.getPixel(p_x*SEP, p_y*SEP);
			if (now_color >= 0xFFFFFF)
			{
				return;
			}
			for (var i:uint = 0, match_index:int = -1; i < colors.length; i++ )
			{
				if (colors[i] == now_color)
				{
					match_index = i;
					break;
				}
			}
			
			var cube:Cube;
			if (match_index == -1)
			{
				//color mismatch, create new cube
				var cubeDms:CubeDms = new CubeDms(xDms*RATE - EACH_BLOCK_MINUS_SIZE,yDms*RATE - EACH_BLOCK_MINUS_SIZE,zDms);
				var cubeColor:CubeColor = CubeColor.getByHorizontalColor(now_color);
				cube = new Cube(cubeDms, cubeColor, false);
				
				colors.push(now_color);
				cubes.push(cube);
				//trace("new pixel capture:" + now_color);
			}
			else
			{
				//get cube from pool
				cube = cubes[match_index];
			}
			//add to carton frame po
			var pos3d:Coord3D = new Coord3D((xDms *RATE - 2 - EACH_BLOCK_MINUS_SIZE)* p_x, (yDms *RATE - 2 - EACH_BLOCK_MINUS_SIZE)* p_y, 0);
			var poCube:PixelObject = new PixelObject(cube, pos3d);
			poUncle.addChild(poCube);
		}
	}
}











