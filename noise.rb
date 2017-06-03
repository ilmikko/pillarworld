# I'm sorry

class Noise
        @@cache={};

        def seed
                @seed
        end

        def rng
                @rng
        end

        # PERLIN NOISE
        def grad(x,y)
                if (@@cache.key?(x))
                        if (@@cache[x].key?(y))
                                return @@cache[x][y];
                        end
                else
                        @@cache[x]={};
                end
                return @@cache[x][y]=[@rng.rand,@rng.rand];
        end
        def lerp(a,b,w)
                return w*b+(1.0-w)*a;
        end
        def dotGridGradient(ix,iy,x,y)
                dx=x-ix+0.5;
                dy=y-iy+0.5;
                return (dx*self.grad(ix,iy)[0]+dy*self.grad(ix,iy)[1]);
                #return (self.grad(ix,iy)[0]+self.grad(ix,iy)[1]);
        end
        def perlin(x,y)
                # Corner node coordinates
                x0=x.floor;
                x1=x0+1;
                y0=y.floor;
                y1=y0+1;

                # Interpolation weights (0..1)
                wx=x-x0;
                wy=y-y0;

                # Interpolate between grid point values
                n0=dotGridGradient(x0,y0,x,y);
                n1=dotGridGradient(x1,y0,x,y);
                ix0=lerp(n0,n1,wx);

                n0=dotGridGradient(x0,y1,x,y);
                n1=dotGridGradient(x1,y1,x,y);
                ix1=lerp(n0,n1,wx);

                return lerp(ix0,ix1,wy);
        end
        def initialize(seed=Random.new_seed)
                @seed=seed;
                @rng=Random.new(seed);
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
                delta=$noise.rng.rand*Math::PI*2;
                @xy=[Math.cos(delta)*radius,Math.sin(delta)*radius];
        end
end

$seed=12345;
$noise=Noise.new($seed);
