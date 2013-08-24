package net.erifdex.ld27.scenes;

import com.haxepunk.Scene;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;
import net.erifdex.ld27.other.GFX;

class OverlayScene extends Scene {

	public var fadeScreen : Image;
	public var fade : Int;
	private var nextScene : Scene;

	public function new() {
		super();
		fade = 0;
	}

	public override function begin() : Void {
		var overlay = new Image(GFX.OVERLAY);
		addGraphic(overlay, 0);
		fadeScreen = Image.createRect(640, 480, 0x140c1c, 0);
		addGraphic(fadeScreen, 0);
		super.begin();
	}

	public override function update() : Void {
		fadeScreen.alpha += (fade - fadeScreen.alpha) * 0.1;
		if(this.nextScene != null) {
			if(fadeScreen.alpha > 0.95) {
				HXP.scene = nextScene;
			}
		}
		super.update();
	}

	public function fadeIn() : Void {
		fadeScreen.alpha = 1;
		fade = 0;
	}

	public function fadeOut(next : Scene) : Void {
		this.nextScene = next;
		fadeScreen.alpha = 0;
		fade = 1;
	}

}