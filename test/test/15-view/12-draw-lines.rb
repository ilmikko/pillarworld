# 
# A simple test for drawing lines
#

view=View.new(50,20, x:10, y:10);

view.scene=->{
	# Horizontal crop left
	view.hline(-5,0,5, char:'<');
	view.hline(-4,1,5, char:'<');
	view.hline(-3,2,5, char:'<');
	view.hline(-2,3,5, char:'<');
	view.hline(-1,4,5, char:'<');
	view.hline( 0,5,5, char:'<');
	view.hline( 1,6,5, char:'<');
	view.hline( 2,7,5, char:'<');
	view.hline( 3,8,5, char:'<');
	view.hline( 4,9,5, char:'<');
	view.hline(5,10,5, char:'<');

	# Horizontal crop right
	view.hline(40,0,5, char:'>');
	view.hline(41,1,5, char:'>');
	view.hline(42,2,5, char:'>');
	view.hline(43,3,5, char:'>');
	view.hline(44,4,5, char:'>');
	view.hline(45,5,5, char:'>');
	view.hline(46,6,5, char:'>');
	view.hline(47,7,5, char:'>');
	view.hline(48,8,5, char:'>');
	view.hline(49,9,5, char:'>');
	view.hline(50,10,5,char:'>');

	# Vertical crop top
	view.vline(20,-5,5, char:'^');
	view.vline(21,-4,5, char:'^');
	view.vline(22,-3,5, char:'^');
	view.vline(23,-2,5, char:'^');
	view.vline(24,-1,5, char:'^');
	view.vline(25, 0,5, char:'^');
	view.vline(26, 1,5, char:'^');
	view.vline(27, 2,5, char:'^');
	view.vline(28, 3,5, char:'^');
	view.vline(29, 4,5, char:'^');
	view.vline(30, 5,5, char:'^');

	# Vertical crop bottom
	view.vline(20,10,5, char:'V');
	view.vline(21,11,5, char:'V');
	view.vline(22,12,5, char:'V');
	view.vline(23,13,5, char:'V');
	view.vline(24,14,5, char:'V');
	view.vline(25,15,5, char:'V');
	view.vline(26,16,5, char:'V');
	view.vline(27,17,5, char:'V');
	view.vline(28,18,5, char:'V');
	view.vline(29,19,5, char:'V');
	view.vline(30,20,5, char:'V');
}
