#
# menu.rb
# Handles menu and interactivity, high-level stuff.
#

require('./console.rb');
require('./input.rb');
require('./ui.rb');

class Menu
        def create(id,*elems)
                @menus[id]=*elems;
        end
        def show(id)
                $console.log("Showing #{id} menu");
                if !@menus.key? id
                        raise "ID not found: #{id}";
                end
                $ui.show(*@menus[id]);
        end
        def initialize
                @menus={};
        end
end

$menu = Menu.new;
