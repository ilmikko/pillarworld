require_relative('../view');

print("\e[32m");

view=View.new;

view.scene=->{
	view.write(0,0,"This text should not have any modifiers");
	view.write(0,1,"This text should appear red.",color: Screen::Color[:red]);
	view.write(0,2,"This text should not have any modifiers");
	view.write(0,3,"This text should be italic",italic:true);
	view.write(0,4,"This text should appear yellow.",color: Screen::Color[:yellow]);
	view.write(0,5,"This text should appear yellow as well.",color: Screen::Color[255,255,0]);
	view.write(0,6,"This text should be green and bold.",color: Screen::Color[:green],bold:true);
	view.write(0,7,"This text should be italic and blue.",italic:true,color: Screen::Color[0,0,255]);
	view.write(0,8,"This text should be bold and italic, but without any color.",bold:true,italic:true);
}

sleep;
