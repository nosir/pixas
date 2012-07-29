package com.risonhuang.pixas.objects
{
	import com.risonhuang.pixas.Pixas;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import com.risonhuang.pixas.colors.AbstractColor;
	import com.risonhuang.pixas.dimensions.AbstractDms;
	import flash.geom.Matrix;
	
	/**
	 * The AbstractPrimitive class is the super Class of primitives.
	 * <p/> It is not allowed to add primitives onto the stage directly. 
	 * <p/> Instead of, you should assign it as a parameter when creating instance of PixelObject, 
	 * <p/> or set it to the primitive property of the PixelObject instance.
	 * <p/> then add the PixelObject onto the stage as a Sprite
	 * 
	 * @author	max
	 */
	
	public class AbstractPrimitive
	{
		/**
		* the matrix offset between the bitmap and the 3d pixel coordinate ZERO point
		*/
		protected var matrix:Matrix;
		
		/**
		 * the width of the bitmap in 2d flash coordinate
		 */
		protected var w:uint;
		/**
		 * the height of the bitmap in 2d flash coordinate
		 */
		protected var h:uint;
		
		/**
		 * the dimension of primative in 3d pixel coordinate
		 */
		protected var dms:AbstractDms;
		
		/**
		 * the color obj of the primative
		 */
		protected var color:AbstractColor;
		
		/**
		 * the source bitmapdata contains pixel graphic
		 */
		protected var src_bmd:BitmapData;
		
		
		/**
		 * Construct
		 */
		public function AbstractPrimitive() 
		{
			w = h = 0;
			matrix = new Matrix();
			Pixas.NAME;
		}
		
		/**
		* [internal-use]
		*/
		
		/**
		 * The Primitive Classes generate bitmap for PixelObject
		 * <p/>
		 * All of these bitmap could be reused in PixelObject without caculating again.
		 * <p/>
		 * see	the "bmd.clone()" line
		 * 
		 * @return	the Bitmap of a primitive
		*/
		internal function generate():Bitmap
		{
			var bm : Bitmap = new Bitmap(src_bmd.clone());
			bm.x = matrix.tx;
			bm.y = matrix.ty;
			return bm;
		}
		
		/*
		 *initilize the BitmapData
		 */
		protected function initBmd():void
		{
			if (w == 0 || h == 0 )
			{
				throw new Error("BitmapData has not been initilized.");
			}
			src_bmd = new BitmapData(w, h , true , 0x00FFFFFF);
		}
		
		public function toString():String
		{
			return "[Pixel Object]";
		}
	}

}