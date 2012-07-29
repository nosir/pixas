package com.risonhuang.pixas.dimensions 
{
	/**
	 * The SideYDms class represents the dimensions of a y axis side
	 * 
	 * @author max
	 */
	public class SideYDms extends AbstractDms
	{

		/**
		 * Construct
		 *
		 * @param	_yAxis	[optional]	The y dimension in 22.6 degrees coordinate
		 * @param	_zAxis	[optional]	The z dimension in 22.6 degrees coordinate
		 */
		public function SideYDms(_yAxis:uint = 30,_zAxis:uint = 30) 
		{
			super();
			
			yAxis = _yAxis;
			zAxis = _zAxis;
			
			if (yAxis % 2 == 1)
			{
				throw new Error("yAxis must be even number");
			}
			
			// xAxis || yAxis = 4 || zAxis = 2 the bitmap cannot apply floodFill
			if (yAxis <= 4 || zAxis <= 2 )
			{
				throw new Error("dimension is too small");
			}			
		}		
	}

}