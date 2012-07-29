package com.risonhuang.pixas.colors 
{
	import com.risonhuang.pixas.math.ColorGeom;

	/**
	 * The SideColor class is the olor obj for x or y side
	 *
	 * @author	max
	 */
	public class SideColor extends AbstractColor
	{
		
		/**
		 * Construct
		 *
		 * @param	_border	[optional]	The border color
		 * @param	_inner	[optional]	The inner fill color
		 */
		public function SideColor(_border:uint = 0x878787,_inner:uint = 0xEEEEEE) 
		{
			super();
			
			border = ColorGeom.get32(_border);
			inner = ColorGeom.get32(_inner);
		}
	}
}