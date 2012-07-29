package com.risonhuang.pixas.objects.primitives 
{
	import com.risonhuang.pixas.objects.AbstractPrimitive;
	import flash.display.BitmapData;
	import com.risonhuang.pixas.colors.SideColor;
	import com.risonhuang.pixas.dimensions.SideXDms;
	
	/**
	 * The SideX class is the primitive for constructing X axis Side
	 *
	 * @author	max
	 */
	public class SideX extends AbstractPrimitive
	{
		private var border:Boolean;
		
		/**
		 * Construct
		 *
		 * @param	_dms	[optional]	the dimension obj for rendering
		 * @param	_color	[optional]	the color obj for rendering
		 * @param	_border [optional]	whether show border,you may hide borders when arranging the side
		 */
		public function SideX(_dms:SideXDms= null,_color:SideColor = null,_border: Boolean = true) 
		{
			super();
			
			border = _border;
			
			initRender(_dms, _color);
			initRectangle();
			initBmd();
			build();
		}
		
		private function initRender(_dms:SideXDms,_color:SideColor):void
		{
			dms = _dms == null ? new SideXDms() : _dms;
			color = _color == null ? new SideColor() : _color;
			
			if (!border)
			{
				color.border = color.inner;
			}
		}
		
		private function initRectangle():void
		{
			w = dms.xAxis;
			h = dms.zAxis + dms.xAxis / 2;
			
			//the matrix offset between the bitmap and the 3d pixel coordinate ZERO point
			matrix.tx = 0;
			matrix.ty = - dms.zAxis;
		}
		
		private function build():void
		{
			var xOffsetInner:int = 0;
			var yOffsetInner:int = dms.zAxis;
			var xOffsetOut:int = dms.xAxis - 1;
			var yOffsetOut:int = h - dms.zAxis - 1;

			src_bmd.lock();
			
			//x axis
			for (var i:uint = 0; i < dms.xAxis ; i++) 
			{
				src_bmd.setPixel32(xOffsetInner + i, yOffsetInner + Math.floor(i / 2), color.border);
				src_bmd.setPixel32(xOffsetOut - i, yOffsetOut - Math.floor(i / 2), color.border);
			}
			
			//z axis
			for (var j:uint = 0; j < dms.zAxis ; j++) 
			{
				src_bmd.setPixel32(xOffsetInner, yOffsetInner - j, color.border);
				src_bmd.setPixel32(xOffsetOut , yOffsetOut +j, color.border);
			}
			
			//fill an pixel graphic enclosed
			src_bmd.floodFill(Math.floor(w / 2), Math.floor(h / 2),  color.inner);
			
			src_bmd.unlock();
		}
		
	}

}