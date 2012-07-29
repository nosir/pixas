package com.risonhuang.pixas.math 
{
	
	/**
	 * The ColorTrim class processes the color number
	 *
	 * @author	max
	 */
	public class ColorGeom
	{
		
		public function ColorGeom() 
		{
		}
		
		/**
		 * Convert RGB to ARGB value
		 * <p/>
		 * If alpha channel needed, one could pass ARGB value
		 * <p/>
		 * Like 0xEEFFFF00
		 *
		 * @param	_color	the int16 or int32 value uint
		 * @return	int32 value uint
		 */
		public static function get32(_color:uint):uint
		{
			var color:uint = _color < 0xFF000000 ? (_color + 0xFF000000) : _color;
			return color;
		}
		
		/**
		 * Get the color value after applying brightness
		 * <p/>
		 * Add the pixel highlight
		 * 
		 * @author blueshell
		 * @param color	source color
		 * @param brightness	brightness intend to apply on the source color
		 * @return target color
		 * @see http://bbs.9ria.com/thread-810-1-1.html
		 */
		public static function applyBrightness (color : uint, brightness : int,highlight:Boolean = false) :uint 
		{
                
			var r :  int = ((color>>>16) & 0x000000FF);
			var g : int = ((color>>> 8) & 0x000000FF);
			var b : int = ((color) & 0x000000FF);
			
			var y : int;
			var v : int;
			var u : int;

			y  =   ((r*313524)>>20) + ((g*615514)>>20) + ((b*119538)>>20);
			u  =  -((155189*r)>>20) - ((303038*g)>>20) + ((458227*b)>>20);
			v  =   ((644874*r)>>20) - ((540016*g)>>20) - ((104857*b)>>20);

			if (!highlight)
			{
				y += brightness;
			}
			else
			{
				y = 60 + Math.pow( y , 1.2);
			}

			r = y + ((1195376*v)>>20);
			g = y - ((408944*u)>>20) - ((608174*v)>>20);
			b = y + ((2128609*u)>>20);

			r = Math.max  (0,Math.min (r,255));
			g = Math.max (0,Math.min (g,255));
			b = Math.max (0,Math.min (b,255));

			return (r << 16) | (g << 8) | b;
		}
	}

}