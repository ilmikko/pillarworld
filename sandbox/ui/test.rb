# A simple test menu
Dir.chdir('../');
require('./ui.rb');
require('./input.rb');

$console.dump=true;

# should appear as center of UI element
$ui.append(UIText.new("Testing text alignment\nFalling Shadows",ta: :right,ha: :center,va: :bot));

$ui.direction=:col;

$ui.append(UIArray.new().append(UIText.new("This is a short text.\nAsd\nThird line\nSomething to break\nSooner or later",ha: :right,ta: :right),UIRichText.new('This is another short text.',ha: :left,va: :top)));

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
