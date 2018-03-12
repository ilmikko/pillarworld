# 
# A simple flex ui test.
#

UI.new.show(
        UI::Split.new.append(
                UI::Split.new(direction: :col).append(
                        UI::Border.new.append(
                                UI::Split.new.append(
                                        UI::Split.new(direction: :col).append(
                                                UI::Border.new,
                                                UI::Border.new
                                        ),
                                        UI::Split.new(direction: :col).append(
                                                UI::Border.new,
                                                UI::Border.new
                                        )
                                )
                        ),
                        UI::Border.new
                ),
                UI::Split.new(direction: :col).append(
                        UI::Border.new,
                        UI::Border.new
                )
        )
);
