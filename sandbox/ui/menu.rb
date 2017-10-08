# A simple test menu
Dir.chdir('../');
require('./ui.rb');
require('./input.rb');

$console.dump=true;

$ui.direction=:col;

$ui.append(
        UITextArea.new(ha: :left, ta: :left).append(
                UILine.new('This is a ','rich text',' area. '),
                UILine.new().append(
                        UIText.new('This is on the second line.')
                ),
                UILine.new().append(
                        UIText.new('Basically this is a text span that can be '),
                        bb=UIText.new('individually modified',color: "\e[33m"),
                        UIText.new('. This is still on the same line.')
                )
        ),
        #UIText.new('Test'),
        #UIText.new('aaaa2'),
        UITextArea.new().append(
                UILine.new('UIDiv2')
        ),
        UIFlex.new().append(
                UIFlex.new().append(
                        UITextArea.new().append(
                                UIText.new('1234567890'),
                                UIText.new('bbbbbbbbbb'),
                                UIText.new('asdfghjkl;')
                        ),
                        UIFlex.new(direction: :col).append(
                                UITextArea.new().append(
                                        UIText.new('UIDiv1.5')
                                ),
                                UITextArea.new().append(
                                        UIText.new('UIDiv2.0')
                                )
                        )
                )
        ),
        UITextArea.new().append(
                UIText.new('UIDiv3')
        ),
        UIFlex.new().append(
                UITextArea.new().append(
                        UIText.new('UIDiv4')
                )
        )
        #UITextArea.new('Test'),
        #UITextArea.new('Test2'),
        #UIDiv.new().append(
        #        UITextArea.new('Test3'),
        #        UITextArea.new('Test4'),
        #)
);

$ui.update();

test=false;
while true
        test=!test;
        bb.color=test ? "\e[38;5;245m":"\e[33m";
        #bb.text=test ? 'oo':'boooooo!';
        #bb.parent.readjust;
        #bb.parent.render;
        bb.update();
        sleep(0.1);
end

sleep;
