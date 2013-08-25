import com.haxepunk.Engine;
import com.haxepunk.HXP;
import net.erifdex.ld27.scenes.*;
import net.erifdex.ld27.other.GFX;
import net.erifdex.ld27.other.Sound;

class Main extends Engine
{

	override public function init()
	{
		GFX.init();
#if debug
		//HXP.console.enable();
#end
		Sound.playMusic();
		HXP.scene = new MenuScene();
	}

	public static function main() { new Main(); }

}