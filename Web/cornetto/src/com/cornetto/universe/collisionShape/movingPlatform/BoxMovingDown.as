package com.cornetto.universe.collisionShape.movingPlatform {
	import Box2DAS.Common.V2;

	import shapes.Box;


	/**
	 * @author robertocascavilla
	 */
	 
	//**Bottom of moving platform
	public class BoxMovingDown extends Box 
	{
		public var myCont : BoxMovingPlatform ; 
		public var initPos : V2 ; 
		
		public function BoxMovingDown() {
		}
	}
}
