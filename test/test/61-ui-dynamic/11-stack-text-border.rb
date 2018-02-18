#
# Stacked text border elements
#

UI.new.show(
    UI::Stack.new(direction: :row).append(
        UI::Wrap.new.append(
            UI::Text.new('This is a text')
        ),
        UI::Wrap.new.append(
            UI::Text.new('This is a text')
        ),
        UI::Wrap.new.append(
            UI::Text.new('This is a text')
        ),
        UI::Wrap.new.append(
            UI::Text.new('This is a text notice meeeeee I\'m different!')
        ),
        UI::Wrap.new.append(
            UI::Text.new('This is a text notice meeeeee I\'m different!')
        ),
        UI::Wrap.new.append(
            UI::Text.new('This is a text notice meeeeee I\'m different!')
        ),
        UI::Wrap.new.append(
            UI::Text.new('This is a text')
        ),
        UI::Wrap.new.append(
            UI::Text.new('This is a text')
        ),
        UI::Wrap.new.append(
            UI::Text.new('This is a text')
        )
    )
);