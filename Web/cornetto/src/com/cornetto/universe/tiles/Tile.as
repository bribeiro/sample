package com.cornetto.universe.tiles {
	import Box2DAS.Common.V2;

	import com.cornetto.data.Config;
	import com.cornetto.data.Data;
	import com.cornetto.main.GameVars;
	import com.cornetto.universe.collisionShape.BoxBadItem;
	import com.cornetto.universe.collisionShape.BoxCheckPoint;
	import com.cornetto.universe.collisionShape.BoxForceElement;
	import com.cornetto.universe.collisionShape.BoxPlatform;
	import com.cornetto.universe.collisionShape.BoxWall;
	import com.cornetto.universe.collisionShape.CollectibleItem;
	import com.cornetto.universe.collisionShape.Curve;
	import com.cornetto.universe.collisionShape.movingPlatform.BoxMovingPlatform;
	import com.robot.geom.RBox;
	import com.robot.utils.Utils;

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.text.TextField;



	/**
	 * @author Robot
	 */
	public class Tile extends Sprite 
	{
		private var gv : GameVars ; 
		private var mcTile : MovieClip ; 
		private var _movingPlatform : BoxMovingPlatform ; 
		
		public var lastState : int ; 
		public var lastCurrentProgress : Number ; 
		private var _state : Number ; 
		private var _currentProgress : Number ; 
		private var tileName : String ; 
		private var w_tile : Tile ; 
		
		public var row : int ; 
		public var column : int ; 
		
		public function Tile() 
		{
			
		}
		public function create( row : int , column : int ) : void
		{	
			//trace('row : ' + row , ' column :' + column)
			gv = GameVars.me ; 
			//var str : String = row.toString() + '_' + column.toString() ;
			// using the address to figure out which is the right tile to show
			//var str:String = Data.dictAddress["Tile"+row.toString() + '_' + column.toString()].split("Tile").join("") 
			var str:String = Data.dictAddress["row"+ row] + '_' + column.toString();
			tileName = str ; 
			w_tile = this ; 
			var tileifCreated : Tile = gv.tileManager.dictTilesCreated[ str ] ; 
			if( tileifCreated )
			{
				_state = tileifCreated.lastState ;
				_currentProgress = tileifCreated.lastCurrentProgress ; 
			}
			
			gv.tileManager.dictTilesCreated[ str ] = this ; 
			
			var tilePosition : Number = Number(str.slice(0, str.indexOf("_"))) ;
			var iter : Number = Math.floor(tilePosition / Config.NR_ROWS);
			if(isNaN(iter))
				return;
			
			mcTile = Data.getTile("Tile"+ str , iter ) as MovieClip;
			mcTile.name = str ; 

			createTilePhysics( ) ; 

			var physics_mc : Sprite = mcTile.physics_mc ; 
			
			if( physics_mc ) mcTile.removeChild( physics_mc ) ; 

			addChild( mcTile ) ;

			if( Config.DEBUG_ON)
			{
				var txt : TextField = new TextField()   ;
				txt.scaleX = txt.scaleY = 2 ; 
				txt.text = str ; 
				mcTile.addChild( txt ) ;
				
			}
			mcTile.boundsMC.visible = false ; 
		//	mcTile.boundsMC.alpha= .4 ; 
		}
		
		public function updateCones() : void
		{
			var arrPhysicsObject : Array = Data.dictTiles['Tile' + mcTile.name ] ;
			
			var i : int ; 
			var tileInfoVO : TileInfoVO ; 
			
			var l : int = arrPhysicsObject.length ; 
			var physics_mc : Sprite = mcTile.physics_mc ; 
			if( physics_mc)
			{
				for( i = 0 ; i < l ; i++ )
				{
					if( arrPhysicsObject[ i ] )
					{
						tileInfoVO = arrPhysicsObject[ i ] ;
						switch( tileInfoVO.type )
						{
							case 'CollectibleItem':
								createCollectibleItem( tileInfoVO , mcTile.name , i) ; 
							break ;
						}
						
					}
				}
			}
		}
		private function createTilePhysics(  ) : void
		{
			var arrPhysicsObject : Array = Data.dictTiles['Tile' + mcTile.name ] ; 
			
			var i : int ; 
			var tileInfoVO : TileInfoVO ; 
			
			var l : int = arrPhysicsObject.length ; 
			var physics_mc : Sprite = mcTile.physics_mc ; 
			if( physics_mc)
			{
				for( i = 0 ; i < l ; i++ )
				{
					if( arrPhysicsObject[ i ] )
					{
						tileInfoVO = arrPhysicsObject[ i ] ;
						switch( tileInfoVO.type )
						{
							case 'BoxPlatform' : 
								createBoxPlatform( tileInfoVO   ) ; 
							break ; 
							case 'BoxWall' :
								createBoxWall( tileInfoVO ) ; 
							break ; 
							case 'CurvedElement' :
								createCurve( tileInfoVO ) ; 
							break ; 
							
							case 'MovingElement' : 
								createMovingObject( tileInfoVO ) ; 
							break ;
							case 'ForceElement' : 
								createForceElement( tileInfoVO ) ; 
							break ;
							case 'BadItem' : 
								createBadItem( tileInfoVO ) ; 
							break ;  
							case 'CheckpointElement' : 
								createCheckpointElement( tileInfoVO , mcTile.name , i ) ; 
							break ; 
							case 'BoxFloor' : 
								createBoxPlatform( tileInfoVO ) ; 
							break ;  
							case 'CollectibleItem':
								createCollectibleItem( tileInfoVO , mcTile.name , i) ; 
							break ;
						}
						
					}
				}
			}
		}
		
		private function createCollectibleItem( tileInfoVO : TileInfoVO , tileName : String , i : int  ) : void
		{
			var box : CollectibleItem = new CollectibleItem() ;
			box.tileName = tileName ; 
			box.i = i ; 
			
			//box.friction = 0.5 ; 
			box.restitution = 0 ;

			box.rotation = tileInfoVO.rot ;
			box.x = tileInfoVO.x  + mcTile.physics_mc.x ; 
			box.y = tileInfoVO.y + mcTile.physics_mc.y  ;
			box.tweened = false ;
			
			var mc : MovieClip = tileInfoVO.mc ; 
			mc.scaleY = 1.8 ;
			mc.x = 0 ;
			mc.y = 0;
			mc.rotation = 0 ;
			
			mcTile.addChild( box ) ; 
			box.addChild( mc ) ;
			box.isGround = true ;
			 
			
			mc.visible = false ;
			
			var mcCone : MovieClip  = Data.getDisplayObject('ConeMC') as MovieClip ; 
			box.addChild( mcCone ) ; 
			mcCone.x = - (mc.width >> 1 ) + 5 ; 
			mcCone.y = - (mc.height >> 1 ) + 5 ; 
			box.mc = mcCone ;
		}
		private function createCheckpointElement( tileInfoVO : TileInfoVO , tileName : String , i : int) : void
		{
			var mcAnim : MovieClip ; 
		//	trace('tileInfoVO.activated :' + tileInfoVO.activated)
			if( !tileInfoVO.activated ) 
			{
				var box : BoxCheckPoint = new BoxCheckPoint() ;
			
				box.tileName = tileName ; 
				box.i = i ; 
				
				
				//box.friction = 0.5 ; 
				box.restitution = 0 ;
	
				box.rotation = tileInfoVO.rot ;
				box.x = tileInfoVO.x  + mcTile.physics_mc.x + 5 ;
				box.y = tileInfoVO.y + mcTile.physics_mc.y + 20 ;
				box.tweened = false ;
				
				var mc : MovieClip = tileInfoVO.mc ; 
				mc.scaleY = .5 ; //**reduce size checkpoint touchable area
				mc.x = 0 ;
				mc.y = 0 ;
				mc.rotation = 0 ;
				
				mcTile.addChild( box ) ; 
				box.addChild( mc ) ;
				box.isGround = true ;
				
				
				//mc.rotation = 180 ;
				mc.visible = false ; 
				
				mcAnim = Data.getDisplayObject('checkpoint_anim') as MovieClip ; 
				box.mc = mcAnim ; 
				
				mcTile.addChild( mcAnim ) ;
				mcAnim.gotoAndStop( 1 ) ; 
				mcAnim.x = tileInfoVO.x  + mcTile.physics_mc.x  + 198;
				mcAnim.y = tileInfoVO.y + mcTile.physics_mc.y - 129 ;
				
			}
			else
			{
				mcAnim = Data.getDisplayObject('checkpoint_anim') as MovieClip ; 
				mcTile.addChild( mcAnim ) ;
				mcAnim.gotoAndStop( mcAnim.totalFrames)
				mcAnim.x = tileInfoVO.x  + mcTile.physics_mc.x +198;
				mcAnim.y = tileInfoVO.y + mcTile.physics_mc.y -129;
				//mcAnim.gotoAndStop( mcAnim.totalFrames ) ; 
			}
		}
		private function createBadItem( tileInfoVO : TileInfoVO ) : void
		{
			var box : BoxBadItem = new BoxBadItem() ;

			//box.friction = 0.5 ; 
			//box.restitution = 0 ;

			box.rotation = tileInfoVO.rot ;
			box.x = tileInfoVO.x  + mcTile.physics_mc.x ;
			box.y = tileInfoVO.y + mcTile.physics_mc.y ;
			box.tweened = false ;
			
			var mc : MovieClip = tileInfoVO.mc ; 
			
			mc.x = 0 ;
			mc.y = 0 ;
			mc.rotation = 0 ;
			
			mcTile.addChild( box ) ; 
			box.addChild( mc ) ;
			box.isGround = true ;
			
			//mc.visible = false ; 
			if( !Config.DEBUG_ON )mc.visible = false ; 
		}
		
		
		private function createForceElement( tileInfoVO : TileInfoVO ) : void
		{
			var box : BoxForceElement = new BoxForceElement() ;

			box.rotation = tileInfoVO.rot ;
			
			
			box.tweened = false ; 
			
			var mc : MovieClip = tileInfoVO.mc ; 
			
			
			mc.x = 0 ;
			mc.y = 0 ;
			mc.rotation = 0 ;
			
			box.x = tileInfoVO.x  + mcTile.physics_mc.x ;
			box.y = tileInfoVO.y + mcTile.physics_mc.y  - 10 *mc.scaleY; //- mc.height/4;
			
			
			//box.magnitude = mc.text.text ; 
			var radAngle : Number = Utils.getRadians( tileInfoVO.rot ) ; 
			var verse : int ; 
			var rot : Number  = int( Math.cos( Utils.getRadians( tileInfoVO.rot ) ) ) ; 
			if( rot == 0) verse = ( tileInfoVO.rot / Math.abs( tileInfoVO.rot ) ) ; 
			
			var value : Number = mc.force.text / 10 ; 
			box.magnitude = new V2( Math.sin( radAngle ) * Number( value ), -Math.cos( radAngle ) * Number( value ) )  ; 
			
			box.addChild( mc ) ;
			mcTile.addChild( box ) ; 
			
			if( !Config.DEBUG_ON ) mc.visible = false ; 
		}
		
		private function createMovingObject( tileInfoVO : TileInfoVO ) : void
		{
			if( tileInfoVO.moveData.initx == tileInfoVO.moveData.endx 
				&& tileInfoVO.moveData.inity == tileInfoVO.moveData.endy
			)
			{
				createDynamicPlatform( tileInfoVO ) ; 
			}
			else
			{
				_movingPlatform = new BoxMovingPlatform( tileName , w_tile ) ; 
				_movingPlatform.create( tileInfoVO , mcTile , _state , _currentProgress) ; 
			} 
		}
		
		private function createDynamicPlatform( tileInfoVO : TileInfoVO ) : void
		{
			var pngMC : MovieClip = mcTile.dynamicMC ; 
			if( pngMC) pngMC.visible = false ; 
			
			if( Data.dictDynamicTile[tileName ] )
			{
				var box : BoxPlatform = new BoxPlatform() ;

				box.friction =  0.5 ; //0.5 ; 
				box.restitution = 0 ;

				box.tweened = false ;
			
				var mc : MovieClip = tileInfoVO.mc ; 
			
				mc.x = 0 ;
				mc.y = 0 ;
				mc.rotation = 0 ;
				
				box.addChild( mc ) ;
				box.isGround = true ;
			
				mc.visible = false ; 
			

				var bw2 : Number = box.width/2 ; 
				var boxLeft : BoxPlatform = new BoxPlatform() ; 
				boxLeft.isGround = true ; 
				var bl : RBox = new RBox( 5 , box.height , 0xff0000 ) ; 
				boxLeft.x = box.x + bw2 ; 
				boxLeft.y = box.y ; 
				boxLeft.friction = 0 ; 
				boxLeft.addChild( bl ) ; 
				bl.visible = false ;
			
				var boxRight : BoxPlatform = new BoxPlatform() ; 
				boxRight.isGround = true ; 
				var br : RBox = new RBox( 5 , box.height , 0xff0099 ) ; 
				boxRight.x = box.x - bw2 ; 
				boxRight.y = box.y ; 	
				boxRight.friction = 0 ; 	
				boxRight.addChild( br ) ; 
				br.visible = false ; 

			 
			 
				 var tkPlatform : Sprite = new Sprite() ; 
				 
				 tkPlatform.addChild( box) ; 
				 tkPlatform.addChild( boxLeft ) ; 
				 tkPlatform.addChild( boxRight) ; 
				 
				 mcTile.addChild( tkPlatform ) ; 
			 
				 tkPlatform.rotation = tileInfoVO.rot ;
				 tkPlatform.x = tileInfoVO.moveData.initx  + mcTile.physics_mc.x ;
				 tkPlatform.y = tileInfoVO.moveData.inity + mcTile.physics_mc.y ;
			 
				if( pngMC )
				{
					 mc.visible = false ; 
					 pngMC.x = -mc.width/2 ; 
					 pngMC.y = -mc.height/2 - 5 ; 
					 tkPlatform.addChild( pngMC ) ; 
					 pngMC.visible = true ; 
				}
			}
			
			
		}
		
		private function createBoxPlatform( tileInfoVO : TileInfoVO ) : void
		{
			var box : BoxPlatform = new BoxPlatform() ;

			box.friction =  0.5 ; //0.5 ; 
			box.restitution = 0 ;

			box.tweened = false ;
			
			var mc : MovieClip = tileInfoVO.mc ; 
			
			mc.x = 0 ;
			mc.y = 0 ;
			mc.rotation = 0 ;
			
			//mcTile.addChild( box ) ; 
			box.addChild( mc ) ;
			box.isGround = true ;
			
			mc.visible = false ; 
			
			Utils.setRGB( mc ,  0x666666 ) ; 

			var bw2 : Number = box.width/2 ; 
			var boxLeft : BoxPlatform = new BoxPlatform() ; 
			boxLeft.isGround = true ; 
			var bl : RBox = new RBox( 5 , box.height , 0xff0000 ) ; 
			boxLeft.x = box.x + bw2 ; 
			boxLeft.y = box.y ; 
			boxLeft.friction = 0 ; 
			boxLeft.addChild( bl ) ; 
			bl.visible = false ;
			
			var boxRight : BoxPlatform = new BoxPlatform() ; 
			boxRight.isGround = true ; 
			var br : RBox = new RBox( 5 , box.height , 0xff0099 ) ; 
			boxRight.x = box.x - bw2 ; 
			boxRight.y = box.y ; 	
			boxRight.friction = 0 ; 	
			boxRight.addChild( br ) ; 
			br.visible = false ; 

			 
			 
			 var tkPlatform : Sprite = new Sprite() ; 
			 
			 tkPlatform.addChild( box) ; 
			 tkPlatform.addChild( boxLeft ) ; 
			 tkPlatform.addChild( boxRight) ; 
			 
			 mcTile.addChild( tkPlatform ) ; 
			 
			 tkPlatform.rotation = tileInfoVO.rot ;
			 tkPlatform.x = tileInfoVO.x  + mcTile.physics_mc.x ;
			 tkPlatform.y = tileInfoVO.y + mcTile.physics_mc.y ;
			 
			 if( tkPlatform.rotation != 0 && !isNaN( tkPlatform.rotation) )
			 {
			 	 box.friction = 0 ; 
			 }
			

		}
		private function createBoxWall( tileInfoVO : TileInfoVO ) : void
		{
			var box : BoxWall = new BoxWall() ;

			box.friction = 1.5 ; 
			box.restitution = 0 ;

			box.rotation = tileInfoVO.rot ;
			box.x = tileInfoVO.x  + mcTile.physics_mc.x ;
			box.y = tileInfoVO.y + mcTile.physics_mc.y ;
			box.tweened = false ;
			var mc : MovieClip = tileInfoVO.mc ; 
			mc.x = 0 ;
			mc.y = 0 ;
			mc.rotation = 0 ;
			
			box.addChild(mc) ;
			
			mcTile.addChild( box ) ; 
			box.isGround = true ;
			
			mc.visible = false ;
		}
		
		

		
		
		private function createCurve( tileInfoVO : TileInfoVO ) : void
		{
			
			var tempArr : Vector.<V2> = new Vector.<V2>() ;
			var tempCurveVO : Vector.<TileCurveVO> = new Vector.<TileCurveVO>() ; 
			var l : int = tileInfoVO.points.length  ; 
			for( var i : int = 0 ; i < l; i++ )
			{
				var v2 : V2 = tileInfoVO.points[ i ] as V2 ; 
				tempArr.push( v2 ) ; 
				
				if( i < l-1)
				{
					var tileCurveVO : TileCurveVO = tileInfoVO.curvesVO[ i ] as TileCurveVO ; 
					tempCurveVO.push( tileCurveVO ) ; 	
				}
			}
			 
			var curve:Curve = new Curve( tempArr ,  tempCurveVO );
			curve.friction = 0.1 ; 
			mcTile.addChild(curve);
			curve.type = 'Static' ;
		}
	
		
		public function kill() : void
		{
			if(mcTile)
			{
				if( _movingPlatform ) 
				{
					_movingPlatform.kill() ; 
					_movingPlatform = null ;	
					
				}
				
//				 
				while(mcTile.numChildren > 0)
				{
					if (mcTile.getChildAt( 0 ).parent) mcTile.getChildAt( 0 ).parent.removeChild(mcTile.getChildAt( 0 ));
				}
			}
			
		}
	}
}