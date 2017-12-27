def rgbcol(r,g,b)
	throw "r,g,b (#{[r,g,b]}) need to be in range 0..5" if r<0 or g<0 or b<0 or r>5 or g>5 or b>5;
	return 16 + r*36+g*6+b;
end

def rgb25(r,g,b)
	throw "r,g,b (#{[r,g,b]}) need to be in range 0..25" if r<0 or g<0 or b<0 or r>25 or g>25 or b>25;
	nr=r/5;
	ng=g/5;
	nb=b/5;

	if nr==ng and ng==nb and nr!=5
		# Use the more accurate grayscale map
		return 16 + 216 + r;
	else
		return 16 + nr*36+ng*6+nb;
	end
end

def rgbtrue(r,g,b)
	throw "r,g,b need to be in range 0..255" if r<0 or g<0 or b<0 or r>255 or g>255 or b>255;
	r/=51;
	g/=51;
	b/=51;
	return 16 + r*36+g*6+b;
end

def cycle(r,g,b,c=6)
	i = r*(c**2)+g*(c)+b+1;
	[(i/(c**2))%c,(i/c)%c,i%c]
end

puts("256 col greyscale palette");
for i in -24...0
	print("\e[7m\e[38;5;#{(i%255+1)}mxxx\e[m");
end
print("\e[7m\e[38;5;#{-24%255}mxxx\e[m");

print("\r\n");
r=g=b=0;
for i in 0..25
	r=g=b=i;
	print("\e[7m\e[38;5;#{rgb25(r,g,b)}m#{r.to_s(26)}#{g.to_s(26)}#{b.to_s(26)}\e[0m");
end

print("\r\n");
puts("256 col original");

r=g=b=0;
for r in 0..5
	for g in 0..5
		for b in 0..5
			print("\e[7m\e[38;5;#{rgbcol(r,g,b)}m#{r.to_s(26)}#{g.to_s(26)}#{b.to_s(26)}\e[0m");
		end
	end
	print("\r\n");
end

print("\r\n");
puts("256 col with palette (rgb24)");

r=g=b=0;
for r in (0..25).step(5)
	for g in (0..25).step(5)
		for b in (0..25).step(5)
			print("\e[7m\e[38;5;#{rgb25(r,g,b)}m#{r.to_s(26)}#{g.to_s(26)}#{b.to_s(26)}\e[0m");
		end
	end
	print("\r\n");
end

print("\r\n");
puts("True color palette");

r=g=b=0;
for r in (0..255).step(50)
	for g in (0..255).step(50)
		for b in (0..255).step(50)
			print("\e[7m\e[38;2;#{r};#{g};#{b}m#{r.to_s[0]}#{g.to_s[0]}#{b.to_s[0]}\e[0m");
		end
	end
	print("\r\n");
end
