require("./tool.rb");

class TimeSection
        def starttime
                @starttime
        end
        def endtime
                @endtime
        end
        def length
                @length
        end

        def inspect
                [@starttime,@endtime]
        end

        def eventEnd
                @eventEnd
        end
        def eventIter
                @eventIter
        end
        # starttime: *absolute* time when this section starts
        # length: How many milliseconds this section runs for

        # eventIter: What to run when the section is running
        # eventEnd:  What to run when this section has ended
        def initialize(starttime,length:0,eventEnd:nil,eventIter:nil)
                @starttime=starttime;
                @length=length;
                @endtime=@starttime+@length;

                @eventEnd=eventEnd;
                @eventIter=eventIter;
        end
end

class TimeBlock
        # TODO: Conditions of appearance...
        # TODO: Consequences...
        # TODO: History blocks for this block...

        def sections
                @sections
        end

        def starttime
                @starttime
        end
        def length
                @length
        end

        def initialize(starttime,sections)
                @starttime=starttime;

                @sections=[];
                sections.each{ |t|
                        ts=TimeSection.new(starttime,t);
                        @sections.push(ts);
                        starttime+=ts.length;
                }

                @length=@sections.sum{|v| v.length};
                $console.log("Total length: #{@length}");
        end
end

class GameTime
        def putblock(block)
                startfromnow=block.starttime-@now;
                if (startfromnow+block.length>0)
                        self.future=block;
                else
                        self.history=block; # why would you do this - Also do we fire an end event if it already ended? no
                end
        end

        def active
                # Get active TimeBlocks
                @active
        end
        def active=(sect)
                # Add stuff to active, in order.
                # Binary search here, TODO: benchmark different solutions

                #block.eventFire("start");

                # check if we are skipping and need interpolation
                # This happens when delta is larger than our block length;
                # We are going to be skipping ahead of what has happened, sometimes quite large amounts.
                # Hence we let the block control this with the "skip" event.
                #if (block.length<@delta)
                        #$MSGS="RIP! WE DID A SKIP! #{rand}";
                #        block.eventFire("skip",@delta/block.length.to_f);
                #end

                endtime=sect.endtime;
                ind=@active.bsearch_index{ |x| x.endtime >= endtime; };

                if (ind==nil)
                        @active.push(sect);
                else
                        @active.insert(ind, sect);
                end

                if (sect.eventIter)
                        ind=@active_iter.bsearch_index{ |x| x.endtime >= endtime; };

                        if (ind==nil)
                                @active_iter.push(sect);
                        else
                                @active_iter.insert(ind, sect);
                        end
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

                block.sections.each{ |s|
                        starttime=s.starttime;
                        ind=@future.bsearch_index{ |x| x.starttime >= starttime; };

                        if (ind==nil)
                                @future.push(s);
                        else
                                @future.insert(ind, s);
                        end
                }
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

                @active_iter=[];
                @active=[];
                @future=[];
                @history=[];

                Thread.new {
                        begin
                                while true
                                        @now+=@delta;

                                        # check if the next section(s) start
                                        while (@future.length>0&&@now>@future[0].starttime)
                                                sect=@future.shift;
                                                self.active=sect;
                                        end

                                        if (@active.length>0)
                                                # end active sections that need ending
                                                while (@active.length>0&&@now>@active[0].endtime)
                                                        sect=@active.shift;

                                                        # 'Children' cleanup
                                                        if (sect.eventIter)
                                                                @active_iter.shift;
                                                        end

                                                        if (sect.eventEnd)
                                                                sect.eventEnd.call();
                                                        end
                                                end

                                                # update iters for sections that didn't end
                                                if (@active_iter.length>0)
                                                        @active_iter.dup.each{ |s|
                                                                s.eventIter.call(1.0-(s.endtime-@now)/s.length.to_f);
                                                        }
                                                end
                                        end

                                        sleep(1.0/60.0);
                                end
                        rescue StandardError => e
                                $console.error("TIME ERROR: #{e}");
                        end
                }
        end
end

$time=GameTime.new;
