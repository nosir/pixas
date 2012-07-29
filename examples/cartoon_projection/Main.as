package  
{
	import flash.display.MovieClip;
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
	public class Main extends Sprite
	{
		private var bmd:BitmapData;
		//side
		private var movWidth:uint;
		private var movHeight:uint;
		//dimension
		private var xDms:uint;
		private var yDms:uint;
		private var zDms:uint;
		//frame po
		private var poFrame:PixelObject;
		//mov po
		private var poUncle:PixelObject;
		//frame cube
		private var cubeFrame:Cube;
		//mc
		private var mov:MovieClip;
		private var uncles:Array = [];
		//data pool
		private var colors:Array = [];
		private var cubes:Array = [];
		//ask unclebig2d why -.-
		private static const SEP:uint = 4;
		//enlarge rate
		private static const RATE:uint = 3;
		
		
		public function Main()
		{
			stage.quality = StageQuality.LOW;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.RESIZE,__onStageSizeChange);	
			tit.x = stage.stageWidth - 10;
			tit.b1.addEventListener(MouseEvent.MOUSE_UP, __onB1MouseUp);
			tit.b2.addEventListener(MouseEvent.MOUSE_UP, __onB2MouseUp);
			
			//dimension
			xDms = 6;
			yDms = 6;
			zDms = 10;

			//out container
			var po:PixelObject = new PixelObject();
			//carton po
			poUncle = new PixelObject();
			//bottom po
			poFrame = new PixelObject();
			
			//add to stage
			po.addChild(poFrame);
			po.addChild(poUncle);
			po.x = 300;
			po.y = 110;			
			addChild(po);
			
			uncles = [uncle1, uncle2, uncle3, uncle4, uncle5];
			for (var i:uint = 0; i < uncles.length; i++ )
			{
				uncles[i].stop();
				uncles[i].buttonMode = true;
				uncles[i].addEventListener("__onUncleChange", __onUncleChange);
				uncles[i].addEventListener(MouseEvent.CLICK, __onMovChange);
			}
			__onMovChange(null);
			
		}
		private function __onB1MouseUp(e:MouseEvent):void
		{
			navigateToURL(new URLRequest("http://weibo.com/unclebig2d"), "_blank");
		}
		private function __onB2MouseUp(e:MouseEvent):void
		{
			navigateToURL(new URLRequest("http://code.google.com/p/pixas/"), "_blank");
		}
		
		private function __onStageSizeChange(e:Event):void
		{
			tit.x = stage.stageWidth - 10;
		}
		
		//when different mov clicked
		private function __onMovChange(e:MouseEvent = null):void
		{
			for (var i:uint = 0; i < uncles.length; i++ )
			{
				uncles[i].stop();
			}
			if (e == null)
			{
				mov = uncles[Math.floor(Math.random()*uncles.length)];
			}
			else
			{
				mov = e.target as MovieClip;
			}
			
			movWidth = mov.width;
			movHeight = mov.height;
			if (mov == uncle5)
			{
				movWidth = 160;
			}
			mov.play();
			
			rebuildFrame();
		}
		private function rebuildFrame():void
		{
			poFrame.removeAllChildren();
			poUncle.removeAllChildren();
			var cubeFrameDms:CubeDms = new CubeDms((movWidth+6)*(xDms-2),(movHeight+6)*(yDms-2),zDms);
			var cubeColor:CubeColor = CubeColor.getByHorizontalColor(0xF6F6F6);
			cubeFrame = new Cube(cubeFrameDms, cubeColor,false);
			var pos3d:Coord3D = new Coord3D(-3*(xDms-2), -3*(yDms-2), -zDms);
			poFrame.addChild(new PixelObject(cubeFrame,pos3d));
		}
		
		//when carton frame changed
		private function __onUncleChange(e:Event):void
		{
			poUncle.removeAllChildren();
			
			bmd = new BitmapData(movWidth,movHeight);
			bmd.draw(mov);

			var p_y:uint = 0;
			var p_x:uint = 0;
			for (p_y=0; p_y< movHeight/SEP; p_y++)
			{
				for (p_x =0; p_x< movWidth/SEP; p_x++)
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
				var cubeDms:CubeDms = new CubeDms(xDms*RATE,yDms*RATE,zDms);
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
			var pos3d:Coord3D = new Coord3D((xDms *RATE - 2)* p_x, (yDms *RATE - 2)* p_y, 0);
			var poCube:PixelObject = new PixelObject(cube, pos3d);
			poUncle.addChild(poCube);
		}
	}
}











