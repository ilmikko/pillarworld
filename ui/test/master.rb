# 
# Master test: test that we can have a bordered area to test other tests in.
#

require('./ui.rb');

$ui.show(
	UIAlign.new.append(
		UIText.new('test')
	)
);

sleep;
