package com.risonhuang.pixas.objects.primitives 
{
	import com.risonhuang.pixas.colors.SideColor;
	import com.risonhuang.pixas.dimensions.SideXDms;
	import com.risonhuang.pixas.objects.PixelObject;
	import com.risonhuang.pixas.colors.SlopeColor;
	import com.risonhuang.pixas.dimensions.SlopeDms;
	import com.risonhuang.pixas.objects.AbstractPrimitive;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	/**
	 * The SlopeNorth class is the primitive for constructing SlopeNorth
	 * <p/>
	 * The width could be different depends on the dimension
	 *
	 * @author	max
	 */
	public class SlopeNorth extends AbstractPrimitive
	{
		private var hSize:int;
		private var hOffset:int;
		
		private var border:Boolean;
		/**
		 * Construct
		 *
		 * @param	_dms	[optional]	the dimension obj for rendering
		 * @param	_color	[optional]	the color obj for rendering
		 * @param	_border [optional]	whether show border and highlight
		 */		
		public function SlopeNorth(_dms: SlopeDms = null, _color:SlopeColor = null, _border:Boolean = true) 
		{
			super();
			
			border = _border;
			
			initRender(_dms, _color);
			initRectangle();
			initBmd();
			build();
		}
		
		private function initRender(_dms:SlopeDms,_color:SlopeColor):void
		{
			dms = _dms == null ? new SlopeDms() : _dms;
			color = _color == null ? new SlopeColor() : _color;
		}
		
		private function initRectangle():void
		{
			w = dms.xAxis + dms.yAxis;
			h = dms.yAxis * 3 / 2 + dms.xAxis / 2;
			
			w -= 2;
			h -= 3;
			
			//the matrix offset between the bitmap and the 3d pixel coordinate ZERO point
			matrix.tx = - (dms.yAxis - 2);
			matrix.ty = - (dms.yAxis  -2);
		}
		
		private function build():void
		{
			src_bmd.lock();
			
			var color_border_left:uint = border ? color.border : color.left;
			var color_border_right:uint = border ? color.border : color.right;
			var color_high:uint = border ? color.borderHighlight : color.left;
			
			//right side
			var sideX:SideX = new SideX
			(
				new SideXDms(dms.xAxis, h - dms.xAxis / 2),
				new SideColor(color_border_left, color.left)
			);
			var po_x:PixelObject = new PixelObject(sideX);
			src_bmd.draw(po_x, new Matrix(1, 0, 0, 1, 0, h - dms.xAxis / 2));
			
			//y axis
			for (var j:uint = 1; j< dms.yAxis; j++) 
			{
				src_bmd.setPixel32(dms.xAxis + j - 2, h - Math.floor(j / 2) - 1,color_border_right);
				src_bmd.setPixel32(dms.xAxis + j - 2, dms.xAxis / 2 - 2 + j,color_border_right);
			}
			
			//floodfill
			src_bmd.floodFill(dms.xAxis +1, h - 3,  color.right);
			
			//highlight
			for (var n:uint = dms.xAxis / 2; n < h - 1 ; n++) 
			{
				src_bmd.setPixel32(dms.xAxis - 1, n, color.right);
				src_bmd.setPixel32(dms.xAxis - 2, n, color_high);
			}
			
			src_bmd.unlock();
			
		}
	}

}