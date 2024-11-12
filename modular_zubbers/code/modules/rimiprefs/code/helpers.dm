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
