#
# Text line wrapping test
#

UI.new.show(
        UI::Padding.new(padding: 8).append(
                UI::Border.new().append(
                        UI::Stack.new(direction: :col).append(
                                UI::TextLine.new("This is a single line of text."),
                                UI::TextLine.new("Here's another, which is hopefully a bit more sophisticated."),
                                UI::TextLine.new("This one line of text should be extremely long so that it will wrap correctly on whatever screen resolution you could possibly have. Isn't that great? However, if you have zoomed the terminal screen out too much, the line still won't wrap. That's something you need to fix though, not me. I'm not sure what else I could write about; the content on this page doesn't really matter so my words can be as empty as a fish barrel with no fish. I could have also used the (in)famous lorem ipsum, but let's be honest here; who wants to read a lorem ipsum when you can have a proper conversation with the reader like this? Ain't that right, ain't it? Yeah it is.")
                        )
                        #UIParagraph.new("This is a text.\nThis should be on a new line.")
                        #gets translated to
                        #UITextLine.new("This is a text."),UITextLine.new("This should be on a new line.")
                        #gets translated to
                        #UIText.new("This"),UIText.new("is"),...
                )
        )
);
