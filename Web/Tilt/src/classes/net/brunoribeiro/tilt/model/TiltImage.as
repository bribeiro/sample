package net.brunoribeiro.tilt.model
{
	import flash.display.Bitmap;
	
	/**
	 * @author Bruno Ribeiro
	 */
	public class TiltImage
	{
		private static var __instance : TiltImage;
		
		private var _image			  : Bitmap;
		
		public function TiltImage(enforcer : SingletonEnforcer) 
		{
		}
		
		
		public static function getInstance() : TiltImage
		{
			if (TiltImage.__instance == null)
				__instance = new TiltImage(new SingletonEnforcer());
			
			return __instance;
		}
		
		public function get image () : Bitmap
		{
			return _image;
		}
		
		public function set image (__image : Bitmap) : void
		{
			_image = __image;
		}
		
	}
}

class SingletonEnforcer 
{
}