# 
# Master test: test that we can have a bordered area to test other tests in.
#

# ../../lib because we're in test/ui/
$LOAD_PATH.push('lib');

require('ui');

UI.new.show(
	UI::Align.new.append(
		UI::Text.new('test')
	)
);

sleep;
