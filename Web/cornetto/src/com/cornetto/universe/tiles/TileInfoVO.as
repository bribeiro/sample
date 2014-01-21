package com.cornetto.universe.tiles {
	import Box2DAS.Common.V2;

	import flash.display.MovieClip;
	/**
	 * @author Robot
	 */
	public class TileInfoVO 
	{
		public var x : Number ; 
		public var y : Number ; 
		public var rot : Number = 0 ; 
		public var width : Number ; 
		public var height : Number ; 
		public var type : String ;  
		public var zindex : int ;
		public var activated : Boolean ;
		public var mc : MovieClip ;   
		public var points : Vector.<V2> ;   
		public var curvesVO : Vector.<TileCurveVO> ;   
		public var moveData : TileMoveDataVO ; 
		
	}
}
