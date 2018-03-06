# 
# 'Fancy' border test - an aligned window with four border elements inside in a cross formation.
#

UI.new.show(
        UI::Align.new.append(
                UI::Border.new(width:22,height:12).append(
                        UI::Split.new.append(
                                UI::Split.new(direction: :col).append(
                                        UI::Border.new,
                                        UI::Border.new,
                                ),
                                UI::Split.new(direction: :col).append(
                                        UI::Border.new,
                                        UI::Border.new,
                                )
                        )
                        #UIAlign.new.append(
                        #       UIText.new('21x11')
                        #)
                )
        )
);
