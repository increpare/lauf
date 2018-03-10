import haxegon.*;
import utils.*;
import Globals.*;

class Main {	
	function init(){
		//Truetype fonts look a LOT better when we don't scale the canvas!
		Gfx.resizescreen(0, 0);
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
		Text.display(Text.CENTER,h/5,S("Lauf","Lauf"), PAL.titelFarbe);

		if (IMGUI.button( 
				Text.CENTER,
				Math.round(h/3),
				S("1 SPIELER","1 PLAYER")
			)) {
		//	Scene.change(szene.CharakterAuswahl);
		}


		if (IMGUI.button( 
				Text.CENTER,
				Math.round(h/3+50),
				S("2 SPIELER","2 PLAYER")
			)) {
		//	Scene.change(szene.CharakterAuswahl);
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
