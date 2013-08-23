package ;

import flash.display.Sprite;
import flash.events.Event;
import net.erifdex.ld27.Game;

class Main extends Sprite {
	
	public function new () {
		super();
		addEventListener(Event.ENTER_FRAME, onEnterFrame);
	}

	private function onEnterFrame(event : Event) : Void {
		removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		var game = new Game();
		addChild(game);
	}
	
}