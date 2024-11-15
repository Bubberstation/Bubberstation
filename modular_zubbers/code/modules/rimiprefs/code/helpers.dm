/// An inexact color darken proc. Do not use if you need precise adjustments.
/proc/darken_color(color_to_darken)
	var/new_color = ""
	var/char
	var/ascii
	for(var/index = 1, index <= length(color_to_darken), index += length(char))
		char = color_to_darken[index]
		ascii = text2ascii(char)
		switch(ascii)
			if(48)
				new_color += "0"
			if(49 to 57)
				new_color += ascii2text(ascii-1) //numbers 1 to 9
			if(97)
				new_color += "9"
			if(98 to 102)
				new_color += ascii2text(ascii-1) //letters b to f lowercase
			if(65)
				new_color += "9"
			if(66 to 70)
				new_color += ascii2text(ascii+31) //letters B to F - translates to lowercase
			else
				break

	return new_color

/proc/center_blend_icon(icon/target, icon/source, x_dimension, y_dimension)
	if(!x_dimension || !y_dimension)
		return

	if((x_dimension == ICON_SIZE_X) && (y_dimension == ICON_SIZE_Y))
		return

	//Offset the image so that its bottom left corner is shifted this many pixels
	//This makes it infinitely easier to draw larger inhands/images larger than world.iconsize
	//but still use them in game
	var/x_offset = -((x_dimension / ICON_SIZE_X) - 1) * (ICON_SIZE_X * 0.5)
	var/y_offset = -((y_dimension / ICON_SIZE_Y) - 1) * (ICON_SIZE_Y * 0.5)

	//Correct values under icon_size
	if(x_dimension < ICON_SIZE_X)
		x_offset *= -1
	if(y_dimension < ICON_SIZE_Y)
		y_offset *= -1

	target.Blend(source, ICON_OVERLAY, x_offset, y_offset)
