package com.risonhuang.pixas.dimensions 
{
	/**
	 * The SideXDms class represents the dimensions of a x axis side
	 *
	 * @author	max
	 */
	public class SideXDms extends AbstractDms
	{
		
		/**
		 * Construct
		 *
		 * @param	_xAxis	[optional]	The x dimension in 22.6 degrees coordinate
		 * @param	_zAxis	[optional]	The z dimension in 22.6 degrees coordinate
		 */		
		public function SideXDms(_xAxis:uint = 30,_zAxis:uint = 30) 
		{
			super();
			
			xAxis = _xAxis;
			zAxis = _zAxis;
			
			if (xAxis % 2 == 1)
			{
				throw new Error("xAxis must be even number");
			}
			
			// xAxis || yAxis = 4 || zAxis = 2 the bitmap cannot apply floodFill
			if (xAxis <= 4 || zAxis <=2 )
			{
				throw new Error("dimension is too small");
			}			
		}		
	}

}