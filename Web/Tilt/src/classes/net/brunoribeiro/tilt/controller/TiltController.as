package net.brunoribeiro.tilt.controller
{
	import net.brunoribeiro.tilt.Tilt;
	import net.brunoribeiro.tilt.event.TiltEvent;
	import net.brunoribeiro.tilt.model.Model;

	public class TiltController
	{
		private var _view		: Tilt;
		private var _model		: Model;
		
		public function TiltController(__view : Tilt)
		{
			_view	= __view;
			_model	= new Model(_view);
			
			_view.addEventListener(TiltEvent.BROWSE_FILE, _browseFile, false, 0, true);
		}
		
		private function _browseFile (e : TiltEvent) : void
		{
			_model.browse();
		}
	}
}