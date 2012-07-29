package com.risonhuang.pixas.math 
{
	import flash.display.Sprite;

	/**
	 * The Coord3D class is the 22.6 degrees projection pixel position object
	 * <p/>
	 * The postion should be int only ,considering the pixel graphic
	 *
	 * @author	max
	 */
	public class Coord3D
	{
		/**
		 * The 2.5D pixel position x
		 */
		public var x:int;
		/**
		 * The 2.5D pixel position y
		 */
		public var y:int;
		/**
		 * The 2.5D pixel position z
		 */
		public var z:int;

		/**
		 * Construct
		 *
		 * @param	_x	[optional]	The x position in 2.5D pixel coordinate
		 * @param	_y	[optional]	The y position in 2.5D pixel coordinate
		 * @param	_z	[optional]	The z position in 2.5D pixel coordinate
		 */
		public function Coord3D(_x:int = 0, _y:int = 0, _z:int = 0) 
		{
			x = _x;
			y = _y;
			z = _z;
		}
		
		public function toString():String
		{
			return "[x : " + x + ", y : " + y + ", z: " + z + "]";
		}
		
	}
}