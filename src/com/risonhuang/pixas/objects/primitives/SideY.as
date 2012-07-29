package com.risonhuang.pixas.objects.primitives 
{
	import flash.display.BitmapData;
	import com.risonhuang.pixas.colors.SideColor;
	import com.risonhuang.pixas.dimensions.SideYDms;
	import com.risonhuang.pixas.objects.AbstractPrimitive;
	
	/**
	 * The SideX class is the primitive for constructing Y axis Side
	 *
	 * @author	max
	 */
	public class SideY extends AbstractPrimitive
	{
		private var border:Boolean;
		
		/**
		 * Construct
		 *
		 * @param	_dms	[optional]	the dimension obj for rendering
		 * @param	_color	[optional]	the color obj for rendering
		 * @param	_border [optional]	whether show border,you may hide borders when arranging the side
		 */
		public function SideY(_dms:SideYDms= null,_color:SideColor = null,_border: Boolean = true) 
		{
			super();
			
			border = _border;
			
			initRender(_dms, _color);
			initRectangle();
			initBmd();
			build();
		}
		
		private function initRender(_dms:SideYDms,_color:SideColor):void
		{
			dms = _dms == null ? new SideYDms() : _dms;
			color = _color == null ? new SideColor() : _color;
			
			if (!border)
			{
				color.border = color.inner;
			}
		}
				
		private function initRectangle():void
		{
			w = dms.yAxis;
			h = dms.zAxis + dms.yAxis / 2;
			
			//the matrix offset between the bitmap and the 3d pixel coordinate ZERO point
			matrix.tx = - dms.yAxis + 2;
			matrix.ty = - dms.zAxis;
		}
		
		private function build():void
		{
			var xOffsetInner:int = 0;
			var yOffsetInner:int = h - dms.zAxis - 1
			var xOffsetOut:int = dms.yAxis - 1;
			var yOffsetOut:int = dms.zAxis;

			src_bmd.lock();
			
			//y axis
			for (var i:uint = 0; i < dms.yAxis ; i++) 
			{
				src_bmd.setPixel32(xOffsetInner + i, yOffsetInner - Math.floor(i / 2), color.border);
				src_bmd.setPixel32(xOffsetOut - i, yOffsetOut + Math.floor(i / 2), color.border);
			}
			
			//z axis
			for (var j:uint = 0; j < dms.zAxis ; j++) 
			{
				src_bmd.setPixel32(xOffsetInner, yOffsetInner + j, color.border);
				src_bmd.setPixel32(xOffsetOut , yOffsetOut - j, color.border);
			}
			
			//fill an pixel graphic enclosed
			src_bmd.floodFill(Math.floor(w / 2), Math.floor(h / 2),  color.inner);
			
			src_bmd.unlock();
		}
		
	}

}