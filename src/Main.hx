import haxegon.*;
import utils.*;
import Globals.*;


class Main {	

	function init(){
		Gfx.resizescreen(320, 240, true);
		//Truetype fonts look a LOT better when we don't scale the canvas!
		//Gfx.resizescreen(0, 0);
		Text.font = GUI.font;

		//initial all globals here

		if (!Save.exists("language")){
			Save.savevalue("language",1);
		}
		state.sprache = Save.loadvalue("language");
		if (state.sprache==0){
			state.sprache=0;//ok does't do much			
		}
	}	

	function update() {	
		//88045 swap
		//35423 submit
		//34195 submit 2
		//99487 bad
		if (Input.justpressed(Key.E)){
			var r = Random.int(0,100000);
			trace(r);
			mPlayNote(r,30.0,0.3,1.0);
		}
		// Draw a white background
		Gfx.clearscreen(PAL.bg);
		var h = Gfx.screenheight;
		var w = Gfx.screenwidth;
		Text.wordwrap=w;

		if (Save.exists("score")){
			Text.size=1;
			var highscore = Save.loadvalue("score");
			Text.display(2,2,S("Hoechster Spielstand: ","Highscore: ")+highscore, PAL.titelFarbe);
		}

		Text.size=GUI.titleTextSize;
		Text.display(Text.CENTER,h/5,S("10 Sekunden Sprint","10 Second Sprint"), PAL.titelFarbe);
		
		if (IMGUI.button( 
				Text.CENTER,
				Math.round(h/3),
				S("1 SPIELER","1 PLAYER")
			)) {			
		mPlayNote(57803926,30.0,1.0,1.0);
			Scene.change(EinSpieler);
		//	Scene.change(szene.CharakterAuswahl);
		}


		if (IMGUI.button( 
				Text.CENTER,
				Math.round(h/3+50),
				S("2 SPIELER","2 PLAYER")
			)) {
		mPlayNote(57803926,30.0,1.0,1.0);
		Scene.change(ZweiSpieler);
		}

		if (IMGUI.schalter( 
			Text.CENTER,
			Math.round(h/3+100),
		S("DEUTSCH","GERMAN"),
		S("ENGLISCH","ENGLISH"),
		1-state.sprache)){
			state.sprache=1-state.sprache;
			Save.savevalue("language",state.sprache);
		}
		Text.size=1;
		
	}
}
