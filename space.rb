require("./tool.rb");

require("./noise.rb");

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
        def x; @position[0] end
        def x=(v); @position[0]=v; end

        def y; @position[1] end
        def y=(v); @position[1]=v; end

        def z; @position[2] end
        def z=(v); @position[2]=v; end

        def w; @dimensions[0] end
        def w=(v); @dimensions[0]=v; end
        def h; @dimensions[1] end
        def h=(v); @dimensions[1]=v; end
        def d; @dimensions[2] end
        def d=(v); @dimensions[2]=v; end

        def size
                @dimensions
        end

        def position
                @position
        end

        def initialize(position:[0,0,0],dimensions:[2,2,2],**args)
                super();

                @position=position;
                @dimensions=dimensions;
        end
end

class Pillar < Physical
        def radius
                @dimensions[0]/2
        end
        def radius=(r)
                d=r*2;
                @dimensions[0]=@dimensions[1]=d;
        end

        def height
                @dimensions[2]
        end
        def height=(v)
                @dimensions[2]=v;
        end

        def renderCustomPlot(x,y,z,m)
                r=@dimensions[0]/2;
                # if inside circle
                if (y*y+x*x<r*r*m*m)
                        # perlinzzzah
                        return $noise.simplex(x/m,y/m,z/m)>@voidification;
                end
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
                self.radius=radius;

                # Render objects: for example, World contains 2 render objects.
                # 1. The world circle / radius / whatever
                # 2. A 'blip' to note there is something there, when zoomed out far enough
                @renderlist.push(:renderCustomPlot);
                @renderlist.push(:renderPoint);

                @voidification=-1;

                this = self;
                @timeblock=TimeBlock.new($time.now,[
                        {
                                eventEnd:->{
                                        $space.put(this);
                                }
                        },
                        {
                                length:5000
                        },
                        {
                                length:20000,
                                eventIter:->(age){
                                        @voidification=-1+age*2;
                                },
                                eventEnd:->{
                                        $space.remove(this);
                                }
                        }
                ]);

                $time.putblock(@timeblock);

        end
end

class Space
        def list
                @list
        end
        def put(obj)
                obj.trigger(:put);
                @list[obj.id]=obj;
        end
        def remove(obj)
                obj.trigger(:remove);
                @list.delete(obj.id);
        end
        def initialize()
                @list={};
        end
end

$space=Space.new;
