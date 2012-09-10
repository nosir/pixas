package com.risonhuang.pixas.colors
{
	import  com.risonhuang.pixas.math.ColorGeom;
	
	/**
	 * The SlopeColor class is the color obj for slopes
	 *
	 * @author	max
	 */
	public class SlopeColor extends AbstractColor
	{
		private static const BRIGHTNESS_GAIN : int = - 20;
		
		/**
		 * Construct
		 *
		 * @param	_border	[optional]	The border color
		 * @param	_borderHighlight	[optional]	The highlight color
		 * @param	_left	[optional]	The left side color
		 * @param	_right	[optional]	The right side color
		 * @param	_leftSlope	[optional]	The left slope side color
		 * @param	_rightSlope	[optional]	The right slope side color
		 */
		public function SlopeColor
		(
			_border:uint = 0x949698,
			_borderHighlight:uint = 0xFFFFFF,
			_left:uint = 0xC9CFD0,
			_right:uint = 0xE6E8E9,
			_leftSlope:uint = 0xDBDBDB,
			_rightSlope:uint = 0xEEEEEE
		) 
		{
			super();
			
			border = ColorGeom.get32(_border);
			borderHighlight = ColorGeom.get32(_borderHighlight);
			left = ColorGeom.get32(_left);
			right = ColorGeom.get32(_right);
			leftSlope = ColorGeom.get32(_leftSlope);
			rightSlope = ColorGeom.get32(_rightSlope);
		}
		
		/**
		 * get color instance by count transition with horizontal side
		 * <p/>horizontal side doesn't exist in the Slope primitive
		 * <p/>you can assign the same horizontal color as cube to arrange the slot with cube
		 *
		 * @param	_horizontal	The horizontal color
		 * @return	An SlopeColor instance
		 */		
		public static function getByHorizontalColor(_horizontal:uint):SlopeColor
		{
			return new SlopeColor
			(
				ColorGeom.applyBrightness(_horizontal, BRIGHTNESS_GAIN * 4),
				//apply hightlight
				ColorGeom.applyBrightness(_horizontal, 0, true),
				ColorGeom.applyBrightness(_horizontal, BRIGHTNESS_GAIN * 2),
				ColorGeom.applyBrightness(_horizontal, BRIGHTNESS_GAIN),
				ColorGeom.applyBrightness(_horizontal, BRIGHTNESS_GAIN * 1.5),
				ColorGeom.applyBrightness(_horizontal, BRIGHTNESS_GAIN * 0.5)
			);
		}
		
	}
}