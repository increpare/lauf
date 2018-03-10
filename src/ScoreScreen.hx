import haxegon.*;
import utils.*;
import Globals.*;

class ScoreScreen {	
	function init(){
		//Truetype fonts look a LOT better when we don't scale the canvas!
		// Gfx.resizescreen(0, 0);
		Text.font = GUI.font;

		//initial all globals here

		state.sprache = Save.loadvalue("language");
		if (state.sprache==0){
			state.sprache=0;//ok does't do much			
		}
	}	

	function update() {	
		// Draw a white background
		Gfx.clearscreen(PAL.bg);
		var h = Gfx.screenheight;
		var w = Gfx.screenwidth;
		Text.wordwrap=w;

		Text.size=GUI.titleTextSize;
		var highscore=EinSpieler.score;
		if (Save.exists("score")){
			highscore = Save.loadvalue("score");
		}
		if (highscore<=EinSpieler.score){
			Save.savevalue("score",EinSpieler.score);
		}
		Text.display(40,h/5,S("Spielstand: ","Score: ")+EinSpieler.score, PAL.titelFarbe);
		Text.display(40,h/3,S("Hoechster Spielstand: ","Highscore: ")+highscore, PAL.titelFarbe);
		
		if (IMGUI.button( 
				Text.CENTER,
				Math.round(h/3+50),
				S("OK","OK")
			)) {
		mPlayNote(57803926,30.0,1.0,1.0);
			Scene.change(Main);
		//	Scene.change(szene.CharakterAuswahl);
		}

	}
}
