package net.erifdex.ld27.scenes;

import com.haxepunk.Scene;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Text;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.Draw;
import motion.Actuate;
import motion.easing.Linear;
import net.erifdex.ld27.entities.Button;
import net.erifdex.ld27.entities.Manager;
import net.erifdex.ld27.other.GFX;

class MenuScene extends OverlayScene {

	public var ball1 : Image;
	public var ball2 : Image;

	public function new() {
		super();
	}

	public override function begin() : Void {
		var m = new Manager(true);
		m.startTalking();
		m.tweenAway();
		m.y = HXP.height * 0.3;
		add(m);
		var t = new Text("Coach Champ", HXP.halfWidth, HXP.height * 0.575, 0, 0, {font:"font/font.ttf"});
		t.size = 50;
		t.color = 0x140c1c;
		t.x -= t.textWidth / 2;
		this.addGraphic(t);
		ball1 = new Image(GFX.FOOTBALL);
		ball1.scale = 1.25;
		ball1.centerOrigin();
		addGraphic(ball1, HXP.width * 0.15, HXP.height * 0.64);
		ball2 = new Image(GFX.FOOTBALL);
		ball2.scale = 1.25;
		ball2.centerOrigin();
		addGraphic(ball2, HXP.width * 0.85, HXP.height * 0.64);

		this.add(new Button(HXP.halfWidth - 64, HXP.height * 0.78, "Play", playPressed));
		super.begin();
		fadeIn();
	}

	public function playPressed() : Void {
		fadeOut(new GameScene());
	}

	public override function update() : Void {
		//ball1.angle += 5;
		//ball2.angle -= 5;
		super.update();
	}

	public override function render() : Void {
		//Draw.linePlus(64, Math.round(HXP.height * 0.72), HXP.width - 64, Math.round(HXP.height * 0.72), 0x140c1c, 1, 3);
		super.render();
	}

}