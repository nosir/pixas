package com.risonhuang.pixas.objects.primitives 
{
	import com.risonhuang.pixas.objects.AbstractPrimitive;
	import com.risonhuang.pixas.objects.PixelObject;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import com.risonhuang.pixas.colors.CubeColor;
	import com.risonhuang.pixas.colors.SideColor;
	import com.risonhuang.pixas.dimensions.*;
	
	/**
	 * The Cube class is the primitive for constructing Cube
	 * <p/>
	 * The width, height and length could be different depends on the dimension
	 *
	 * @author	max
	 */
	public class Cube extends AbstractPrimitive
	{
		
		private var border:Boolean;
		
		/**
		 * Construct
		 *
		 * @param	_dms	[optional]	the dimension obj for rendering
		 * @param	_color	[optional]	the color obj for rendering
		 * @param	_border [optional]	whether show border,you may hide borders when arranging the cubes
		 */
		public function Cube(_dms: CubeDms = null, _color:CubeColor = null, _border:Boolean = true)
		{
			super();
			
			border = _border;
			
			initRender(_dms, _color);
			initRectangle();
			initBmd();
			build();
		}

		private function initRender(_dms:CubeDms,_color:CubeColor):void
		{
			dms = _dms == null ? new CubeDms() : _dms;
			color = _color == null ? new CubeColor() : _color;
		}
		
		private function initRectangle():void
		{
			w = dms.xAxis + dms.yAxis;
			h = dms.zAxis + (dms.xAxis + dms.yAxis) / 2;
			//22.6 degrees implementation
			w -= 2;
			h -= 1;
			
			//the matrix offset between the bitmap and the 3d pixel coordinate ZERO point
			matrix.tx = - dms.yAxis + 2;
			matrix.ty = - dms.zAxis;
		}	
		
		private function build():void
		{
			//horizontal layer
			var brick:Brick = new Brick
			(
				new BrickDms(dms.xAxis, dms.yAxis), 
				new SideColor(color.border, color.horizontal),
				border
			);
			
			//left side
			var sideX:SideX = new SideX
			(
				new SideXDms(dms.xAxis, dms.zAxis), 
				new SideColor(color.border, color.left),
				border
			);
			
			//right side
			var sideY:SideY = new SideY
			(
				new SideYDms(dms.yAxis, dms.zAxis), 
				new SideColor(color.border, color.right),
				border
			);
			
			if (border)
			{
				//hight light pixel
				var light_bm:Bitmap = generateHighLight();
			}
			
			var po:PixelObject = new PixelObject();
		
			var po_brick:PixelObject = new PixelObject(brick);
			var po_x:PixelObject = new PixelObject(sideX);
			var po_y:PixelObject = new PixelObject(sideY);
			
			po_brick.x = dms.yAxis - 2;
			po_x.y = dms.zAxis + dms.yAxis / 2 - 1;
			po_y.x = w - 2;
			po_y.y = dms.zAxis + dms.xAxis / 2 - 1;
			
			po.addChild(po_x);
			po.addChild(po_y);
			po.addChild(po_brick);
			if (border)
			{
				po.addChild(light_bm);
			}
			
			src_bmd.draw(po);
			
			//fix the middle light
			if (!border)
			{
				for (var i:uint = 0; i < dms.zAxis; i++ )
				{
					src_bmd.setPixel32(dms.xAxis - 2, (dms.xAxis + dms.yAxis) / 2 - 1 + i, color.left);
				}
			}
		}
		
		private function generateHighLight():Bitmap
		{
			var bmd:BitmapData = new BitmapData(w, h , true , 0x00FFFFFF);
			var offsetX : uint = dms.xAxis - 2;
			var offsetY : uint = (dms.xAxis + dms.yAxis) / 2 - 2;
			
			//the 2px in bounding without hightlight
			for (var i:uint = 0; i < dms.xAxis - 2; i++ )
			{
				bmd.setPixel32(offsetX + 1 - i, offsetY - Math.floor(i / 2), color.borderHighlight);
			}
			
			//the 2px in bounding without hightlight
			for (var j:uint = 0; j < dms.yAxis - 2; j++ )
			{
				bmd.setPixel32(offsetX + j, offsetY - Math.floor(j / 2), color.borderHighlight);
			}
			
			for (var k:uint = 0; k < dms.zAxis; k++ )
			{
				bmd.setPixel32(offsetX, offsetY + k, color.borderHighlight);
			}
			
			return new Bitmap(bmd);
		}
		
	}

}