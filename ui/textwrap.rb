require('./ui.rb');

$ui.show(
	UIAlign.new.append(
		UIBorder.new(width:40,height:11).append(
			UIAlign.new(horizontalalign: :right, verticalalign: :top).append(
				#UIParagraph.new('Mental images: sometimes we seem to evoke visual images in "mind\'s eye". Subjective experience suggests visual image is separate from propositions. In imagining a scene: For example, search a box of blocks for 3cm cube with two adjacent blue sides. But not so many properties as would be present in a real visual scene - support, illumination, shading, shadows on near surfaces... So the intuition suggests that mind\'s eye mimics visual perception.')
				UIParagraph.new('Test')
			)
		)
	)
);

sleep
