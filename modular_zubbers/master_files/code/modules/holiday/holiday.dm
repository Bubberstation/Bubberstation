#define PURPLE_LIGHT "#9F79F2"
#define PURPLE_DARK "#6141A6"
#define ORANGE_LIGHT "#F27F1B"
#define ORANGE_DARK "#F24F13"
#define GREY_LIGHT "#FFFFFF"
#define GREY_DARK "#292929"

/datum/holiday/halloween
	name = HALLOWEEN
	begin_day = 17
	holiday_colors = list()

/datum/holiday/halloween/New()
	. = ..()
	var/palette = rand(1, 15)
	switch(palette)
		if(1, 2)
			holiday_colors += list(
				PURPLE_LIGHT,
				PURPLE_DARK,
				GREY_DARK,
				ORANGE_DARK,
				ORANGE_LIGHT,
				GREY_LIGHT,
				)
		if(3)
			holiday_colors += list(
				PURPLE_LIGHT,
				ORANGE_LIGHT,
				GREY_LIGHT,
				)
		if(4)
			holiday_colors += list(
				PURPLE_DARK,
				ORANGE_DARK,
				GREY_DARK,
				)
		if(5)
			holiday_colors += list(
				pick(GREY_LIGHT, GREY_DARK),
				pick(PURPLE_LIGHT, PURPLE_DARK),
				pick(ORANGE_LIGHT, ORANGE_DARK),
				)
		if(6)
			holiday_colors += list(
				pick(GREY_LIGHT, GREY_DARK),
				pick(PURPLE_LIGHT, PURPLE_DARK),
				)
		if(7)
			holiday_colors += list(
				pick(GREY_LIGHT, GREY_DARK),
				pick(ORANGE_LIGHT, ORANGE_DARK),
				)
		if(8)
			holiday_colors += list(
				pick(PURPLE_LIGHT, PURPLE_DARK),
				pick(ORANGE_LIGHT, ORANGE_DARK),
				)
		if(9)
			holiday_colors += list(PURPLE_LIGHT, ORANGE_LIGHT)
		if(10)
			holiday_colors += list(PURPLE_DARK, ORANGE_DARK)
		if(11)
			holiday_colors = list(
				COLOR_PRIDE_PURPLE,
				COLOR_PRIDE_BLUE,
				COLOR_PRIDE_GREEN,
				COLOR_PRIDE_YELLOW,
				COLOR_PRIDE_ORANGE,
				COLOR_PRIDE_RED,
			)
		if(12)
			holiday_colors += PURPLE_LIGHT
		if(13)
			holiday_colors += ORANGE_LIGHT
		if(14)
			holiday_colors += PURPLE_DARK
		if(15)
			holiday_colors += ORANGE_DARK

/datum/holiday/halloween/celebrate()
	. = ..()
	if(locate(/datum/round_event/spooky) in SSevents.running)
		return

	var/datum/round_event_control/spooky_scary = locate(/datum/round_event_control/spooky) in SSevents.control
	if(isnull(spooky_scary))
		return

	spooky_scary.run_event(admin_forced = TRUE)

#undef PURPLE_LIGHT
#undef PURPLE_DARK
#undef ORANGE_LIGHT
#undef ORANGE_DARK
#undef GREY_LIGHT
#undef GREY_DARK

