require("./tool.rb");

class TimeBlock < Evented
        # TODO: Conditions of appearance...
        # TODO: Consequences...
        # TODO: History blocks for this block...

        def starttime
                @start
        end
        def endtime
                @end
        end
        def length
                @length
        end

        def inspect
                @name
        end

        def initialize(start,length,name:"unnamed")
                super();

                @name=name;

                @start=start;
                @end=start+length;
                @length=length;
        end
end

class GameTime
        def putblock(block)
                startfromnow=block.starttime-@now;
                if (startfromnow>0)
                        self.future=block;
                elsif (startfromnow+block.length>0)
                        self.active=block;
                else
                        self.history=block; # why would you do this - Also do we fire an end event if it already ended? no
                end
        end

        def active
                # Get active TimeBlocks
                @active
        end
        def active=(block)
                # Add stuff to active, in order.
                # Binary search here, TODO: benchmark different solutions

                block.eventFire("start");

                # check if we are skipping and need interpolation
                # This happens when delta is larger than our block length;
                # We are going to be skipping ahead of what has happened, sometimes quite large amounts.
                # Hence we let the block control this with the "skip" event.
                if (block.length<@delta)
                        #$MSGS="RIP! WE DID A SKIP! #{rand}";
                        block.eventFire("skip",@delta/block.length.to_f);
                end

                endtime=block.endtime;
                ind=@active.bsearch_index{ |x| x.endtime >= endtime; };

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

                #starttime=block.starttime;
                #ind=@history.bsearch_index{ |x| x.starttime >= starttime; };

                #if (ind==nil)
                #        @history.push(block);
                #else
                #        @history.insert(ind, block);
                #end
        end

        def future
                # Get future TimeBlocks
                @future
        end
        def future=(block)
                # Add stuff to future, in order.
                # Binary search here, TODO: benchmark different solutions

                starttime=block.starttime;
                ind=@future.bsearch_index{ |x| x.starttime >= starttime; };

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

                                # check if the next block(s) start
                                while (@future.length>0&&@now>@future[0].starttime)
                                        block=@future.shift;
                                        self.active=block;
                                end

                                # check if the next block(s) end
                                while (@active.length>0&&@now>@active[0].endtime)
                                        block=@active.shift;

                                        block.eventFire("end");
                                        #self.history=block;
                                end

                                sleep(1.0/60.0);
                        end
                }
        end
end

$time=GameTime.new;
