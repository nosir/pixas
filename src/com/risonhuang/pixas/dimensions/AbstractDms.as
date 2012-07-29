package com.risonhuang.pixas.dimensions 
{
	/**
	 * The AbstractDms class is the super Class of certains dimension
	 * <p/>seems there is a building problem in FlashDevelop when I tried to access a variable in a child Class
	 * <p/>so I put all of the variables in the AbstractDms Class
	 *
	 * @author	max
	 */
	public class AbstractDms
	{
		
		/**
		* The x Axis dimensions in 22.6 degrees coordinate
		*/
		public var xAxis:uint;
		
		/**
		* The y Axis dimensions in 22.6 degrees coordinate
		*/
		public var yAxis:uint;
		
		/**
		* The z Axis dimensions in 22.6 degrees coordinate
		*/
		public var zAxis:uint;
		
		/**
		* Pyramid tall mode 
		*/
		public var tall:Boolean;
		
		public function AbstractDms() 
		{
		}
		
	}

}