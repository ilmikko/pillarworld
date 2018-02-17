#
# Text element, different colors
#

UI.new.show(
        UI::Stack.new(direction: :row).append(
                UI::Text.new(' Non modified text '),
                UI::Text.new(' Red Text ',color: :red),
                UI::Text.new(' Green Text ',color: :green),
                UI::Text.new(' Yellow Text ',color: :yellow),
                UI::Text.new(' Blue Text ',color: Screen::Color[0,0,255]),
                UI::Text.new(' Cyan Text ',color: :cyan)
        )
);
