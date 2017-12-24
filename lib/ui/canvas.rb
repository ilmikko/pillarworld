# 
# UICanvas
# An UI wrapper for Canvas - mostly for static images. See also: UIView
#

class UI::Canvas < UI::Node
	def write(*args)
		@@screen.write(*args);
	end
end
