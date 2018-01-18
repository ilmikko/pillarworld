module Tool
	module Resizable
		attr_reader :w,:h
		def w=(v);@w=v;change_wh;end
		def h=(v);@h=v;change_wh;end

		def wh;[@w,@h];end
		def wh=(wh);@w,@h=wh;change_wh;end

		# Alias longer names
		alias width w
		alias height h
		alias width= w=
		alias height= h=

		alias size wh
		alias size= wh=

		#########
		protected
		#########

		def change_wh;
			$console.log("#{self} change_wh");
			#clear;
			#fire('resize');
		end
	end
end
