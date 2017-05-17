# Script for handling random pools in PW

class RandomPool
        def add(count=1)
                (1..count).each{
                        @count+=1;
                        Random.srand(@count);
                        @pool.push(@prng.rand());
                }
        end
        def fill(limit=64)
                count=@pool.count;
                if (count<limit)
                        self.add(limit-count);
                end
        end
        def get(count=1)
                self.add(count);
                @pool.shift(count);
        end
        def initialize(seed:Random.new_seed,pool:[],count:0)
                @seed=seed;
                @prng=Random.new(seed);
                @count=count;
                @pool=pool;
        end

        def save()
                return {seed:@seed,pool:@pool,count:@count};
        end
end
