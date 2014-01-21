package com.cornetto.universe.collisionShape {
	import shapes.Box;

	import com.greensock.TweenMax;

	import flash.display.MovieClip;

	/**
	 * @author robertocascavilla
	 */
	public class BoxCheckPoint extends Box 
	{
		public var tileName : String ; 
		public var i : int ; 
		public var mc : MovieClip ; 
		
		public function BoxCheckPoint() 
		{
			mouseChildren = false ;
			mouseEnabled = false ;
			
			isSensor = true ; 
		}
		public function kill() : void
		{
		//	mc.gotoAndPlay( 1 ) ; 
			TweenMax.to( mc , 2.6 , { frame : 40 } ) ; 
			destroy() ; 
		}
	}
}
