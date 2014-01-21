package com.cornetto.universe.tiles {
	import com.cornetto.data.Config;
	import com.cornetto.data.Data;
	import com.cornetto.main.GameVars;

	import flash.display.Sprite;
	import flash.utils.Dictionary;
	/**
	 * @author robertocascavilla
	 */
	public class TileManager 
	{
		private var gv : GameVars ; 
		private var ptkTiles : Sprite ; 
		
		private var piNrColumns : int =  Config.NR_COLUMNS ; 
		private var piNrRow : int = Config.NR_ROWS ; 
		private var piTileWidth : int = 750 ; 
		private var piTileWidth_2 : int = 375 ; 
		private var piTileHeight : int = 500 ; 
		
		private var dictActiveTiles : Dictionary ; 
		public var dictTilesCreated : Dictionary ; 
		private var paActiveTiles : Array ; 
		//private var quad : RBox ; 
		
		public function TileManager()
		{
			
		}
		public function init() : void
		{
			dictActiveTiles  = new Dictionary() ; 
			dictTilesCreated  = new Dictionary() ; 
			paActiveTiles  = new Array() ; 
			
			gv = GameVars.me ; 
			ptkTiles = new Sprite() ; 
			gv.world.addChild( ptkTiles ) ; 

			piNrRow = Config.NR_ROWS * Data.totalRows;
		}
		
		private var psTileAddress : String ='';
		
		public function update() : void
		{
			
			var normWorldx : Number = -( gv.world.x - piTileWidth_2 ) ; 
			var normWorldy : Number = -( gv.world.y  - 250 ) ;
			
			var row : int = ( normWorldy  / piTileHeight) ;
			var column : int = ( normWorldx    / piTileWidth ) ;
			
			if( row < 0) row =0 ; 
			if( row >= piNrRow) row = piNrRow - 1 ; 
			if( column < 0 ) column = 0 ; 
			if( column >= piNrColumns) column = piNrColumns ;  
		//	if ( row >= 0 && row < piNrRow && column>=0 && column < piNrColumns )
		//	{
				var str : String = row.toString() + '_' + column.toString() ;
				
				if( str != psTileAddress)
				{
					switchTile( row , column ) ; 
					psTileAddress = str ; 
				}
		//	}
		}
		
		
		private function switchTile( row : int , column : int ) : void
		{
			var arrTilesStr : Array = new Array() ; 
			var i : int ; 
			var j : int ; 
			var dictNewTiles : Dictionary = new Dictionary() ; 
			var arrNewTiles : Array = new Array() ; 
			for( i = 0 ; i < 2 ; ++i )
			{
				var newRow : int = row + i ; 
				for( j = 0 ; j < 2 ; ++j )
				{
					var newColumn : int = column + j ; 
					var str : String = newRow.toString() + '_' + newColumn.toString() ; 
					arrTilesStr.push( str ) ;
					dictNewTiles[ str] = 'ciao' ; 
					if( !dictActiveTiles[ str ] )
					{
						if( newColumn < piNrColumns && newRow < piNrRow)
						{
							var tile : Tile = createTile( ( newRow ) , ( newColumn ) ) ; 
							arrNewTiles.push( tile ) ; 
						}
					}
					else
					{
						 dictActiveTiles[ str ].visible = true ; 
						 arrNewTiles.push( dictActiveTiles[ str ] ) ; 
					}
				}
			}
			
			for( i = 0 ; i < paActiveTiles.length ; ++i )
			{
				var tileActive : Tile = paActiveTiles[ i ] as Tile ; 
				if( !dictNewTiles[tileActive.name] && tileActive)
				{
					dictActiveTiles[ tileActive.name] = null ; 
					if(tileActive.hasOwnProperty("kill"))
						tileActive.kill() ; 
					
					if(tileActive.parent)
						tileActive.parent.removeChild( tileActive ) ; 

				}
				
			}
			paActiveTiles = arrNewTiles ; 
		}
		
		private function createTile(  row : int , column : int) : Tile
		{
			var str : String = row.toString() + '_' + column.toString() ; 
			var tile : Tile = new Tile() ; 
			tile.name = str ; 
			tile.row = row ; 
			tile.column = column ; 
			
			tile.y = int( row * piTileHeight - piTileHeight/2) ; 
			tile.x = int(column * piTileWidth - piTileWidth/2) ; 
			
			ptkTiles.addChild( tile ) ; 
			
			tile.create( row , column) ;
			dictActiveTiles[ str ] = tile ; 
			
			return tile ; 
		}
		public function restart() : void
		{
			var l : int = ptkTiles.numChildren ; 
			var i : int ; 
			for( i = 0 ; i < l ; ++i)
			{
				var tile : Tile = ptkTiles.getChildAt( 0 ) as Tile ;
				dictActiveTiles[ tile.name] = null ; 
				var row : int = tile.row ; 
				var column : int = tile.column ; 
					if(tile.hasOwnProperty("kill"))
						tile.kill() ; 
					
					if(tile.parent)
						tile.parent.removeChild( tile ) ; 
						
				switchTile( row , column ) ; 
//tile.updateCones() ; 
			}
			//dictTilesCreated  = new Dictionary() ;
		}
		
	}
}
