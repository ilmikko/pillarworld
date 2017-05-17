class TimeBlock
        # TODO: Conditions of appearance...
        # TODO: Consequences...
        # TODO: History blocks for this block...

        def start
                @start
        end
        def length
                @length
        end
        def end
                @end
        end

        def inspect
                @name
        end

        def initialize(start,length,name:"unnamed")
                @name=name;
                @start=start;
                @length=length;
                @end=start+length;
        end
end

class GameTime
        def newblock(startfromnow,*others)
                block=TimeBlock.new(@now+startfromnow,*others);

                if (startfromnow>0)
                        self.future=block;
                elsif (startfromnow+length<0)
                        self.active=block;
                else
                        self.history=block; # why would you do this
                end
        end

        def active
                # Get active TimeBlocks
                @active
        end
        def active=(block)
                # Add stuff to active, in order.
                # Binary search here, TODO: benchmark different solutions

                blend=block.end;
                ind=@active.bsearch_index{ |x| x.end >= blend; };

                if (ind==nil)
                        @active.push(block);
                else
                        @active.insert(ind, block);
                end
        end
        def history
                # Get past TimeBlocks
                @history
        end
        def history=(block)
                # Add stuff to history, in order.
                # Binary search here, TODO: benchmark different solutions

                start=block.start;
                ind=@history.bsearch_index{ |x| x.start >= start; };

                if (ind==nil)
                        @history.push(block);
                else
                        @history.insert(ind, block);
                end
        end

        def future
                # Get future TimeBlocks
                @future
        end
        def future=(block)
                # Add stuff to future, in order.
                # Binary search here, TODO: benchmark different solutions

                start=block.start;
                ind=@future.bsearch_index{ |x| x.start >= start; };

                if (ind==nil)
                        @future.push(block);
                else
                        @future.insert(ind, block);
                end
        end

        def now
                # Game time
                @now
        end
        def delta
                @delta
        end
        def delta=(v)
                @delta=v;
        end

        def initialize
                @now=0;
                @delta=1000/60;

                @active=[];
                @future=[];
                @history=[];

                Thread.new {
                        while true
                                @now+=@delta;

                                # check if an event starts
                                while (@future.length>0&&@now>@future[0].start)
                                        self.active=@future.shift;
                                end

                                # check if an event ends
                                while (@active.length>0&&@now>@active[0].end)
                                        self.history=@active.shift;
                                end

                                sleep(1.0/60.0);
                        end
                }
        end
end

$time=GameTime.new;
