package net.brunoribeiro.tilt.shift
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.LoaderInfo;	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.BlurFilter;
	import flash.geom.Point;
	import flash.net.URLRequest;
	import gs.*;
	import gs.plugins.*;
	
	/**
	 * ...
	 * @author Bruno Ribeiro
	 */
	public class Miniatura extends Sprite
	{
		public static var instance	: Miniatura;
		
		private var _url			: String;
		private var _bmp			: Bitmap;
		private var _image			: Sprite;
		private var _imageMask		: Sprite;
		private var _IMAGECHANGER	: Object;
		private var clicked			: Boolean;
		private var _mascara		: MovieClip;
		
		private static const IMAGECHANGER : Object = { brightness:.8,  saturation:1.1, contrast:1.4};
		private var _blurStrongness	: Number;
		
		public function Miniatura() 
		{
			instance		= this;
			_blurStrongness	= 6;
			
			_imageMask		= addChildAt(new Sprite(),0) as Sprite;
			_image			= addChildAt(new Sprite(),0) as Sprite;
			
			_mascara							= mask_mc;
			_mascara.cacheAsBitmap				= true;
			_mascara.mcMask1.cacheAsBitmap		= true;
			_mascara.mcMask2.cacheAsBitmap		= true;
						
			var imageBmp	: Bitmap	= new Bitmap(Main.IMG.bitmapData);
			imageBmp.width				= 349;
			imageBmp.height				= 260;	
			imageBmp.cacheAsBitmap		= true;
			_image.cacheAsBitmap		= true;
			_image.addChild(imageBmp);
				
			var tempBmp	: Bitmap		= new Bitmap(Main.IMG.bitmapData);
			tempBmp.width				= 349;
			tempBmp.height				= 260;
			tempBmp.cacheAsBitmap		= true;
			_imageMask.cacheAsBitmap	= true;
			_imageMask.addChild(tempBmp);
						
			var aFilter: Array 			= [new BlurFilter(_blurStrongness, _blurStrongness, 1)];
			_imageMask.filters			= aFilter;
			_imageMask.mask				= _mascara;
			
			_imageMask.alpha			= 0;
			_mascara.alpha				= 0;
						
			TweenMax.to(_imageMask, 0, { colorMatrixFilter: Miniatura.IMAGECHANGER } );		
		}
		
		public function init () : void
		{
			TweenLite.to(_imageMask, 1, { alpha: 1} );
			TweenLite.to(_mascara, 1, { alpha: 1} );
		}
				
		public function updateMaskSize () : void
		{
			_mascara.mcMask1.y = AdjustPanel.instance.line1.y + 107;
			_mascara.mcMask2.y = AdjustPanel.instance.line2.y + 76;
		}
		
		public function updateMaskPosition () : void
		{			
			_mascara.mcMask1.y = AdjustPanel.instance.line1.y + 107;
			_mascara.mcMask2.y = AdjustPanel.instance.line2.y + 76;
		}
		
		public function updateBlur ( num : Number ) : void
		{
			_blurStrongness 		= num;
			var aFilter: Array	 	= [new BlurFilter(_blurStrongness, _blurStrongness, 1)];
			_imageMask.filters		= [].concat();
			_imageMask.filters		= aFilter;
		}
		
		public function get IMAGECHANGER():Object { return _IMAGECHANGER; }		
		public function set IMAGECHANGER(value:Object):void 
		{
			_IMAGECHANGER = value;
		}		
		
		public function get mascara():MovieClip { return _mascara; }		
		public function set mascara(value:MovieClip):void 
		{
			_mascara = value;
		}

	}
	
}