#define PURPLE_LIGHT "#9F79F2"
#define PURPLE_DARK "#6141A6"
#define ORANGE_LIGHT "#F27F1B"
#define ORANGE_DARK "#F24F13"
#define GREY_LIGHT "#FFFFFF"
#define GREY_DARK "#292929"

/datum/holiday/halloween
	name = HALLOWEEN
	begin_day = 17

/datum/holiday/halloween/New()
	. = ..()
	LAZYCLEARLIST(holiday_colors)
	var/palette = rand(1, 11)
	switch(palette)
		if(1, 2)
			holiday_colors += PURPLE_LIGHT
			holiday_colors += PURPLE_DARK
			holiday_colors += GREY_DARK
			holiday_colors += ORANGE_DARK
			holiday_colors += ORANGE_LIGHT
			holiday_colors += GREY_LIGHT
		if(3)
			holiday_colors += PURPLE_LIGHT
			holiday_colors += ORANGE_LIGHT
			holiday_colors += GREY_LIGHT
		if(4)
			holiday_colors += PURPLE_DARK
			holiday_colors += ORANGE_DARK
			holiday_colors += GREY_DARK
		if(5)
			holiday_colors += pick(GREY_LIGHT, GREY_DARK)
			holiday_colors += pick(PURPLE_LIGHT, PURPLE_DARK)
			holiday_colors += pick(ORANGE_LIGHT, ORANGE_DARK)
		if(6)
			holiday_colors += pick(GREY_LIGHT, GREY_DARK)
			holiday_colors += pick(PURPLE_LIGHT, PURPLE_DARK)
		if(7)
			holiday_colors += pick(GREY_LIGHT, GREY_DARK)
			holiday_colors += pick(ORANGE_LIGHT, ORANGE_DARK)
		if(8)
			holiday_colors += pick(PURPLE_LIGHT, PURPLE_DARK)
			holiday_colors += pick(ORANGE_LIGHT, ORANGE_DARK)
		if(9)
			holiday_colors += PURPLE_LIGHT
			holiday_colors += ORANGE_LIGHT
		if(10)
			holiday_colors += PURPLE_DARK
			holiday_colors += ORANGE_DARK
		if(11)
			holiday_colors += GREY_DARK
			holiday_colors += GREY_LIGHT

#undef PURPLE_LIGHT
#undef PURPLE_DARK
#undef ORANGE_LIGHT
#undef ORANGE_DARK
#undef GREY_LIGHT
#undef GREY_DARK

