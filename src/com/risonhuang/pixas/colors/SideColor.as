package com.risonhuang.pixas.colors 
{
	import com.risonhuang.pixas.math.ColorGeom;

	/**
	 * The SideColor class is the color obj for x or y side
	 *
	 * @author	max
	 */
	public class SideColor extends AbstractColor
	{
		private static const BRIGHTNESS_GAIN : int = - 20;	
		
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
		
		/**
		 * get color instance by count transition with inner side
		 *
		 * @param	_inner	The _inner color
		 * @return	A SideColor instance
		 */			
		public static function getByInnerColor(_inner:uint):SideColor
		{
			return new SideColor
			(
				ColorGeom.applyBrightness(_inner, BRIGHTNESS_GAIN * 4),
				_inner
			);
		}
	}
}