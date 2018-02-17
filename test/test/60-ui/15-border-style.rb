# 
# Testing different border styles
#

UI.new.show(
        UI::Padding.new(padding:3).append(
                # Default border
                UI::Border.new().append(
                        # Discount border with -|+
                        UI::Border.new(corner: '+', vertical: '|', horizontal: '-').append(
                                # Border with only corners
                                UI::Border.new(line: '').append(
                                        # A strange border
                                        UI::Border.new(vertical: 'I', ee:'').append(
                                                # A border with custom doubles
                                                UI::Border.new(dh: '=', dv: 'H').append(
                                                        # A border with a custom dot and no corners
                                                        UI::Border.new(corner: '', dot: '+')
                                                )
                                        )
                                )
                        )
                )
        )
);
