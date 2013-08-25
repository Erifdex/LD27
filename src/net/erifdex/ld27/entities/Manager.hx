package net.erifdex.ld27.entities;

import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.graphics.Image;
import motion.Actuate;
import motion.easing.Quad;
import net.erifdex.ld27.other.GFX;

class Manager extends Entity {
	
	public var face : Spritemap;

	public function new(fire : Bool = false) {
		super();
		if(fire) {
			face = new Spritemap(GFX.MANAGER_FIRE, 128, 128);
		} else {
			face = new Spritemap(GFX.MANAGER, 128, 128);
		}
		x = HXP.width / 2;
		y = HXP.height / 2;
		face.scale = 2;
		face.add("normal", [0]);
		face.add("talk", [0, 1], 5, true);
		if(!fire) {
			face.add("smile", [2]);
			face.add("cry", [3]);
		}
		face.play("normal");
		this.graphic = face;
		face.centerOrigin();
		face.angle = -10;
		var shadow = new Image(GFX.SHADOW);
		shadow.scale = 1.5;
		shadow.centerOrigin();
		shadow.y = 128;
		if(!fire) this.addGraphic(shadow);
	}

	public function tweenAway() : Void {
		Actuate.tween(face, 1, { angle: 10 }, false).ease(Quad.easeInOut).onComplete(tweenBack);
	}

	public function tweenBack() : Void {
		Actuate.tween(face, 1, { angle: -10 }, false).ease(Quad.easeInOut).onComplete(tweenAway);
	}

	public function startTalking() : Void {
		face.play("talk");
	}

	public function stopTalking() : Void {
		face.play("normal");
	}

	public function smile() : Void {
		face.play("smile");
	}

	public function cry() : Void {
		face.play("cry");
	}

}