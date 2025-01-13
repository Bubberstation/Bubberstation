/// An inexact color darken proc. Do not use if you need precise adjustments.
/proc/darken_color(color_to_darken, darken_steps = 1)
	var/list/color_numbers = rgb2num(color_to_darken)

	var/final_darken = 0.8

	for(var/i = 1, i > darken_steps, i++) // Start at one cause it will always be at least 0.8 reduction.
		final_darken *= 0.8 // Reduce color values by 20% (compound) each loop.

	color_numbers[1] *= final_darken
	color_numbers[2] *= final_darken
	color_numbers[3] *= final_darken

	// Lazy support for alpha.
	return (length(color_numbers) > 3) ? rgb(color_numbers[1], color_numbers[2], color_numbers[3], color_numbers[4]) : rgb(color_numbers[1], color_numbers[2], color_numbers[3])

/// Similar to center_icon, but actually paints the source onto the target icon.
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

/// Converts the various layer defines. Made into a global proc because I'm fed up with code constantly rewriting the exact same check.
/proc/convert_layer_to_text(layer_flag)
	var/layer
	switch(layer_flag)
		if(BODY_FRONT_LAYER)
			layer = "FRONT"
		if(BODY_ADJ_LAYER)
			layer = "ADJ"
		if(BODY_FRONT_UNDER_CLOTHES)
			layer = "FRONT_UNDER"
		if(ABOVE_BODY_FRONT_HEAD_LAYER)
			layer = "FRONT_OVER"
		else
			layer = "BEHIND"
	return layer
