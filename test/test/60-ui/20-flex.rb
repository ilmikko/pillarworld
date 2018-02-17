# 
# A simple flex ui test.
#

UI.new.show(
        UI::Flex.new.append(
                UI::Flex.new(direction: :col).append(
                        UI::Border.new.append(
                                UI::Flex.new.append(
                                        UI::Flex.new(direction: :col).append(
                                                UI::Border.new,
                                                UI::Border.new
                                        ),
                                        UI::Flex.new(direction: :col).append(
                                                UI::Border.new,
                                                UI::Border.new
                                        )
                                )
                        ),
                        UI::Border.new
                ),
                UI::Flex.new(direction: :col).append(
                        UI::Border.new,
                        UI::Border.new
                )
        )
);
