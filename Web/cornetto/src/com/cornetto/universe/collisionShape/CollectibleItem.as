package com.cornetto.universe.collisionShape {
	import shapes.Box;

	import com.greensock.TweenMax;
	import com.robot.utils.Utils;

	import flash.display.MovieClip;

	/**
	 * @author robertocascavilla
	 */
	public class CollectibleItem extends Box 
	{
		public var mc : MovieClip ; 
		
		public var tileName : String ; 
		public var i : int ; 
		
		public function CollectibleItem() 
		{
			mouseChildren = false ;
			mouseEnabled = false ;
			
			isSensor = true ; 
		}
		public function kill() : void
		{
			TweenMax.to( mc , .3 , { y : mc.y -60 , onComplete : Utils.cleanDisplayObject , onCompleteParams : [ mc.parent ]} ) ; 
			TweenMax.to( mc , .2 , { alpha : 0 , delay : .1}  ) ; 
			destroy() ; 
		}
		
	}
}
