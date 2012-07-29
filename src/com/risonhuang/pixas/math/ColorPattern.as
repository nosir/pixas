package com.risonhuang.pixas.math 
{
	/**
	 * The ColorPattern defined some constant bright and joyful Color value
	 *
	 * @author	max
	 */
	public class ColorPattern
	{
		
		public static const GRASS_GREEN : uint = 0xCCFF00;	
		public static const YELLOW : uint = 0xFFFF00;		
		public static const WINE_RED : uint = 0xFF0099;
		public static const PINK : uint = 0xFF7CBF;
		public static const PURPLE : uint = 0xCC00FF;
		public static const BLUE : uint = 0x00CCFF;
		public static const GRAY : uint = 0xEEEEEE;
		public static const BLACK : uint = 0x666666;
		private static const FINE_COLORS : Array = 
																[
																	GRASS_GREEN,
																	YELLOW,
																	WINE_RED,
																	PINK,
																	PURPLE,
																	BLUE,
																	GRAY,
																	BLACK																	
																];
		// TODO: to add more comfortable colors for pixel arts
		
		public function ColorPattern() 
		{
		}
		
		/**
		 * Get random comfortable color in tile applications
		 * @return color value uint
		 */
		public static function getRandomComfortableColor():uint
		{
			return FINE_COLORS[Math.floor(Math.random() * FINE_COLORS.length)];
		}
	}

}