package com.risonhuang.pixas.dimensions 
{
	/**
	 * The CubeDms class represents the dimensions of a cube
	 *
	 * @author	max
	 */
	public class CubeDms extends AbstractDms
	{

		/**
		 * Construct
		 *
		 * @param	_xAxis	[optional]	The x dimension in 22.6 degrees coordinate
		 * @param	_yAxis	[optional]	The y dimension in 22.6 degrees coordinate
		 * @param	_zAxis	[optional]	The z dimension in 22.6 degrees coordinate
		 */
		public function CubeDms(_xAxis:uint = 30,_yAxis:uint = 30,_zAxis:uint = 30) 
		{
			super();
			
			xAxis = _xAxis;
			yAxis = _yAxis;
			zAxis = _zAxis;
			
			if (xAxis % 2 == 1 || yAxis % 2 == 1)
			{
				throw new Error("x,yAxis must be even number");
			}
			
			// xAxis || yAxis = 4 || zAxis = 2 the bitmap cannot apply floodFill
			if (xAxis <= 4 || yAxis <= 4 || zAxis <= 2)
			{
				throw new Error("dimension is too small");
			}
		}
	}
}