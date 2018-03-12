# 
# Caching test for views.
# A view does some internal organizations for writes in order to get a slight performance boost in high-fps situations.
# A best way to explain it is an example.
#
# Consider we want to display a festive line of characters, variating in green and red.
#
# The print calls, naively, would look like:
# \e[31m (put color to red)
# # (display one part of the line)
#       \e[32m (put color to green)
#       # (display the second part of the line)
#       \e[31m (put color to red again)
#       # (display the third part of the line)
#       ...and so on.
#
#       You can see there is a lot of repetition going on here.
#       What if there was a way to display the line instead as:
#       \e[31m (put color to red)
#       # # # # # # # (display all the odd parts of the line)
#       \e[32m (put color to green)
#        # # # # # # # (display all the even parts of the line)
#
#       This would reduce the number of ANSI calls by a significant amount.

view=View::Performance.new;

view.scene=->{
	w,h=view.wh;
	w-=1;
	h-=1;

	# christmasy decorations
	for y in 0..10
		for x in 0..w
			if x%2==0
				color=Screen::Color[:red];
			else
				color=Screen::Color[:green];
			end
			view.put(x,4+y,'#',color:color);
		end
	end

	view.put(0,0,'A');
	view.put(w,0,'B');
	view.put(0,h,'C');
	view.put(w,h,'D');
};
