class Evented
        def eventFire(name,*args)
                $console.mass("#{self} event fired: #{name}");
                if (@event.key? name)
                        begin
                                @event[name].dup.each{ |f|
                                        f.call(*args);
                                }
                        rescue StandardError => e
                                $console.error("EVENT: ERROR #{e}");
                        end
                else
                        $console.mass("No listener for event #{name}");
                end
        end
        def eventsListen(iterable)
                iterable.each{ |k,v|
                        self.eventListen(k.to_s,v);
                }
        end
        def eventListen(name,action)
                $console.mass("#{self} listening for #{name}");
                if (@event.key? name)
                        @event[name].push(action);
                else
                        @event[name]=[action];
                end
                $console.mass("#{@event[name]}");
        end
        def initialize()
                @event={};
        end
end

class IDd
        @@id=0;
        def id
                @id
        end
        def initialize()
                @id=@@id+=1;
        end
end

class VectorRandom
        def xy
                @xy
        end
        def x
                @xy[0]
        end
        def y
                @xy[1]
        end
        def initialize(radius=1)
                delta=$prng.rand()*Math::PI*2;
                @xy=[Math.cos(delta)*radius,Math.sin(delta)*radius];
        end
end

seed=12345;
$prng=Random.new(seed);
