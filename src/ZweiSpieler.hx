import haxegon.*;
import Globals.*;
class ZweiSpieler {	

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
	public static var score1:Int=0;
	public static var score2:Int=0;

	var todo1 = "";
	var todo2 = "";

	var bomb1:Bool;
	var bomb2:Bool;

	var done=false;
	function push1(){
		if (Random.bool()){
			todo1 += "0";
		} else {
			todo1 += "1";
		}
	}

	function pop1(){
		todo1 = todo1.substring(1);
	}
	function push2(){
		if (Random.bool()){
			todo2 += "0";
		} else {
			todo2 += "1";
		}
	}

	function pop2(){
		todo2 = todo2.substring(1);
	}

	function bombS1(){
		var s = "";
		for (i in 0...20){
			if (todo1.charAt(i)=="0"){			
				s+="1";
			} else {
				s+="0";
			}
		}
		todo1=s;
	}
	function bombS2(){
		var s = "";
		for (i in 0...20){
			if (todo2.charAt(i)=="0"){			
				s+="1";
			} else {
				s+="0";
			}
		}
		todo2=s;
	}


	function init(){
		bomb1=true;
		bomb2=true;
		trace("called");
		todo1="";
		todo2="";
		score1 = 0;
		score2 = 0;
		for (i in 0...20){
			push1();
			push2();
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

		var altZeit=zeit;
		zeit -= 1.0/60.0;
		var zs = floatToStringPrecision3(zeit);

		var h = Gfx.screenheight;
		var w = Gfx.screenwidth;
		Text.wordwrap=w;




		// Draw a white background		
		Gfx.clearscreen(PAL.bg);
		
		var l=-1;
		Text.display(40,16*(l++),S("Zeit: ","Time: ")+zs, PAL.titelFarbe);
		l++;
		Text.display(40,16*(l++),S("Spielstand S1: ","Score P1: ")+score1, PAL.titelFarbe);
		Text.display(40,16*(l++),todo1, PAL.titelFarbe);
		Text.display(40,16*(l++),S("X - tauschen, C - versenden","X - switch C - submit"), PAL.titelFarbe);
		if (bomb1){
			Text.display(40,16*(l++),S("V - Bombe (x1)","V - bomb (x1)"), PAL.titelFarbe);
		} else {
			l++;
		}


		l++;
		if (zeit>12){
			Text.display(Text.CENTER,16*(l++),S("VERSENDEN NUR 1!","SUBMIT ONLY 1's!"), PAL.titelFarbe);				
		} else if (zeit>11){
			if (altZeit>12){
				mPlayNote(57803926,50.0,1.0,1.0);
			}
			Text.size=GUI.titleTextSize;
			Text.display(Text.CENTER,16*(l++),S("Achtung...","Ready..."), PAL.titelFarbe);
		} else if (zeit>10){
			if (altZeit>=11){
				mPlayNote(57803926,50.0,1.0,1.0);
			}
			Text.size=GUI.titleTextSize;
			Text.display(Text.CENTER,16*(l++),S("Fertig...","Steady..."), PAL.titelFarbe);
		}/* else if (zeit>9){
			if (altZeit>=10){
				mPlayNote(57803926,30.0,1.0,1.0);
			}
			Text.size=GUI.titleTextSize;
			Text.display(Text.CENTER,16*(l++),S("Los!","Go!"), PAL.titelFarbe);
		} */ else  {		
			if (altZeit>=10){
				mPlayNote(57803926,30.0,1.0,1.0);
			}	
			Text.display(Text.CENTER,16*(l++),S("Zeit: ","Time: ")+zs, PAL.titelFarbe);
			if( Math.floor(zeit)!=Math.floor( altZeit ) ) 
			{
				mPlayNote(57803926,20.0,1.0,1.0);			
			}
		}
		l++;

		Text.display(40,16*(l++),S("Spielstand S2: ","Score P2: ")+score2, PAL.titelFarbe);
		Text.display(40,16*(l++),todo2, PAL.titelFarbe);
		Text.display(40,16*(l++),S("I - tauschen, O - versenden","I - switch O - submit"), PAL.titelFarbe);
		if (bomb2){
			Text.display(40,16*(l++),S("P - Bombe (x1)","P - bomb (x1)"), PAL.titelFarbe);
		} else {
			l++;
		}

		Text.size=1;	
		
		if (zeit<10){
			if (Input.justpressed(Key.X)){
					mPlayNote(88045,30.0,0.3,1.0);
				if (todo1.charAt(0)=="0"){
					todo1 = "1"+todo1.substr(1);
				} else {
					todo1 = "0"+todo1.substr(1);
				}
			}
			if (Input.justpressed(Key.C)){
				if (todo1.charAt(0)=="1"){
					mPlayNote(34195,30.0,0.3,1.0);
					score1++;
				} else {
					mPlayNote(99487,30.0,0.3,1.0);
					score1--;
				}
				pop1();
				push1();			
			}
			if (bomb1&&Input.justpressed(Key.V)){
				bomb1=false;
				bombS2();
				mPlayNote(96447,40.0,0.3,1.0);
			}

			if (Input.justpressed(Key.I)){
					mPlayNote(88045,30.0,0.3,1.0);
				if (todo2.charAt(0)=="0"){
					todo2 = "1"+todo2.substr(1);
				} else {
					todo2 = "0"+todo2.substr(1);
				}
			}
			if (Input.justpressed(Key.O)){
				if (todo2.charAt(0)=="1"){
					mPlayNote(34195,30.0,0.3,1.0);
					score2++;
				} else {
					mPlayNote(99487,30.0,0.3,1.0);
					score2--;
				}
				pop2();
				push2();			
			}
			if (bomb2&&Input.justpressed(Key.P)){
				bomb2=false;
				bombS1();
				mPlayNote(96447,40.0,0.3,1.0);
			}
		}

		if (Input.justpressed(Key.ESCAPE)){	
			Scene.change(Main);
			done=true;
		}
		if (zeit<0){	
			mPlayNote(57803926,30.0,1.0,1.0);		
			Scene.change(ScoreScreen2S);
			done=true;
		}
	}
}
