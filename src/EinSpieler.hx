import haxegon.*;
import Globals.*;
class EinSpieler {	

	public static function floatToStringPrecision3(n:Float)
	{		
		if(n==0)
			return "0.000";

		var minusSign:Bool = (n<0.0);
		n = Math.abs(n);
		var intPart:Int = Math.floor(n);
		var p:Float = 1000.0; //pow(10, 3)
		var fracPart = Math.round( p*(n - intPart) );
		var buf:StringBuf = new StringBuf();

		if(minusSign)
			buf.addChar("-".code);
		buf.add(Std.string(intPart));
		if(fracPart==0)
			buf.add(".000");
		else 
		{
			if(fracPart<10)
				buf.add(".00");  
			else if(fracPart<100)
				buf.add(".0"); 
			else
				buf.add("."); 
			buf.add(fracPart);
		}
		return buf.toString();
	}

	var zeit:Float;
	public static var score:Int=0;

	var todo = "";
	var done=false;
	function push(){
		if (Random.bool()){
			todo += "0";
		} else {
			todo += "1";
		}
	}

	function pop(){
		todo = todo.substring(1);
	}

	function init(){
		trace("called");
		todo="";
		score = 0;
		for (i in 0...20){
			push();
		}

		zeit=13;
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
		if (done){
			init();
			done=false;
		}	
		// Draw a white background		
		Gfx.clearscreen(PAL.bg);


		var h = Gfx.screenheight;
		var w = Gfx.screenwidth;
		Text.wordwrap=w;

		var altZeit=zeit;
		zeit -= 1.0/60.0;

		Text.display(40,h/5,S("Spielstand: ","Score: ")+score, PAL.titelFarbe);

		if (zeit>12){
			Text.display(Text.CENTER,h/5+25,S("VERSENDEN NUR 1!","SUBMIT ONLY 1's!"), PAL.titelFarbe);				
		} else if (zeit>11){
			if (altZeit>12){
				mPlayNote(57803926,50.0,1.0,1.0);
			}
			Text.size=GUI.titleTextSize;
			Text.display(Text.CENTER,h/5+25,S("Achtung...","Ready..."), PAL.titelFarbe);
		} else if (zeit>10){
			if (altZeit>=11){
				mPlayNote(57803926,50.0,1.0,1.0);
			}
			Text.size=GUI.titleTextSize;
			Text.display(Text.CENTER,h/5+25,S("Fertig...","Steady..."), PAL.titelFarbe);
		} else if (zeit>9){
			if (altZeit>=10){
				mPlayNote(57803926,30.0,1.0,1.0);
			}
			Text.size=GUI.titleTextSize;
			Text.display(Text.CENTER,h/5+25,S("Los!","Go!"), PAL.titelFarbe);
		} else {			
			if( Math.floor(zeit)!=Math.floor( altZeit ) ) 
			{
				mPlayNote(57803926,20.0,1.0,1.0);			
			}
		}
		var zs = floatToStringPrecision3(zeit);
		Text.display(40,h/3+25,S("Zeit: ","Time: ")+zs, PAL.titelFarbe);
		Text.display(40,h/3+50,todo, PAL.titelFarbe);
		Text.display(40,h/3+50+16,"^", PAL.titelFarbe);

		Text.display(40,h/3+50+2*16,S("X - tauschen","X - switch"), PAL.titelFarbe);
		Text.display(40,h/3+50+3*16,S("C - versenden","C - submit"), PAL.titelFarbe);

		Text.size=1;	
		
		if (zeit<10){

			///
		//88045 swap
		//35423 submit
		//34195 submit 2
		//99487 bad
			if (Input.justpressed(Key.X)){
				mPlayNote(88045,30.0,0.3,1.0);
				if (todo.charAt(0)=="0"){
					todo = "1"+todo.substr(1);
				} else {
					todo = "0"+todo.substr(1);
				}
			}
			if (Input.justpressed(Key.C)){
				if (todo.charAt(0)=="1"){
					mPlayNote(34195,30.0,0.3,1.0);
					score++;
				} else {
					mPlayNote(99487,30.0,0.3,1.0);
					score--;
				}
				pop();
				push();			
			}
		}

		if (Input.justpressed(Key.ESCAPE)){	
			Scene.change(Main);
			done=true;
		}
		if (zeit<0){	
			mPlayNote(57803926,30.0,1.0,1.0);		
			Scene.change(ScoreScreen);
			done=true;
		}
	}
}
