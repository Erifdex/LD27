
package net.erifdex.ld27.scenes;

import com.haxepunk.Scene;
import com.haxepunk.HXP;
import com.haxepunk.utils.Draw;
import com.haxepunk.graphics.Text;
import net.erifdex.ld27.entities.Manager;
import net.erifdex.ld27.entities.Button;
import net.erifdex.ld27.other.Sound;

class Yay extends OverlayScene {

	public var done : Bool;

	public function new() {
		super();
	}

	public override function begin() : Void {
		var m = new Manager(false);
		this.add(m);
		m.smile();
		m.tweenAway();
		this.add(new Button(HXP.halfWidth - 64 - 128, HXP.height * 0.78, "Play Again", playPressed));
		this.add(new Button(HXP.halfWidth - 64 + 128, HXP.height * 0.78, "Menu", menuPressed));

		var t : Text = new Text("What a victory! The cup is yours!", HXP.halfWidth, 32, 0, 0, {font:"font/font.ttf"});
		t.size = 30;
		t.color = 0x140c1c;
		t.x -= t.textWidth / 2;
		addGraphic(t);

		var t2 : Text = new Text("Your speech was perfect!", HXP.halfWidth, 70, 0, 0, {font:"font/font.ttf"});
		t2.size = 25;
		t2.color = 0x140c1c;
		t2.x -= t2.textWidth / 2;
		addGraphic(t2);
		Sound.stopBeat();
		Sound.playTada();
		super.begin();
		this.fadeIn();
	}

	public function playPressed() : Void {
		if(!done) {
			done = true;
			fadeOut(new GameScene());
			Sound.music.stop();
		}
	}

	public function menuPressed() : Void {
		if(!done) {
			done = true;
			fadeOut(new MenuScene());
		}
	}

}