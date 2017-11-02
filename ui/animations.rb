# UI Animations! On-demand!
#
# TODO: Under construction
#

require('./ui.rb');

$ui.show(
	UITextArea.new.append(
		uip=UIText.new('This is a text.'),
		animText=UIText.new('This text should be animated.')
	)
);

sleep 1;

uip.text+=' Notice me ree';

while true
	sleep 0.1;
	uip.text+='e';
	$ui.redraw;
end

sleep;
