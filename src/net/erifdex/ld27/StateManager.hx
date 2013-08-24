package net.erifdex.ld27;

import ash.core.Engine;

class StateManager {

	public var engine : Engine;

	public function new(engine : Engine) {
		this.engine = engine;
	}

	private function prepare() : Void {
		engine.removeAllEntities();
		engine.removeAllSystems();
	}

	public function switchState(s : State) : Void {
		prepare();
		s.stateManager = this;
		s.engine = engine;
		s.prepareSystems();
		s.prepareEntities();
	}

}