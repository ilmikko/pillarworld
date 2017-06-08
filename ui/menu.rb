# A simple test menu
Dir.chdir('../');
require('./ui.rb');
require('./input.rb');

$console.file=true;

# should appear as center of UI element
$ui.append(UITextMultiline.new("Testing text alignment\nFalling Shadows"));

$ui.direction=:col;

$ui.append(UIArray.new().append(UITextMultiline.new("This is a short text.\nAsd\nThird line\nSomething to break\nSooner or later"),UIText.new('This is another short text.')));

#$ui.append(UIText.new('This is yet another short text.'));

ts = UIText.new('Different init');

ts2 = UIText.new('Different init2');

$ui.append(UIArray.new(direction: :row).append(ts,ts2));

$ui.refresh();

while true
        ts.text="Different #{rand}";
        ts2.text="Yet different #{rand}";
        ts.update();
        ts2.update();
        sleep(1/60.0);
end

#$canvas.sceneSet(->(w,h){
#        self.write('Hello this is a test',w/2,h/2,align: :center);
#});

sleep;
