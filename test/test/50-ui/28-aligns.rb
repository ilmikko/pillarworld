#
# Element align tests
#

UI.new.show(
        UI::Padding.new(padding:1).append(
                UI::Split.new(direction: :column).append(
                        UI::Split.new.append(
                                UI::Border.new.append(
                                        UI::Align.new().append(
                                                UI::Text.new('Default')
                                        )
                                ),
                                UI::Border.new.append(
                                        UI::Align.new(va: :center,  ha: :center).append(
                                                UI::Text.new('Center')
                                        )
                                ),
                                UI::Border.new.append(
                                        UI::Align.new(ha: :right).append(
                                                UI::Text.new('East')
                                        )
                                ),
                                UI::Border.new.append(
                                        UI::Align.new(va: :bottom).append(
                                                UI::Text.new('South')
                                        )
                                )
                        ),
                        UI::Split.new.append(
                                UI::Border.new.append(
                                        UI::Align.new(ha: :left).append(
                                                UI::Text.new('West')
                                        )
                                ),
                                UI::Border.new.append(
                                        UI::Align.new(va: :top).append(
                                                UI::Text.new('North')
                                        )
                                ),
                                UI::Border.new.append(
                                        UI::Align.new(va: :top, ha: :left).append(
                                                UI::Text.new('NW')
                                        )
                                ),
                                UI::Border.new.append(
                                        UI::Align.new(va: :top, ha: :right).append(
                                                UI::Text.new('NE')
                                        )
                                )
                        ),
                        UI::Split.new.append(
                                UI::Border.new.append(
                                        UI::Align.new(va: :bottom, ha: :left).append(
                                                UI::Text.new('SW')
                                        )
                                ),
                                UI::Border.new.append(
                                        UI::Align.new(va: :bottom, ha: :right).append(
                                                UI::Text.new('SE')
                                        )
                                ),
                                UI::Border.new.append(
                                        UI::Align.new.append(
                                                UI::Text.new('Default')
                                        )
                                ),
                                UI::Border.new.append(
                                        UI::Text.new('No align')
                                )
                        )
                )
        )
);
