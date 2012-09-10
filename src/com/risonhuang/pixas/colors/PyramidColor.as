package com.risonhuang.pixas.colors 
{
	import  com.risonhuang.pixas.math.ColorGeom;
	
	/**
	 * The PyramidColor class is the color obj for pyramid
	 *
	 * @author	max
	 */
	public class PyramidColor extends AbstractColor
	{
		private static const BRIGHTNESS_GAIN : int = - 20;
		
		/**
		 * Construct
		 *
		 * @param	_border	[optional]	The border color
		 * @param	_borderHighlight	[optional]	The highlight color
		 * @param	_left	[optional]	The left side color
		 * @param	_right	[optional]	The right side color
		 */
		public function PyramidColor
		(
			_border:uint = 0x949698,
			_borderHighlight:uint = 0xFFFFFF,
			_left:uint = 0xE6E8E9,
			_right:uint = 0xEEEFF0
		) 
		{
			super();
			
			border = ColorGeom.get32(_border);
			borderHighlight = ColorGeom.get32(_borderHighlight);
			left = ColorGeom.get32(_left);
			right = ColorGeom.get32(_right);
		}
		
		/**
		 * get color instance by count transition with right side
		 *
		 * @param	_right	The right color
		 * @return	A PyramidColor instance
		 */		
		public static function getByRightColor(_right:uint):PyramidColor
		{
			return new PyramidColor
			(
				ColorGeom.applyBrightness(_right, BRIGHTNESS_GAIN * 4),
				//apply hightlight
				ColorGeom.applyBrightness(_right, 0, true),
				ColorGeom.applyBrightness(_right, BRIGHTNESS_GAIN),
				_right
			);
		}
	}
}