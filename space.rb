require("./tool.rb");

class Renderable < IDd
        def renderlist
                @renderlist
        end
        def initialize()
                super();

                @renderlist=[];
        end
end

class Physical < Renderable
        def x
                @position[0]
        end
        def y
                @position[1]
        end
        def position
                @position
        end
        def initialize(position:[0,0],events:{},**args)
                super();

                this = self;
                @position=position;

                @timeblock=TimeBlock.new($time.now,5000,name:"wo:#{@id}");

                @timeblock.eventsListen({
                        'start':->{
                                $console.debug("Add world");
                                $space.put(this);
                        },
                        'end':->{
                                $console.debug("Remove world");
                                $space.remove(this);
                        }
                });

                @timeblock.eventsListen(events);

                $time.putblock(@timeblock);
        end
end

class Pillar < Physical
        def radius
                @radius
        end
        def initialize(radius:10,**args)
                # Create a world using these simple steps
                # First, pick x and y along world axes.
                # These x,y are the coordinates for the center of the circle
                # Then, pick an r how far away from the center do we want to be
                # Pick a d at what angle are we from the top
                # This point is the location of the world.
                # Pick a radius for our world
                # That's it! World created.
                super(**args);

                # Render objects: for example, World contains 2 render objects.
                # 1. The world circle / radius / whatever
                # 2. A 'blip' to note there is something there, when zoomed out far enough
                @renderlist.push(:renderCircle,:renderPoint);

                @radius=radius;
        end
end

class Space
        def list
                @list
        end
        def put(obj)
                @list[obj.id]=obj;
        end
        def remove(obj)
                @list.delete(obj.id);
        end
        def initialize()
                @list={};
        end
end

$space=Space.new;
