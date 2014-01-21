package net.brunoribeiro.tilt.model
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.system.LoaderContext;
	
	import net.brunoribeiro.tilt.Tilt;

	public class Model
	{
		private var _file	: FileReference;
		private var _filter	: FileFilter;
		
		private var _view	: Tilt;
		
		public function Model( __view : Tilt )
		{
			_file	= new FileReference();
			_filter	= new FileFilter("Images", "*.jpeg;*.jpg;*.gif;*.png");
			_view	= __view;
			
			_file.addEventListener(Event.SELECT, _loadImage, false, 0, true);
			_file.addEventListener(Event.COMPLETE, _fileLoaded, false, 0, true);
		}
		
		public function browse () : void
		{
			_file.browse([_filter]);
		}
		
		private function _loadImage (e : Event) : void
		{
			_file.load();
		}
		
		private function _fileLoaded (e : Event) : void
		{
			var context:LoaderContext = new LoaderContext();
			var loader : Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, _bitmapLoaded, false, 0, true);
			loader.loadBytes(_file.data, context);
		}
		
		private function _bitmapLoaded (e : Event) : void
		{
			TiltImage.getInstance().image = new Bitmap( (LoaderInfo(e.target).content as Bitmap).bitmapData, "auto", true);
			_view.showImage();
		}
	}
}