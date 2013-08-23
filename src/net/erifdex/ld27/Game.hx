package net.erifdex.ld27;

import flash.display.Sprite;
import flash.events.Event;
import ash.core.Engine;
import ash.tick.FrameTickProvider;

class Game extends Sprite {

	public var engine 		: Engine;
	public var factory 		: EntityFactory;
	public var tickProvider	: FrameTickProvider;

	public function new() {
		super();
		addEventListener(Event.ADDED_TO_STAGE, onAdded);
	}

	private function onAdded(e : Event) : Void {
		removeEventListener(Event.ADDED_TO_STAGE, onAdded);
		prepare();
		begin();
	}

	public function prepare() : Void {
		engine = new Engine();
		factory = new EntityFactory(engine);

		// add systems
	}

	public function begin() : Void {
		tickProvider = new FrameTickProvider(this);
		tickProvider.add(engine.update);
		tickProvider.start();
	}

}