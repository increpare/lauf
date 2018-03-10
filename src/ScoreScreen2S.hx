import haxegon.*;
import utils.*;
import Globals.*;

class ScoreScreen2S {	
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
		var max = Math.max(ZweiSpieler.score1,ZweiSpieler.score2);
		var highscore = max;
		if (Save.exists("score")){
			highscore = Save.loadvalue("score");
		}
		if (highscore<=max){
			Save.savevalue("score",max);
		}
		var l = 4;
		Text.display(40,16*(l++),S("Spielstand S1: ","Score P1: ")+ZweiSpieler.score1, PAL.titelFarbe);
		Text.display(40,16*(l++),S("Spielstand S2: ","Score P2: ")+ZweiSpieler.score2, PAL.titelFarbe);
		l++;
		if (ZweiSpieler.score1>ZweiSpieler.score2){
			Text.display(40,16*(l++),S("Spieler 1 hat gewonnen!: ","Player 1 wins!"), PAL.titelFarbe);
		} else if (ZweiSpieler.score1<ZweiSpieler.score2){
			Text.display(40,16*(l++),S("Spieler 2 hat gewonnen!: ","Player 2 wins!"), PAL.titelFarbe);
		} else {
			Text.display(40,16*(l++),S("Unentschiedenes Spiel!","Draw Game!"), PAL.titelFarbe);
		}
		l++;
		Text.display(40,16*(l++),S("Hoechster Spielstand: ","Highscore: ")+highscore, PAL.titelFarbe);
		
		l++;

		if (IMGUI.button( 
				Text.CENTER,
				16*(l++),
				S("OK","OK")
			)) {
		mPlayNote(57803926,30.0,1.0,1.0);
			Scene.change(Main);
		//	Scene.change(szene.CharakterAuswahl);
		}

	}
}
