require_relative('../view');

print("\e[32m");

view=View.new;

view.scene=->{
	y=-1;
	view.write(0,y+=1,"This text should not have any modifiers");
	view.write(0,y+=1,"This text should appear red.",color: Screen::Color[:red]);
	view.write(0,y+=1,"This text should not have any modifiers");
	view.write(0,y+=1,"This text should be italic, and without any color.",italic:true);
	view.write(0,y+=1,"This text should not have any modifiers");
	view.write(0,y+=1,"This text should appear non-italic and yellow.",color: Screen::Color[:yellow]);
	view.write(0,y+=1,"This text should not have any modifiers");
	view.write(0,y+=1,"This text should appear yellow as well.",color: Screen::Color[255,255,0]);
	view.write(0,y+=1,"This text should not have any modifiers");
	view.write(0,y+=1,"This text should be green and bold.",color: Screen::Color[:green],bold:true);
	view.write(0,y+=1,"This text should not have any modifiers");
	view.write(0,y+=1,"This text should be italic and blue.",italic:true,color: Screen::Color[0,0,255]);
	view.write(0,y+=1,"This text should not have any modifiers");
	view.write(0,y+=1,"This text should be bold and italic, but without any color.",bold:true,italic:true);
	view.write(0,y+=1,"This text should not have any modifiers");
}

sleep;
