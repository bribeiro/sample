package net.brunoribeiro.tilt
{
	import com.zehfernando.utils.MathUtils;
	
	import flash.display.Bitmap;
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.filters.BlurFilter;
	import flash.display.StageScaleMode;
	
	import com.greensock.TweenMax;
	
	import net.brunoribeiro.tilt.controller.TiltController;
	import net.brunoribeiro.tilt.event.TiltEvent;
	import net.brunoribeiro.tilt.model.TiltImage;
	import net.brunoribeiro.utils.BitmapUtils;
	
	public class Tilt extends Sprite
	{
		private static const IMAGECHANGER : Object = { brightness:.8,  saturation:1.1, contrast:1.4};
		
		private var _controller		: TiltController;
		private var _container		: Sprite;
		private var _maskContainer	: Sprite;
		private var _overImage		: Sprite;
		
		private var _lowLimit		: Number;
		private var _highLimit		: Number;
		private var _scale			: Number;
		
		public function Tilt()
		{
			super();
		
			_controller		= new TiltController(this);
			
			_lowLimit		= bar.y;
			_highLimit		= bar.y + bar.height;
			_scale			= bar.height - bar.y;
			
			_initUI();
		}
		
		private function _initUI() : void
		{
			
			stage.scaleMode	= StageScaleMode.NO_SCALE;
			
			bar.visible 	= false;
			btTop.visible	= false;
			btDown.visible	= false;
			
			addChild(_overImage 	= new Sprite);
			addChild(_container 	= new Sprite);
			addChild(_maskContainer = new Sprite);
			
			_overImage.y 			=
			_container.y			=
			_maskContainer.y		= 21.7;
			
			//Search for file to upload
			btBrowse.addEventListener(MouseEvent.CLICK, _browseFile, false, 0, true);
			
			//Top slider drag
			btTop.addEventListener(MouseEvent.MOUSE_DOWN, _topStartDrag, false, 0, true);
			btTop.addEventListener(MouseEvent.MOUSE_UP, _topStopDrag, false, 0, true);
			
			//Down slider drag
			btDown.addEventListener(MouseEvent.MOUSE_DOWN, _downStartDrag, false, 0, true);
			btDown.addEventListener(MouseEvent.MOUSE_UP, _downStopDrag, false, 0, true);
		
			//Release outside
			stage.addEventListener(MouseEvent.MOUSE_UP, _releaseDrags, false, 0, true);
		}
		
		//browse file to upload
		private function _browseFile (e: Event) : void
		{
			dispatchEvent(new TiltEvent(TiltEvent.BROWSE_FILE));
		}
		
		//Update image
		public function showImage () : void
		{
			_container.addChild(  BitmapUtils.smoothBitmap(TiltImage.getInstance().image) );
			_overImage.addChild(  BitmapUtils.smoothBitmap(TiltImage.getInstance().image) );
			
			BitmapUtils.resize(_container, 615, 410);
			BitmapUtils.resize(_overImage, 615, 410);
			
			bar.visible 	= true;
			btTop.visible	= true;
			btDown.visible	= true;
		
			_updateGradient(null);
			
			_container.cacheAsBitmap		= true;
			_overImage.cacheAsBitmap		= true;
			_maskContainer.cacheAsBitmap	= true;
			_container.mask					= _maskContainer;
			
			_container.x 					=
			_overImage.x 					= ( 615 - _overImage.width  ) * .5;
			
			//add Filter
			var aFilter: Array 			= [new BlurFilter(15, 1, 3)];
			_overImage.filters			= aFilter;
			
			TweenMax.to(_overImage, 0, { colorMatrixFilter: IMAGECHANGER } );	
		}
		
		/**
		 * Listeners to drags
		 */ 
		
		private function _topStartDrag (e:MouseEvent) : void
		{
			var rect : Rectangle = new Rectangle(btTop.x, _lowLimit, 0, _scale - (_scale - btDown.y) - btDown.height);
			btTop.startDrag(false, rect);
			if(!hasEventListener(Event.ENTER_FRAME))
				addEventListener(Event.ENTER_FRAME, _updateGradient, false, 0, true);
		}
		
		private function _topStopDrag (e:MouseEvent) : void
		{
			btTop.stopDrag();
			if(hasEventListener(Event.ENTER_FRAME))
				removeEventListener(Event.ENTER_FRAME, _updateGradient, false);
		}
		
		private function _downStartDrag (e:MouseEvent) : void
		{
			var rect : Rectangle = new Rectangle(btDown.x, btTop.y + btTop.height, 0, _scale - btTop.y);
			btDown.startDrag(false, rect);
			if(!hasEventListener(Event.ENTER_FRAME))
				addEventListener(Event.ENTER_FRAME, _updateGradient, false, 0, true);
		}
		
		private function _downStopDrag (e:MouseEvent) : void
		{
			btDown.stopDrag();
			if(hasEventListener(Event.ENTER_FRAME))
				removeEventListener(Event.ENTER_FRAME, _updateGradient, false);
		}
		
		private function _releaseDrags (e : MouseEvent) : void
		{
			btDown.stopDrag();
			btTop.stopDrag();
			
			if(hasEventListener(Event.ENTER_FRAME))
				removeEventListener(Event.ENTER_FRAME, _updateGradient, false);
		}
		
		//Redraw gradient
		private function _updateGradient (e : Event) : void
		{
			var beginGradient	: Number = com.zehfernando.utils.MathUtils.map(btTop.y, _lowLimit, _highLimit, 0,255, true);
			var endGradient		: Number = com.zehfernando.utils.MathUtils.map(btDown.y + 10, _lowLimit, _highLimit, 0,255, true);
			var matrix			: Matrix = new Matrix();
			matrix.createGradientBox(615,410,Math.PI/2);
			
			var g : Graphics = _maskContainer.graphics;
			g.clear();
			g.beginGradientFill(GradientType.LINEAR, [0xffffff, 0x000000, 0x000000, 0xffffff], [0,1,1,0], [0, beginGradient + 5, endGradient -5,255], matrix);
			g.drawRect(0,0,615,410);
			g.endFill();
		}
	}
}