package com.risonhuang.pixas.objects.primitives 
{
	import com.risonhuang.pixas.colors.PyramidColor;
	import com.risonhuang.pixas.dimensions.PyramidDms;
	import com.risonhuang.pixas.objects.AbstractPrimitive;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	/**
	 * The Pyramid class is the primitive for constructing Pyramid
	 * <p/>
	 * The width could be different depends on the dimension
	 *
	 * @author	max
	 */
	public class Pyramid extends AbstractPrimitive
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
		public function Pyramid(_dms: PyramidDms = null, _color:PyramidColor = null, _border:Boolean = true) 
		{
			super();
			
			border = _border;
			
			initRender(_dms, _color);
			initRectangle();
			initBmd();
			build();
		}
		
		private function initRender(_dms:PyramidDms,_color:PyramidColor):void
		{
			dms = _dms == null ? new PyramidDms() : _dms;
			color = _color == null ? new PyramidColor() : _color;
			
			hSize = dms.tall ? dms.xAxis * 2 : dms.xAxis;
			hOffset = dms.tall ? -3 : -2;
		}
		
		private function initRectangle():void
		{
			w = dms.xAxis + dms.yAxis;
			h = hSize + dms.xAxis / 2;
			
			w -= 2;
			h += hOffset;
			
			//the matrix offset between the bitmap and the 3d pixel coordinate ZERO point
			matrix.tx = - dms.xAxis + 2;
			matrix.ty = - hSize / 2 + 2 - (dms.tall ? dms.xAxis / 2 : 1);
		}
		
		private function build():void
		{
			src_bmd.lock();
			
			var color_border_left:uint = border ? color.border : color.left;
			var color_border_right:uint = border ? color.border : color.right;
			
			var color_border_highlight:uint = border?color.borderHighlight:color_border_left;
			
			//z axis || hightlight
			for (var k:uint = 0; k < hSize + dms.xAxis / 2 - 4 ; k++) 
			{
				src_bmd.setPixel32(dms.xAxis - 2, k +3 + hOffset, color_border_highlight);
			}
			
			//x axis
			for (var i:uint = 0; i < dms.xAxis ; i++) 
			{
				src_bmd.setPixel32(i, hSize + Math.floor(i / 2) + hOffset, color_border_left);
			}
			//y axis
			for (var j:uint = 0; j< dms.xAxis ; j++) 
			{
				src_bmd.setPixel32(j + dms.xAxis - 2, hSize + dms.xAxis / 2 - Math.floor(j / 2) - 1 +hOffset, color_border_right);
			}
			
			if (!dms.tall)
			{
				//left edge			
				for (var l1:uint = 0; l1 < hSize ; l1++) 
				{
					src_bmd.setPixel32(l1, hSize - l1 + hOffset, color_border_left);
				}
				//right edge
				for (var m1:uint = 0; m1 <hSize ; m1++) 
				{
					src_bmd.setPixel32(m1 + hSize - 2, m1 + 1 +hOffset, color_border_right);
				}				
			}
			else
			{
				//left edge			
				for (var l2:uint = 0; l2 < hSize -2 ; l2++) 
				{
					src_bmd.setPixel32(Math.floor(l2 / 2), hSize - l2 + hOffset, color_border_left);
				}
				//right edge
				for (var m2:uint = 2; m2 < hSize ; m2++) 
				{
					src_bmd.setPixel32(Math.floor(m2 / 2) + dms.xAxis - 2, m2 + 1 + hOffset, color_border_right);
				}
			}
			
			if (!border)
			{
				src_bmd.setPixel32(dms.xAxis - 2, hSize + dms.xAxis / 2 - 1 + hOffset, color_border_left);
			}
			
			//floodfill
			src_bmd.floodFill(dms.xAxis - 1,hSize + Math.floor((dms.xAxis -1) / 2) + hOffset - 1,  color.right);
			src_bmd.floodFill(dms.xAxis - 3,hSize + Math.floor((dms.xAxis -1) / 2) + hOffset - 2,  color.left);
			
			src_bmd.unlock();
			
		}
	}

}