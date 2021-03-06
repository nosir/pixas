﻿package com.risonhuang.pixas.objects.primitives 
{
	import com.risonhuang.pixas.objects.AbstractPrimitive;
	import flash.display.BitmapData;
	import com.risonhuang.pixas.colors.SideColor;
	import com.risonhuang.pixas.dimensions.BrickDms;	
	
	/**
	 * The Brick class is the primitive for constructing horizontal layers
	 *
	 * @author	max
	 */
	public class Brick extends AbstractPrimitive
	{
		private var border:Boolean;
		
		/**
		 * Construct
		 *
		 * @param	_dms	[optional]	the dimension obj for rendering
		 * @param	_color	[optional]	the color obj for rendering
		 * @param	_border [optional]	whether show border,maybe hide borders when arranging the brick
		 */
		public function Brick(_dms: BrickDms= null,_color:SideColor = null, _border:Boolean = true) 
		{
	
			super();
			
			border = _border;

			initRender(_dms, _color);
			initRectangle();
			initBmd();
			build();
		}
		
		private function initRender(_dms:BrickDms,_color:SideColor):void
		{
			dms = _dms == null ? new BrickDms() : _dms;
			color = _color == null ? new SideColor() : _color;
			
			if (!border)
			{
				color.border = color.inner;
			}
		}
		
		private function initRectangle():void
		{
			w = dms.xAxis + dms.yAxis;
			h = (dms.xAxis + dms.yAxis) / 2;
			
			// 22.6 degrees implementation
			w -= 2;
			h -= 1;
			
			//the matrix offset between the bitmap and the 3d pixel coordinate ZERO point
			matrix.tx = - dms.yAxis + 2;
			matrix.ty = 0;
		}
		
		private function build():void
		{
			var xOffsetInner:int = dms.yAxis - 2;
			var yOffsetInner:int = 0;
			var xOffsetOut:int = dms.xAxis - 1;
			var yOffsetOut:int = h - 1;
			
			src_bmd.lock();

			//x axis
			for (var i:uint = 0; i < dms.xAxis ; i++) 
			{
				src_bmd.setPixel32(xOffsetInner + i, yOffsetInner + Math.floor(i / 2), color.border);
				src_bmd.setPixel32(xOffsetOut - i, yOffsetOut - Math.floor(i / 2), color.border);
			}
			
			//z axis
			for (var j:uint = 0; j < dms.yAxis ; j++) 
			{
				src_bmd.setPixel32(xOffsetInner + 1 - j, yOffsetInner + Math.floor(j / 2), color.border);
				src_bmd.setPixel32(xOffsetOut - 1 + j, yOffsetOut - Math.floor(j / 2), color.border);
			}
			
			//fill an pixel graphic enclosed
			src_bmd.floodFill(Math.floor(w / 2), Math.floor(h / 2),  color.inner);
			
			src_bmd.unlock();
		}

	}
}