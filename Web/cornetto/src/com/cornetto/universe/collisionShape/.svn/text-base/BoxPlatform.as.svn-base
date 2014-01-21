package com.cornetto.universe.collisionShape {
	import shapes.Box;

	import flash.events.Event;

	/**
	 * @author Robot
	 */
	public class BoxPlatform extends Box 
	{
		public var anchorx : Number ; 
		public var anchory : Number ; 
		
		public function BoxPlatform() {
			mouseChildren = false ;
			mouseEnabled = false ;
			
			addEventListener( Event.ADDED_TO_STAGE , added ) ; 
		}
		private function added(event : Event) : void 
		{
			anchorx = parent.parent.x ; 
			anchory = parent.parent.y ; 
			removeEventListener( Event.ADDED_TO_STAGE , added ) ; 
		}
	}
}
