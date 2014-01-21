package net.brunoribeiro.utils
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.geom.Point;

	public class BitmapUtils
	{
		public function BitmapUtils()
		{
		}
		
		public static function smoothBitmap (image : Bitmap) : Bitmap
		{
			return new Bitmap(image.bitmapData, "auto", true);
		}
		
		public static function resize ( DO : DisplayObject, maxWidth : Number, maxHeight : Number ) : void
		{
			//calculation ratio
			var r:Number = DO.height / DO.width;
			if (DO.width>maxWidth)
			{
				DO.width = maxWidth;
				DO.height = Math.round(DO.width*r);
			}
			if (DO.height>maxHeight)
			{
				DO.height = maxHeight;
				DO.width = Math.round(DO.height/r);
			}
		}
	}
}