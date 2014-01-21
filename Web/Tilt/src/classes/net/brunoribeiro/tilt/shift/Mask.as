package net.brunoribeiro.tilt.shift
{

	import flash.display.Bitmap;
	import flash.display.GradientType;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.filters.BlurFilter;
	import flash.geom.Matrix;
	import gs.TweenFilterLite;
	import gs.TweenMax;
	
	/**
	 * ...
	 * @author Bruno Ribeiro
	 */
	public class Mask extends MovieClip
	{
		private var _mask			: Sprite;
		private var _image			: Sprite;
		private var _img			: Bitmap;
		private var _blurStrongness : Number;
		
		private var _gradient1		: Number = 70;
		private var _gradient2		: Number = 127.5;
		private var _gradient3		: Number = 180;
		
			
		public function Mask( bmp : Bitmap) 
		{
			_image		= addChildAt(new MovieClip(),0) as MovieClip;
			_mask		= mask_mc;
			_blurStrongness	= 6;

			//drawMask();
			
			var aFilter: Array 	= [new BlurFilter(_blurStrongness, _blurStrongness, 1)];
			_image.filters		= aFilter;
			
			_image.addChild(bmp);
			
			_mask.width		= _image.width;
			_mask.height	= _image.height;
			
			/**
			 * As the information is sent as ref. we don't need apply the filter once again
			 */
			TweenMax.to(_image, 0, { colorMatrixFilter:Miniatura.IMAGECHANGER} );
			
			_mask.cacheAsBitmap		= true;
			_image.cacheAsBitmap	= true;
		//	_image.mask				= _mask;		
		}
			
		public function updateMaskSize (val : Number) : void
		{
			trace("mask size", val)
		//	_gradient1 = val;
		//	_gradient3 = 255 - val;
		//	drawMask(_gradient1, _gradient2, _gradient3);
		}
		
		public function updateMaskPosition (val : Number ) : void
		{
			trace('position', val)
			//_gradient2 = val //(255 * val / 100);
			//_gradient2 = val;
			//var dif : Number = 127.5 - _gradient2;
			//drawMask(_gradient1- dif, _gradient2, _gradient3 - dif );			
		}
		
		public function updateBlur ( num : Number ) : void
		{
			_blurStrongness 	= num;
			var aFilter: Array 	= [new BlurFilter(_blurStrongness, _blurStrongness, 1)];
			_image.filters		= [].concat();
			_image.filters		= aFilter;
		}
			
		public function getMask():Sprite { return _mask; }		
		public function setMask(value:Sprite):void 
		{
			_mask = value;
		}
		
	}
	
}