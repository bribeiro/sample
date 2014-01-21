package com.cornetto.universe.collisionShape.movingPlatform {
	import Box2DAS.Common.V2;

	import shapes.Box;

	import com.cornetto.main.GameVars;
	import com.cornetto.universe.tiles.Tile;
	import com.cornetto.universe.tiles.TileInfoVO;
	import com.greensock.TweenMax;
	import com.robot.geom.RBox;
	import com.robot.utils.Utils;

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * @author robertocascavilla
	 */
	public class BoxMovingPlatform 
	{
		private var gv : GameVars ; 
		public var initx : Number ; 
		public var inity : Number ; 
		public var endx : Number ; 
		public var endy : Number ; 
		public var totFrames : int ; 
		
		private var cont : Sprite  ; 
		public var box : BoxMovingDown  ; 
		
		private var speed : Number ; 
		public var initPos : V2 ; 
		private var _tweenInst : TweenMax ; 
		private var _state : int ; 
		public var direction : String ; 
		
		private var _diffX : int  ; 
		private var _diffY : int  ; 
		private var _rayX : int  ; 
		private var _rayY : int  ; 
		private var _tileName : String ;
		private var _tile : Tile ; 
		public function BoxMovingPlatform( tileName : String , tile : Tile )
		{
			_tileName = tileName ; 
			_tile = tile ; 
		}
		public function create( tileInfoVO : TileInfoVO , mcTile : MovieClip , state : int , currentProgress : Number) : void
		{
			gv = GameVars.me ; 
			cont = new Sprite() ; 
			cont.x = tileInfoVO.moveData.initx  + mcTile.physics_mc.x ;
			cont.y = tileInfoVO.moveData.inity  + mcTile.physics_mc.y ;
			
			initx = tileInfoVO.moveData.initx ;//+ mcTile.physics_mc.x; 
			inity = tileInfoVO.moveData.inity ;//+ mcTile.physics_mc.y; 
			
			endx = tileInfoVO.moveData.endx ;//+ mcTile.physics_mc.x; 
			endy = tileInfoVO.moveData.endy ;//+ mcTile.physics_mc.y; 
			totFrames = tileInfoVO.moveData.frames ;  //+ mcTile.physics_mc.y; 
			
			_diffX = endx - initx ; 
			if( Utils.abs( _diffX )  > 10 ) direction = 'horizontal' ; 
			else direction = 'vertical' ; 
			_rayX = _diffX >> 1 ;
			
			_diffY = endy - inity ; 
			_rayY = _diffY >> 1 ;
			
			var boxSolid : Box = new Box() ;
			boxSolid.friction = 0.5 ; //0.5 ; 
			boxSolid.restitution = 0 ;
			boxSolid.rotation = tileInfoVO.rot ;
			boxSolid.x = 0 ;//tileInfoVO.x  + mcTile.physics_mc.x ;
			boxSolid.y = 0 ; //tileInfoVO.y + mcTile.physics_mc.y ;
			
			boxSolid.type='Animated' ; 
			var mc : MovieClip = tileInfoVO.mc ; 
			boxSolid.friction = 0 ;  
			mc.x = 0 ;
			mc.y = 0 ;
			mc.rotation = 0 ;
			mcTile.addChild( cont ) ;
			cont.addChild( boxSolid ) ;  
			boxSolid.addChild( mc ) ;
			
			box = new BoxMovingDown() ;
			box.myCont = this ; 
			if( direction == 'horizontal') box.friction = 0.5 ; 
			else box.friction = 0.4 ; 
			 
			box.restitution = 0 ;
//
			box.rotation = tileInfoVO.rot ;
			box.x = 0 ;//tileInfoVO.x  + mcTile.physics_mc.x ;
			box.y = - boxSolid.height/2 + .5 ; //tileInfoVO.y + mcTile.physics_mc.y ;
			
			box.type='Animated' ; 
			
			var mc2 : RBox = new RBox( boxSolid.width , 10 , 0xff0099) ; 
			mcTile.addChild( cont ) ;
			
//			var bw2 : Number = box.width/2 ; 
//			var boxLeft : BoxPlatform = new BoxPlatform() ; 
//			boxLeft.isGround = true ; 
//			var bl : RBox = new RBox( 50 , box.height , 0xff0000 ) ; 
//			boxLeft.x = box.x + bw2 ; 
//			boxLeft.y = box.y ; 
//			boxLeft.friction = 0 ; 
//			boxLeft.addChild( bl ) ; 
//			bl.visible = false ;
//			
//			var boxRight : BoxPlatform = new BoxPlatform() ; 
//			boxRight.isGround = true ; 
//			var br : RBox = new RBox( 50 , box.height , 0xff0099 ) ; 
//			boxRight.x = box.x - bw2 ; 
//			boxRight.y = box.y ; 	
//			boxRight.friction = 0 ; 	
//			boxRight.addChild( br ) ; 
//			br.visible = false ; 
//			
//			
//			cont.addChild( boxLeft ) ;  
//			cont.addChild( boxRight ) ;  
			cont.addChild( box ) ;  
			box.addChild( mc2 ) ;
			mc2.visible = false; 
			
			speed  =  totFrames / 10 ;
			
			var pngMC : MovieClip = mcTile.movingMC ; 
			if( pngMC )
			{
				 mc.visible = false ; 
				 pngMC.x = -mc.width/2 ; 
				 pngMC.y = -mc.height/2 - 5 ; 
				 cont.addChild( pngMC ) ; 
			}

		 	box.addEventListener( Event.ENTER_FRAME , run ) ;
			
		}
		
		private function run( evt : Event ) : void
		{
			//trace('gv.mainCounter :' + gv.mainCounter )
			if( direction == 'horizontal')	
				cont.x = Math.cos( Utils.getRadians( gv.mainCounter ) )* _rayX + ( initx + _rayX )  ;
			else
			  	cont.y = Math.sin( Utils.getRadians( gv.mainCounter ) )* _rayY + ( inity + _rayY )  ; 
		}
		
		public function recordInitPos() : V2
		{
			
			if( direction == 'horizontal')
			{
				cont.x = Math.cos( Utils.getRadians( 0 ) ) * _rayX + ( initx + _rayX )  ;
			}
			else
			{
				cont.y = Math.sin( Utils.getRadians( 0 ) ) * _rayY + ( inity + _rayY )  ;
			}
			var transf_x : Number = (cont.x  ) / 60 + _tile.x / 60  ; 
			var transf_y : Number = (cont.y  ) / 60 + _tile.y / 60 -1 ; 
			var obj : V2 = new V2( transf_x , transf_y ) ;  
			
			return obj ;
		}

		
		public function kill() : void
		{
			gv = null ;
			box.removeEventListener( Event.ENTER_FRAME , run ) ; 
		}
	}
}
