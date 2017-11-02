require('../console.rb');
require('../screen.rb');
require('../input.rb');

# Astar algorithm, custom weights
# Controls:
# hjkl to move
# space to place obstacles
# x to remove them
#
# m to load map from ./map.txt
#
# enter to solve one iteration
# a to solve all
#
# e to place end point
# s to place start point

def render
	$world.render;
end

class Point
	def char;@char;end
	def color;@color;end

	def x;@xy[0];end
	def y;@xy[1];end
	def x=(v);@xy[0]=v;end
	def y=(v);@xy[1]=v;end

	def xy;@xy;end
	def xy=(v);@xy=v;end

	def initialize(x=0,y=0,char: '.',color: nil)
		@xy=[x,y];
		@char=char;
		@color=color;
	end
end

class Block < Point
	def initialize(x,y)
		super(x,y,char:"X");
	end
end

class Mark < Point
	def initialize(x,y)
		super(x,y,char:"#",color:"\e[033m");
	end
end

class Path < Point
	def initialize(x,y)
		super(x,y,char:"!",color:"\e[034m");
	end
end

class StartPoint < Point
	def initialize(x,y)
		super(x,y,char:'S',color:"\e[032m");
	end
end

class EndPoint < Point
	def initialize(x,y)
		super(x,y,char:'E',color:"\e[031m");
	end
end

class PossibleLocation < Point
	def score;@score;end
	def path;@path;end
	def initialize(x,y,score: 0,path:[])
		super(x,y,char: '');
		@score=score;
		@path=path;
	end
end

class Actor < Point
	@@bias=2;
	def checked?(x,y)
		return @checked[x]!=nil&&@checked[x][y]==true;
	end
	def check(x,y)
		@checked[x]={} if !@checked.key?x;
		@checked[x][y]=true;
	end
	def getOwnScore(x,y)
		@list[x]={} if !@list.key?x;
		@list[x][y]=PossibleLocation.new(x,y) if !@list[x].key?y;
		return @list[x][y].score;
	end
	def getOwnPath()
		@list[x]={} if !@list.key?x;
		@list[x][y]=PossibleLocation.new(x,y) if !@list[x].key?y;
		return @list[@xy[0]][@xy[1]].path;
	end
	def addToList(x,y)
		score=Math::sqrt((@xy[0]-x)**2+(@xy[1]-y)**2)+getOwnScore(*@xy);
		path=getOwnPath()+[[x,y]];
		@list[x]={} if !@list.key?x;
		@list[x][y]=PossibleLocation.new(x,y, score: score, path: path);
	end
	def iteration
		failure=goTo(*$endpoint.xy)==false;
		if @xy==$endpoint.xy
			# Successful path
			$world.layers.delete(1);
			@list[@xy[0]][@xy[1]].path.each{|x,y|
				$world.add(Path.new(x,y),layer:1);
			};
			return true;
		else
			if failure
				$world.layers.delete(1);
				return true;
			else
				return false;
			end
		end
	end
	def goTo(x,y)
		if (@xy==[x,y])
			return false;
		end
		# find near objects that we can move to
		for dx in -1..1
			for dy in -1..1
				next if dx==0&&dy==0;
				x=@xy[0]+dx;
				y=@xy[1]+dy;

				if (!$world.blocked?(x,y))
					addToList(x,y);
				end
			end
		end

		# find the best item in the list
		sorted=[];

		@list.each{ |x,v|
			v.each{ |y,v|
				sorted.push({xy:v.xy,score:v.score+$world.getScore(x,y)*@@bias});
			}
		};

		sorted=sorted.sort{|a,b| a[:score]-b[:score]; }

		nextpos=nil;
		while true
			if sorted.length==0
				$console.error("Cannot find a path!");
				return false;
			end
			nextpos=sorted.shift;
			# check if we have already checked this location, if yes, then remove
			new=!checked?(*nextpos[:xy]);

			check(*nextpos[:xy]);

			if new
				break;
			end
		end

		# Leave a mark on the world (literally)
		$world.add(Mark.new(*@xy));
		self.xy=nextpos[:xy];
	end

	def initialize(x,y)
		super(x,y,char:"A",color:"\e[034m");
		@list={};
		@checked={};
	end

	#######
	private
	#######
end

class Cursor < Point
	def initialize()
		super(0,0,char:'+');
	end
end

class World
	def layers;@layers;end

	def clear
		@blocked={};
		@layers[5]=[];
	end

	def load(str)
		clear;
		x=0;y=0;
		str.split(//).each{|char|
			if (char==" ")
			elsif (char=="\n")
				y+=1;
				x=-1;
			elsif (char=="\r")
				x=-1;
			elsif (char=="#")
				block(x,y);
			elsif (char=="S")
				self.startPoint=[x,y];
			elsif (char=="E")
				self.endPoint=[x,y];
			end
			x+=1;
		}
		render;
	end

	def add(*args,layer: 0)
		@layers[layer]=[] if !@layers[layer];
		@layers[layer].push(*args);
	end

	def startPoint=(v)
		@layers.delete(11);
		add($startpoint=StartPoint.new(*v),layer:11);

		@layers.delete(2);
		add($actor=Actor.new(*v),layer:2);
		render
	end
	def endPoint=(v)
		@layers.delete(12);
		add($endpoint=EndPoint.new(*v),layer:12);
		render
	end

	def getScore(x,y)
		return Math::sqrt(($endpoint.x-x)**2+($endpoint.y-y)**2);
	end

	def blocked?(x,y)
		return true if (x<0||y<0);
		return true if (x>=@screen.width||y>=@screen.height);
		return @blocked.key?(x) && @blocked[x].key?(y);
	end

	def block(x,y)
		@blocked[x]={} if !@blocked.key?x;
		@layers[5]=[] if !@layers[5];
		return if @blocked[x][y];

		@blocked[x][y]=true;
		@layers[5].push(Block.new(x,y));
	end

	def unblock(x,y)
		return if !@blocked.key?x;
		return if !@blocked[x].key?y;
		@blocked[x].delete(y);
		@layers[5].select!{|block|
			if (block.xy==[x,y])
				false
			else
				true
			end
		}
	end

	def initialize(screen)
		@layers={};
		@blocked={};
		@screen=screen;
	end
	def render
		@screen.clear();
		@layers.each{ |k,l|
			l.each{|o|
				@screen.write(*o.xy,o.char,color:o.color);
			}
		}
	end
end

$world=World.new($screen);
$world.startPoint=[1,1];
$world.endPoint=[$screen.width-2,$screen.height-2];

$world.add($cursor=Cursor.new,layer:10);

$input.listen({
	'h':->{ $cursor.x-=1;render; },
	'j':->{ $cursor.y+=1;render; },
	'k':->{ $cursor.y-=1;render; },
	'l':->{ $cursor.x+=1;render; },
	'[D':->{ $cursor.x-=1;render; },
	'[B':->{ $cursor.y+=1;render; },
	'[A':->{ $cursor.y-=1;render; },
	'[C':->{ $cursor.x+=1;render; },
	'e':->{
		$world.endPoint=$cursor.xy;
	},
	's':->{
		$world.startPoint=$cursor.xy;
	},
	' ':->{
		$world.block(*$cursor.xy);
		render;
	},
	'x':->{
		$world.unblock(*$cursor.xy);
		render;
	},
	'm':->{
		$world.load(File.read('map.txt'));
	},
	'a':->{
		iterations_between_renders=100;
		iteration=0;
		while iteration+=1;
			if iteration>iterations_between_renders
				render;
				iteration=0;
			end
			break if $actor.iteration();
		end
		render;
	},
	'':->{
		$actor.iteration();
		render;
	}
});

render;

sleep
