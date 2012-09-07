package com.risonhuang.pixas.objects.primitives 
{
	import com.risonhuang.pixas.colors.SlopeColor;
	import com.risonhuang.pixas.dimensions.SlopeDms;
	import com.risonhuang.pixas.objects.AbstractPrimitive;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	/**
	 * The SlopeEast class is the primitive for constructing SlopeEast
	 * <p/>
	 * The width could be different depends on the dimension
	 *
	 * @author	max
	 */
	public class SlopeEast extends AbstractPrimitive
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
		public function SlopeEast(_dms: SlopeDms = null, _color:SlopeColor = null, _border:Boolean = true) 
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
			h = dms.xAxis * 2 + dms.yAxis / 2;
			
			w -= 2;
			h -= 3;
			
			//the matrix offset between the bitmap and the 3d pixel coordinate ZERO point
			matrix.tx = - (dms.yAxis - 2);
			matrix.ty = - (dms.xAxis * 1.5 - 2);
		}
		
		private function build():void
		{
			src_bmd.lock();
			
			var color_border_left:uint = border ? color.border : color.left;
			var color_border_right:uint = border ? color.border : color.rightSlope;
			
			//y axis
			for (var j:uint = 0; j< dms.yAxis ; j++) 
			{
				src_bmd.setPixel32(j, dms.yAxis / 2 - Math.floor(j / 2) - 1, color_border_right);
				src_bmd.setPixel32(j + dms.xAxis - 2, h - Math.floor(j / 2) - 1, color_border_right);
			}
			//x axis
			for (var i:uint = 0; i < dms.xAxis ; i++) 
			{
				src_bmd.setPixel32(i, h - dms.xAxis / 2 + Math.floor(i / 2), color_border_left);
			}
			//z axis
			for (var k:uint = dms.yAxis/2 - 1; k < h - dms.xAxis /2 ; k++) 
			{
				src_bmd.setPixel32(0, k, color_border_left);
			}
			//slot
			for (var m:uint = 0; m < dms.xAxis*2 - 2 ; m++) 
			{
				src_bmd.setPixel32(dms.yAxis - 1 + Math.floor(m/2), m, color_border_right);
				src_bmd.setPixel32(1 + Math.floor(m / 2), dms.yAxis / 2 + m - 1, color_border_right );
			}
			
			//floodfill
			src_bmd.floodFill(dms.yAxis - 2, 1,  color.rightSlope);
			src_bmd.floodFill(1, dms.yAxis / 2 + 2,  color.left);
			//hack single pixel
			src_bmd.setPixel32(dms.xAxis - 2, h - 2,  color.left);
			
			//highlight
			if (border)
			{
				for (var n:uint = 1; n < dms.xAxis*2 - 3 ; n++) 
				{
					src_bmd.setPixel32(1 + Math.floor(n / 2), dms.yAxis / 2 + n - 1, color.borderHighlight);
				}
			}
			
			src_bmd.unlock();
			
		}
	}

}