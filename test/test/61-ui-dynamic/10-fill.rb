#
# Challenge: Make two elements in a UI::Stack, and have something else fill the REST OF THE SPACE.
#

#
# XXX: Idea!
# What if we wanted to have this layout:
#
# [[A][   FILLER   ][B]]
#
# If we used the default UI::Fill, we would end up with something like this:
# [[A][    FILLER     ]](B)
# Because the FILLER would just 'greedily' take all of the space.
#
# Or, if we had two fillers:
# [[    FILLER   ][   FILLER   ]]
# right?
# ..no.
# [[          FILLER           ]](     FILLER     )
# This is quite counter-intuitive. So I got an idea.
#
# What if, when we calculate the max space available to the fillers, we were a bit smarter?
# Have all of our space A.
# Get our non-growing elements (for example, set as grow:0, or wrap:1, or similar, behaving like UI::Wrap)
# Get all of these elements' widths and combine them to B.
#
# Take available space C = A - B.
# This available space will be divided EVENLY for our filler elements.
# So if there are two filler elements, each gets C/2 space.
#
# We could even have something like flexGrow: 2 vs flexGrow: 1 creating a 2:1 split, or giving 2C/3 space for the first element and C/3 space for the second.
#
# IMPORTANT: This behavior doesn't need to be applied to EVERY UI element, we could just have a UIStack type element that calculates this.
#
