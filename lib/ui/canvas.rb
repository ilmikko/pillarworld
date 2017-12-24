# 
# UICanvas
# An UI wrapper for Canvas - mostly for static images. See also: UIView
#

class UI::Canvas < UI::Node
	def write(*args)
		@@canvas.write(*args);
	end
end
