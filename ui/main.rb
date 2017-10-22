require('./menu.rb');

class Main
        def close(reason)
                $console.log("Terminating program (#{reason})");
                exit(1);
        end
        def initialize
                $menu.create(:simple,
			UIFlex.new(direction: :col).append(
				UITextArea.new.append(
					UIParagraph.new('A quick brown fox jumps over a lazy dog', textalign: :left),
					UIParagraph.new(
						$taxinamba=UIText.new('The text to the right is: '),
						UIText.new('FABULOUS', color: :blue)
					),
					UIParagraph.new('Another puny a line!',textalign: :left)
				),
				UITextArea.new.append(
					UIParagraph.new('Woot woot',textalign: :left),
					UIParagraph.new("Did you ever hear the tragedy of Darth Plaqueis the Wise? I shall tell you but unfortunately I can't remember anything else than the first paragraph of that text so I'm currently talking kind of out of my arse here but it's actually quite fine.",textalign: :left)
				)
			),
			UIFlex.new(direction: :col).append(
				UITextArea.new.append(
					UIParagraph.new('A qubbbb bbbb bbbbbbb bbbb bbbbbbbasdasds asdasdsa  s asdog',textalign: :left),
					UIParagraph.new('Anothbas dad a sad asda d e!',textalign: :left)
				),
				UITextArea.new.append(
					UIParagraph.new('Woot adsd adsa da das aaaa as',textalign: :left),
					UIParagraph.new('I ha das dasd asd as da era fas fwill work',textalign: :left)
				)
			)
                        #UITextArea.new().append(

				#UIText.new('A'),
                                #UIText.new(' '),
                                #UIText.new('quick'),
                                #UIText.new(' '),
                                #UIText.new('brown'),
                                #UIText.new(' '),
                                #UIText.new('fox'),
                                #UIText.new(' '),
                                #UIText.new('jumps'),
				#UIText.new(' '),
                                #UIText.new('over'),
                                #UIText.new(' '),
                                #UIText.new('a'),
                                #UIText.new(' '),
                                #UIText.new('lazy'),
                                #UIText.new(' '),
                                #UIText.new('dog')
                        #)
                );
                $menu.create(:test,
                        UIFlex.new(direction: :col).append(
                                UITextArea.new().append(
                                        UIParagraph.new.append(
                                                UIText.new('Line 1')
                                        ),
                                        UIParagraph.new.append(
                                                UIText.new('Line 2'),
                                                UIText.new(' still line 2'),
                                                UIText.new('Line 2 continued'),
                                                UIText.new('Line 2 still continued'),
                                                UIText.new('Yes it still goes on')
                                        ),
                                        UIParagraph.new.append(
                                                UIText.new('Line 3')
                                        ),
                                        UIParagraph.new.append(
                                                UIText.new('Line 4')
                                        )
                                )
                        )
                );
        end
end

$input.listen({
	"\r":->{
		$taxinamba.parent.append(UIText.new('This is merely a test'));
		$ui.update;
	}
});

$main = Main.new;
