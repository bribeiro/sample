package com.cornetto.data 
{
	import com.cornetto.VO.LoaderVO;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.SWFLoader;
	import com.greensock.loading.XMLLoader;
	import com.robot.flags.RobotFlags;
	import com.robot.xml.SimpleXMLLoader;

	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
  //import com.greensock.loading.XMLLoader;

	/**
	 * @author robot
	 */
	public class LoaderAssets extends EventDispatcher
	{
		private var xmlLoader : SimpleXMLLoader ;
		private var piter : int;
		
		private var tilesXML : XML;
		private var arrSwf  	: Array = new Array();
		private var configXML	 : XML;
		
		private var loaderXML : LoaderMax;
		private var loaderSWF : LoaderMax;
		private var _loadedTiles: int;
		
		public function LoaderAssets(){}
		
		public function init(t: int = 0) : void
		{
			//Data.appDomains = new Array();
			_loadedTiles = t;
			loadXml() ;
		}
		private function loadXml() : void
		{
			// If we are loading from the shell, just tells to parse tiles
			// and dispatch the event telling that we can start the game
			if(LoaderMax.getContent("AssetsLib"))
			{
				Data.parseTiles();	
				dispatchEvent( new Event( Flags.LOAD_COMPLETE ) ) ; 
			}
			else
			{
				// otherwise, let's start to load the assets
				xmlLoader = new SimpleXMLLoader (Config.XML_ADDRESS );
				xmlLoader.addEventListener(RobotFlags.XML_DATA_RESULTS, onXmlLoaded);
			}
		}
				
		private function onXmlLoaded( evt : Event ) : void
		{
			evt.target.removeEventListener(RobotFlags.XML_DATA_RESULTS, onXmlLoaded);
			configXML = new XML(evt["param"]);
			
      		xmlLoader = new SimpleXMLLoader (Config.XML_MAP );
			xmlLoader.addEventListener(RobotFlags.XML_DATA_RESULTS, onLoadMaps);
		}
		
		public function onLoadMaps(evt : Event):void
		{
			Data.mapRows = new XML(evt["param"]);
			loadAssets(); 
		}
		
		/******************* LOAD GAME ASSETS **********************/
		private function loadAssets() : void
		{
			var loaderObj_library:LoaderVO = new LoaderVO();
			loaderObj_library.address = Config.ASSETS_ADDRESS ; 
			loaderObj_library.callBack = onAssetsLoaded;
      		//loaderObj_library.progressHandler = progressHandler;
			load( loaderObj_library );
		}
		
		
		private function onAssetsLoaded( evt : Event ) : void
		{
			var loaderInfo : LoaderInfo = evt.target as LoaderInfo ;
			Data.mainLibraryAppDomain = loaderInfo.applicationDomain ;
			Data.appDomains = new Array();
			
			// define the xml loader
      		loaderXML = new LoaderMax({name:"xmlLoader",onChildComplete:xmlChildComplete, onProgress:xmlLoaderProgress, onComplete:xmlLoaderComplete, onError:xmlErrorHandler});			
 			loaderXML.maxConnections = 1;

 			// swf loader
 		  	loaderSWF = new LoaderMax({name:"swfLoader",onChildComplete:swfChildComplete, onProgress:swfLoaderProgress, onComplete:swfLoaderComplete, onError:swfErrorHandler});			
 			loaderSWF.maxConnections = 1;

 			// Get all the swf that we need to loa
 			for (var i:int = 0; i < configXML..tile.length(); i++)
 			{
 			  // append the swf list to the array
 			 	arrSwf.push('assets/swf/' + configXML..tile[i] + ".swf");

 			 	//append the swf file to the loader
 			 	loaderSWF.append(new SWFLoader('assets/swf/' + configXML..tile[i] + ".swf", {name:"SWFTile"+i, autoPlay:false}) );

 			 	// append the loader to the xml definition of the tile
         		loaderXML.append( new XMLLoader("assets/xml/"+configXML..tile[i] +".xml", {name:"XMLTile"+i}) );
 			}

       		loaderXML.load();
		}
		
		/********************* XML HANDLERS ****************************/
		public function xmlChildComplete(e : LoaderEvent):void
		{
		  if(! tilesXML)
		  {
		    tilesXML = new XML(LoaderMax.getContent(e.target.name));
		  }
		  else
		  {
		    tilesXML..elements += (LoaderMax.getContent(e.target.name)..tile)
		  }
		}
		
		public function xmlErrorHandler( e : LoaderEvent ):void
		{
		  // on error
		}
		
		public function xmlLoaderProgress( e : LoaderEvent ):void
		{
		  // progress
		}
		
		public function xmlLoaderComplete( e : LoaderEvent ):void
		{
		   	
		   Data.addMenu(tilesXML);
      	   loaderSWF.load();
		  // loaderXML.dispose(true);
		}

		/********************* SWF HANDLERS ****************************/
		public function swfChildComplete(e : LoaderEvent):void
		{
			Data.tileLibraryAppDomain = (LoaderMax.getContent(e.target.name).rawContent as MovieClip).loaderInfo.applicationDomain;
   			Data.appDomains.push((LoaderMax.getContent(e.target.name).rawContent as MovieClip).loaderInfo.applicationDomain);
		}
		
		public function swfErrorHandler( e : LoaderEvent ):void
		{
		  // on error
		}
		
		public function swfLoaderProgress( e : LoaderEvent ):void
		{
		  // on progress
		}
		
		public function swfLoaderComplete( e : LoaderEvent ):void
		{
        	//var mc : DisplayObject = Data.getTile( 'Tile10_3', 0 ) as DisplayObject ; 
      		Data.parseTiles();
			dispatchEvent( new Event( Flags.LOAD_COMPLETE ) ) ; 


			// if I dispose it, the access becames slower
			loaderSWF.dispose(true);
			loaderXML.dispose(true);


			loaderXML = null;
			loaderSWF = null;				
		}
		
		/**
		 * general loading
		 */
		public function load(loadObj: LoaderVO ):void
		{
			var loader : Loader = new Loader ( ) ;
			var request : URLRequest = new URLRequest ( loadObj.address ) ;
			loader.contentLoaderInfo.addEventListener ( Event.COMPLETE , loadObj.callBack ) ;
			if(loadObj.progressHandler!=null)
			{
				loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS , loadObj.progressHandler);
			}	
			loader.contentLoaderInfo.addEventListener ( IOErrorEvent.IO_ERROR , onLoadError ) ;
			loader.load ( request ) ;
		}
		
		private function onLoadError(evt:Event):void
		{
		}
		


	}
}