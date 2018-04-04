# 
# UIBorder
# An UIPadding with a visible display.
#
class UI::Border < UI::Padding
	# Lines
	@@default_lines='─│─│'.split(//);
	def line_n;@lines[0];end
	def line_n=(v);@lines[0]=v;end
	def line_e;@lines[1];end
	def line_e=(v);@lines[1]=v;end
	def line_s;@lines[2];end
	def line_s=(v);@lines[2]=v;end
	def line_w;@lines[3];end
	def line_w=(v);@lines[3]=v;end

	# Corners
	@@default_corners='┌┐└┘'.split(//);
	def corner_nw;@corners[0];end
	def corner_nw=(v);@corners[0]=v;end
	def corner_ne;@corners[1];end
	def corner_ne=(v);@corners[1]=v;end
	def corner_sw;@corners[2];end
	def corner_sw=(v);@corners[2]=v;end
	def corner_se;@corners[3];end
	def corner_se=(v);@corners[3]=v;end

	# Double straight lines (where the border is only 1 char long)
	@@default_doubles='─│'.split(//);
	def double_h;@doubles[0];end
	def double_h=(v);@doubles[0]=v;end
	def double_v;@doubles[1];end
	def double_v=(v);@doubles[1]=v;end

	# Caps (where the border is only 1 char long) and dot (1x1)
	@@default_caps='╷╶╵╴∙'.split(//);
	def cap_n;@caps[0];end
	def cap_n=(v);@caps[0]=v;end
	def cap_e;@caps[1];end
	def cap_e=(v);@caps[1]=v;end
	def cap_s;@caps[2];end
	def cap_s=(v);@caps[2]=v;end
	def cap_w;@caps[3];end
	def cap_w=(v);@caps[3]=v;end

	def dot;@caps[4];end
	def dot=(v);@caps[4]=v;end

	# Line shorthands
	def line_h=(v);
		self.double_h=
			self.line_n=
			self.line_s=v;
	end
	def line_v=(v);
		self.double_v=
			self.line_e=
			self.line_w=v;
	end

	# Corner shorthand
	def corner=(v);
		self.cap_n=
			self.cap_e=
			self.cap_s=
			self.cap_w=
			self.corner_nw=
			self.corner_ne=
			self.corner_sw=
			self.corner_se=v;
	end

	# Line shorthand
	def line=(v);
		self.line_h=
			self.line_v=v;
	end

	def border=(v);
		self.corner_nw=
			self.corner_ne=
			self.corner_sw=
			self.corner_se=
			self.line_n=
			self.line_e=
			self.line_s=
			self.line_w=v;
	end

	def redraw;
		$console.log("Border redrawing");
		w,h=@wh;
		x,y=@xy;
		$console.log("Border #{self} pos: #{@xy} size: #{@wh}");

		# corners
		nw=[x,y];
		ne=[(x+w-1),y];
		se=[(x+w-1),(y+h-1)];
		sw=[x,(y+h-1)];

		if w>1 && h>1
			# Full draw

			# Draw lines
			# n
			@@view.hline(*nw,w,char: @lines[0]);
			# s
			@@view.hline(*sw,w,char: @lines[2]);
			# w
			@@view.vline(*nw,h,char: @lines[3]);
			# e
			@@view.vline(*ne,h,char: @lines[1]);

			# Draw corners
			# nw
			@@view.put(*nw,@corners[0]);
			# ne
			@@view.put(*ne,@corners[1]);
			# sw
			@@view.put(*sw,@corners[2]);
			# se
			@@view.put(*se,@corners[3]);

		elsif h==1 && w>1
			# Do not draw corners, draw caps
			@@view.hline(*nw,w,char: @doubles[0]);
			@@view.put(*nw,@caps[1])
			@@view.put(*ne,@caps[3])
		elsif w==1 && h>1
			# Do not draw corners, draw caps
			@@view.vline(*nw,h,char: @doubles[1]);
			@@view.put(*nw,@caps[0])
			@@view.put(*sw,@caps[2])
		elsif w==1 && h==1
			@@view.put(*nw,@caps[4]);
		end
		# Else draw nothing

		super; # remember to draw the child (invoking UI::Array)
	end

	# Use ww instead of w because w is width
	def initialize(border:nil, corner:nil, line:nil, horizontal:nil, vertical:nil,	# Shorthands
								 nw:nil, ne:nil, sw:nil, se:nil,  				# Corners
								 nn:nil, ss:nil, ee:nil, ww:nil,  				# Lines
								 dh:nil, dv:nil, 							# Doubles
								 cn:nil, cs:nil, ce:nil, cw:nil,					# Caps
								 dot:nil,								# Dot
								 **_)
		super(**_);

		@lines=@@default_lines.dup;
		@corners=@@default_corners.dup;
		@doubles=@@default_doubles.dup;
		@caps=@@default_caps.dup;

		# The border consists of the following 'elements':
		#
		# border:
		# 	corner:
		# 		nw:
		# 			Northwest corner
		# 		ne:
		# 			Northeast corner
		# 		sw:
		# 			Southwest corner
		# 		se:
		# 			Southeast corner
		# 	line:
		# 		horizontal:
		#	 		nn:
		#	 			North line
		#	 		ss:
		#	 			South line
		#	 	vertical:
		# 			ee:
		# 				East line
		# 			ww:
		# 				West line

		# Going from large to small
		self.border=border if !border.nil?;

		# Shorthands
		self.corner=corner if !corner.nil?;
		self.line=line if !line.nil?;

		# Line shorthands
		self.line_h=horizontal if !horizontal.nil?;
		self.line_v=vertical if !vertical.nil?;

		# Doubles
		self.double_h=dh if !dh.nil?;
		self.double_v=dv if !dv.nil?;

		# Caps
		self.cap_n=cn if !cn.nil?;
		self.cap_s=cs if !cs.nil?;
		self.cap_e=ce if !ce.nil?;
		self.cap_w=cw if !cw.nil?;
		self.dot=dot if !dot.nil?;

		# Corners
		self.corner_nw=nw if !nw.nil?;
		self.corner_ne=ne if !ne.nil?;
		self.corner_sw=sw if !sw.nil?;
		self.corner_se=se if !se.nil?;

		# Lines
		self.line_n=nn if !nn.nil?;
		self.line_s=ss if !ss.nil?;
		self.line_e=ee if !ee.nil?;
		self.line_w=ww if !ww.nil?;

		#$console.log(@nesw);
	end
end
