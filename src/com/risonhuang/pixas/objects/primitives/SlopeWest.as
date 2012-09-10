package com.risonhuang.pixas.objects.primitives 
{
	import com.risonhuang.pixas.colors.SideColor;
	import com.risonhuang.pixas.dimensions.SideYDms;
	import com.risonhuang.pixas.objects.PixelObject;
	import com.risonhuang.pixas.colors.SlopeColor;
	import com.risonhuang.pixas.dimensions.SlopeDms;
	import com.risonhuang.pixas.objects.AbstractPrimitive;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	/**
	 * The SlopeWest class is the primitive for constructing SlopeWest
	 * <p/>
	 * The size could be different depends on the dimension
	 *
	 * @author	max
	 */
	public class SlopeWest extends AbstractPrimitive
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
		public function SlopeWest(_dms: SlopeDms = null, _color:SlopeColor = null, _border:Boolean = true) 
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
			h = dms.xAxis * 3 / 2 + dms.yAxis / 2;
			
			w -= 2;
			h -= 3;
			
			//the matrix offset between the bitmap and the 3d pixel coordinate ZERO point
			matrix.tx = - (dms.yAxis - 2);
			matrix.ty = - (dms.xAxis  -2);
		}
		
		private function build():void
		{
			src_bmd.lock();
			
			var color_border_left:uint = border ? color.border : color.left;
			var color_border_right:uint = border ? color.border : color.right;
			var color_high:uint = border ? color.borderHighlight : color.left;
			
			//right side
			var sideY:SideY = new SideY
			(
				new SideYDms(dms.yAxis, h - dms.yAxis / 2),
				new SideColor(color_border_right, color.right)
			);
			var po_y:PixelObject = new PixelObject(sideY);
			src_bmd.draw(po_y, new Matrix(1, 0, 0, 1, w - 2, h - dms.yAxis / 2));
			
			//x axis
			for (var j:uint = 0; j< dms.xAxis - 1 ; j++) 
			{
				src_bmd.setPixel32(j, dms.xAxis + dms.yAxis / 2 - 3 + Math.floor(j / 2),color_border_left);
				src_bmd.setPixel32(j, dms.xAxis + dms.yAxis / 2 - 3 - j,color_border_left);
			}
			
			//floodfill
			src_bmd.floodFill(dms.xAxis - 3, h - 3,  color.left);
			
			//highlight
			for (var n:uint = dms.yAxis / 2; n < h - 1 ; n++) 
			{
				src_bmd.setPixel32(dms.xAxis - 2, n, color_high);
			}
			
			src_bmd.unlock();
			
		}
	}

}