package com.cornetto.universe.collisionShape {
	import Box2DAS.Common.V2;

	import shapes.Box;

	import com.cornetto.universe.physics.EdgeChain;
	import com.cornetto.universe.tiles.TileCurveVO;
	import com.robot.geom.RBox;

	import flash.display.Sprite;

	/**
	 * @author robertocascavilla
	 */
	public class Curve extends EdgeChain 
	{
		public var direction : int ;
		public function Curve(vertices : Vector.<V2> , curvesVO : Vector.<TileCurveVO> ) 
		{
			mouseChildren = false ;
			mouseEnabled = false ;
			
			var tempSprite : Sprite = new Sprite() ; 
			addChild( tempSprite ) ; 
			
			var i : int ; 
			var l : int = curvesVO.length ; 
			for( i  = 0 ; i < l ; i++ )
			{
				var tileCurveVO : TileCurveVO = curvesVO[ i ] as TileCurveVO ; 
				var b : Box = new Box() ; 
      		 	var rb : RBox = new RBox( tileCurveVO.d , 50 , 0x000000 );
      		 	rb.x = -rb.width/2 ;
      		 	rb.y = -rb.height/2 ; 
      			b.addChild( rb ) ; 
	      		b.x = tileCurveVO.x  ; 
	      		b.y = tileCurveVO.y ;  
      			rb.visible= false ; 
      		 	b.rotation = tileCurveVO.rotation ; 
      		 	addChild( b ) ; 
			}
			
			super(vertices);
		}
	}
}
