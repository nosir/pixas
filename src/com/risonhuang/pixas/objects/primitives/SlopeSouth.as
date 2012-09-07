package com.risonhuang.pixas.objects.primitives 
{
	import com.risonhuang.pixas.colors.SlopeColor;
	import com.risonhuang.pixas.dimensions.SlopeDms;
	import com.risonhuang.pixas.objects.AbstractPrimitive;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	/**
	 * The SlopeSouth class is the primitive for constructing SlopeSouth
	 * <p/>
	 * The width could be different depends on the dimension
	 *
	 * @author	max
	 */
	public class SlopeSouth extends AbstractPrimitive
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
		public function SlopeSouth(_dms: SlopeDms = null, _color:SlopeColor = null, _border:Boolean = true) 
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
			h = dms.xAxis / 2 + dms.yAxis * 2;
			
			w -= 2;
			h -= 3;
			
			//the matrix offset between the bitmap and the 3d pixel coordinate ZERO point
			matrix.tx = - (dms.yAxis - 2);
			matrix.ty = - (dms.yAxis * 1.5 - 2);
		}
		
		private function build():void
		{
			src_bmd.lock();
			
			var color_border_left:uint = border ? color.border : color.leftSlope;
			var color_border_right:uint = border ? color.border : color.right;
			
			//x axis
			for (var j:uint = 0; j< dms.xAxis ; j++) 
			{
				src_bmd.setPixel32(j, dms.yAxis * 2 + Math.floor(j / 2) - 3, color_border_left);
				src_bmd.setPixel32(j + dms.yAxis - 2, Math.floor(j / 2), color_border_left);
			}
			//y axis
			for (var i:uint = 0; i < dms.yAxis ; i++) 
			{
				src_bmd.setPixel32(dms.xAxis - 2 + i, h - Math.floor(i / 2) - 1, color_border_right);
			}
			//z axis
			for (var k:uint = dms.xAxis/2 - 1; k < h - dms.yAxis /2 ; k++) 
			{
				src_bmd.setPixel32(w - 1, k, color_border_right);
			}
			
			//slot
			for (var m:uint = 0; m < dms.yAxis * 2 - 2 ; m++) 
			{
				src_bmd.setPixel32(Math.floor(m/2), dms.yAxis * 2 - m - 3 , color_border_left);
				src_bmd.setPixel32(dms.xAxis - 2 + Math.floor(m / 2), h - m - 1, color_border_left);
			}
			
			//floodfill
			src_bmd.floodFill(dms.yAxis - 1, 1,  color.leftSlope);
			src_bmd.floodFill(dms.xAxis, h - 3,  color.right);
			//hack single pixel
			src_bmd.setPixel32(dms.xAxis - 1, h - 2,  color.right);
			//highlight
			if (border)
			{
				for (var n:uint = 1; n < dms.yAxis * 2 - 3 ; n++) 
				{
					src_bmd.setPixel32(dms.xAxis - 2 + Math.floor(n / 2), h - n - 1, color.borderHighlight);
				}
			}
			
			src_bmd.unlock();
			
		}
	}

}