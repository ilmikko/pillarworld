# 
# Master test: test that we can have a bordered area to test other tests in.
#

require_relative('../ui');

UI.new.show(
	UI::Align.new.append(
		UI::Text.new('test')
	)
);

sleep;
