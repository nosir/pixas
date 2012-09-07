package com.risonhuang.pixas.colors 
{
	
	/**
	 * The AbstractColor class is the super Class of certains color obj
	 * <p/>seems there is some building problem in FlashDevelop 
	 * <p/>when you try to access a variable in a child Class
	 * <p/>so I put all of the variables in the AbstractDms Class
	 * 
	 * @author	max
	 */
	public class AbstractColor
	{
		/**
		 * The inner colors for elements of certain primitive
		 */
		public var inner:uint;

		/**
		 * The border colors for elements of certain primitive
		 */
		public var border:uint;
		
		/**
		 * The borderHighlight colors for elements of certain primitive
		 */
		public var borderHighlight:uint;

		/**
		 * The left side colors for elements of certain primitive
		 */
		public var left:uint;
		
		/**
		 * The right side colors for elements of certain primitive
		 */
		public var right:uint;
		
		/**
		 * The horizontal colors for elements of certain primitive
		 */
		public var horizontal : uint;

		/**
		 * The left slot side colors for elements of certain primitive
		 */
		public var leftSlope:uint;
		
		/**
		 * The right slot side colors for elements of certain primitive
		 */
		public var rightSlope:uint;
		
		public function AbstractColor() 
		{
			
		}
		
	}

}