package com.risonhuang.pixas.objects 
{
	import com.risonhuang.pixas.math.Coord3D;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	/**
	 * The PixelObject class represents instances of pixel objects.
	 * <p/> A PixelObject instance could only nest SINGLE primitive,
	 * <p/> cube, for instance.
	 * <p/> However, you can add as many as PixelObjects to a single PixelObject.
	 * <p/> It extends from Sprite, which means you can manipulate it as a normal Sprite.
	 * <p/> 
	 * <p/> To use it, you should assign a primitive instance as a parameter when creating instance of PixelObject
	 * <p/> or set it to the primitive property of the PixelObject instance,
	 * <p/> then add the PixelObject onto the stage as a Sprite
	 *
	 * @author	max
	 * @example	See the examples folder
	 */
	public class PixelObject extends Sprite
	{
		
		private var bmp:Bitmap;
		private var pos:Coord3D;
		private var pmt:AbstractPrimitive;
		
		/**
		 * Construct
		 *
		 * @param	_pmt	[optional]	The primitive(if it nests certain primitive) of the obj
		 * @param	_pos	[optional]	The pixel 3d postion of the obj
		 */
		public function PixelObject(_pmt:AbstractPrimitive = null,_pos:Coord3D = null) 
		{
			bmp = null;
			
			if (_pmt != null)
			{
				pmt = _pmt;
				generate();
			}
			
			if (_pos == null)
			{
				pos = new Coord3D();
			}
			else
			{
				pos = _pos
			}

			place();
		}
				
		/**
		 * Remove all the children
		 */		
		public function removeAllChildren():void
		{
			while (this.numChildren > 0)
			{
				this.removeChildAt(0);
			}
		}
		
		/**
		 * Add new attribute of the PixelObject
		 * <p/>
		 * One could change the primitive by apply instance.primitive
		 * <p/>
		 * Or by pass the primitive in Construct
		 *
		 * @param	_pmt	The pixel object primitive(if it nests certain primitive)
		 */
		public function set primitive(_pmt:AbstractPrimitive):void
		{
			pmt = _pmt;
			generate();
		}
		
		/**
		 * @return The current primitive instance of the pixel object
		 */
		public function get primitive():AbstractPrimitive
		{
			return pmt;
		}
		
		/**
		 * One could change the primitive by apply instance.primitive
		 * <p/>
		 * Or by pass the primitive in Construct
		 *
		 * @param	_pos	The pixel object 3d Pixel position
		 */
		public function set position(_pos:Coord3D):void
		{
			pos = _pos;
			place();
		}
		
		/**
		 * @return The current Coord3D instance of the pixel object
		 */
		public function get position():Coord3D
		{
			return pos;
		}
		
		/**
		 * Set the X position of the pixel object
		 *
		 * @param	_posX	The position in X axis
		 */
		public function set positionX(_posX:int):void
		{
			pos = new Coord3D(_posX,pos.y,pos.z);
			place();
		}
		
		/**
		 * @return The current X position of the pixel object
		 */
		public function get positionX():int
		{
			return pos.x;
		}
		
		/**
		 * Set the Y position of the pixel object
		 *
		 * @param	_posY	The position in Y axis
		 */
		public function set positionY(_posY:int):void
		{
			pos = new Coord3D(pos.x,_posY,pos.z);
			place();
		}
		
		/**
		 * @return The current Y position of the pixel object
		 */
		public function get positionY():int
		{
			return pos.y;
		}
		
		/**
		 * Set the Z position of the pixel object
		 *
		 * @param	_posZ	The position in Z axis
		 */
		public function set positionZ(_posZ:int):void
		{
			pos = new Coord3D(pos.x,pos.y,_posZ);
			place();
		}
		
		/**
		 * @return The current Z position of the pixel object
		 */
		public function get positionZ():int
		{
			return pos.z;
		}
		
		/**
		 * @return The bitmap of the pixel object
		 */
		public function get bitmap():Bitmap
		{
			return bmp;
		}
		
		private function generate():void
		{
			removeAllChildren();
			bmp = pmt.generate();
			addChild(bmp);
		}
		
		private function place():void
		{
			x = pos.x - pos.y;
			y = - pos.z + Math.floor (pos.x / 2 + pos.y / 2);
		}
		
	}

}