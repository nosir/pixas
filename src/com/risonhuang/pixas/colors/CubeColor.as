package com.risonhuang.pixas.colors
{
	import  com.risonhuang.pixas.math.ColorGeom;
	
	/**
	 * The CubeColor class is the color obj for cube
	 *
	 * @author	max
	 */
	public class CubeColor extends AbstractColor
	{
		private static const BRIGHTNESS_GAIN : int = - 20;
		
		/**
		 * Construct
		 *
		 * @param	_border	[optional]	The border color
		 * @param	_borderHighlight	[optional]	The highlight color
		 * @param	_left	[optional]	The left side color
		 * @param	_right	[optional]	The right side color
		 * @param	_horizontal	[optional]	The horizontal color
		 */
		public function CubeColor
		(
			_border:uint = 0x949698,
			_borderHighlight:uint = 0xFFFFFF,
			_left:uint = 0xC9CFD0,
			_right:uint = 0xE6E8E9,
			_horizontal:uint = 0xEEEFF0
		) 
		{
			super();
			
			border = ColorGeom.get32(_border);
			borderHighlight = ColorGeom.get32(_borderHighlight);
			left = ColorGeom.get32(_left);
			right = ColorGeom.get32(_right);
			horizontal = ColorGeom.get32(_horizontal);
		}
		
		/**
		 * get color instance by count transition with horizontal side
		 *
		 * @param	_horizontal The horizontal color
		 * @return	An CubeColor instance
		 */		
		public static function getByHorizontalColor(_horizontal:uint):CubeColor
		{
			return new CubeColor
			(
				ColorGeom.applyBrightness(_horizontal, BRIGHTNESS_GAIN * 4),
				//apply hightlight
				ColorGeom.applyBrightness(_horizontal, 0, true),
				ColorGeom.applyBrightness(_horizontal, BRIGHTNESS_GAIN * 2),
				ColorGeom.applyBrightness(_horizontal, BRIGHTNESS_GAIN),
				_horizontal
			);
		}
		
	}
}