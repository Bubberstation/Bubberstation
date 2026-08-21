//HUD Voting System. Ported from Monkestation 2.0 (#10369)

/atom/movable/screen/mapvote_hud
	name = "vote"
	icon = 'modular_zubbers/icons/hud/screen_vote.dmi'
	icon_state = "Glass_header"
	maptext_width = 96
	maptext_height = 32
	maptext_y = 5
	screen_loc = UI_VOTEHUD
	plane = SPLASHSCREEN_PLANE
	invisibility = INVISIBILITY_ABSTRACT
	var/user_preference = "Glass"
	var/list/atom/movable/screen/mapvote_button/buttons = list()
	var/atom/movable/screen/mapvote_button/last_choice
	var/list/selected_ranks = list()
	var/latest_vote_count
	var/latest_vote_length
	var/fade_timer
	var/hover_timer
	var/hovered = FALSE
	var/list/theme_colors = list(
		"Glass" = COLOR_THEME_GLASS,
		"Midnight" = COLOR_THEME_MIDNIGHT,
		"Retro" = COLOR_THEME_RETRO,
		"Plasmafire" = COLOR_THEME_PLASMAFIRE,
		"Slimecore" = COLOR_THEME_SLIMECORE,
		"Operative" = COLOR_THEME_OPERATIVE,
		"Trasen-Knox" = COLOR_THEME_TRASENKNOX,
		"Dectective" = COLOR_THEME_DETECTIVE,
		"Clockwork" = COLOR_THEME_CLOCKWORK,
		"Blue - 98" = "#fee9d4",
	)

/atom/movable/screen/mapvote_hud/Initialize(mapload, datum/hud/hud_owner, datum/preferences/preferences)
	. = ..()

	if(preferences)
		user_preference = preferences.read_preference(/datum/preference/choiced/ui_style)
		if(icon_exists(icon, "[user_preference]_header"))
			icon_state = "[user_preference]_header"
		else
			user_preference = initial(user_preference)

	if(isnewplayer(hud_owner?.mymob))
		screen_loc = UI_VOTEHUD_LEFT

	RegisterSignal(SSvote, COMSIG_VOTE_STARTED, PROC_REF(show))
	RegisterSignal(SSvote, COMSIG_VOTE_ENDED, PROC_REF(hide))

/atom/movable/screen/mapvote_hud/Destroy()
	UnregisterSignal(SSvote, list(COMSIG_VOTE_STARTED, COMSIG_VOTE_ENDED))
	hide()
	return ..()

/atom/movable/screen/mapvote_hud/update_overlays(total_bg_tiles = latest_vote_length)
	cut_overlays()
	. = ..()

	var/obj/effect/abstract/overlay_holder = new()
	overlay_holder.icon = icon
	overlay_holder.layer = layer
	overlay_holder.plane = plane

	for(var/index in 1 to total_bg_tiles)
		overlay_holder.pixel_y = index * -ICON_SIZE_Y
		overlay_holder.icon_state = "[user_preference]_middle"
		if(index == total_bg_tiles)
			overlay_holder.icon_state = "[user_preference]_bottom"
		add_overlay(overlay_holder)

	QDEL_NULL(overlay_holder)

/atom/movable/screen/mapvote_hud/proc/update_ui_style(new_ui_style)
	if(!icon_exists(icon, "[new_ui_style]_header"))
		new_ui_style = initial(user_preference)

	user_preference = new_ui_style
	icon_state = "[user_preference]_header"
	var/color_preference = theme_colors[user_preference] || "cyan"
	var/datum/vote/vote = SSvote.current_vote
	if(vote)
		var/text = "[vote.override_question ? vote.override_question : vote.name]"
		var/vote_type = "Multiple"
		if(latest_vote_count == VOTE_COUNT_METHOD_SINGLE)
			vote_type = "Single"
		else if(latest_vote_count == VOTE_COUNT_METHOD_RANKED)
			vote_type = "Ranked"
		text = "[text]\n[vote_type] choice"
		maptext = MAPTEXT("<div align='center' valign='top' style='position:relative;'><font color=[color_preference]>[text]</font></div>")
	for(var/atom/movable/screen/mapvote_button/button as anything in buttons)
		if(istype(button, /atom/movable/screen/mapvote_button/exit))
			button.icon_state = "[user_preference]_exit"
		else if(findtext(button.icon_state, "_wide"))
			button.icon_state = "[user_preference]_wide"
		else
			button.icon_state = "[user_preference]_button"
		button.update_theme_color(color_preference)
	update_overlays()

/atom/movable/screen/mapvote_hud/proc/fade_in(time = 0.3 SECONDS)
	if(fade_timer)
		deltimer(fade_timer)
		fade_timer = null

	animate(src)
	alpha = 0
	invisibility = INVISIBILITY_NONE
	animate(src, alpha = hovered ? 255 : 128, time = time, easing = EASE_OUT)

/atom/movable/screen/mapvote_hud/proc/set_hovered(is_hovered)
	if(is_hovered)
		if(hover_timer)
			deltimer(hover_timer)
			hover_timer = null
		if(hovered)
			return
		hovered = TRUE
		animate(src)
		animate(src, alpha = 255, time = 0.15 SECONDS, easing = EASE_OUT)
		return

	if(hover_timer)
		deltimer(hover_timer)
	hover_timer = addtimer(CALLBACK(src, PROC_REF(clear_hovered)), 0.1 SECONDS, TIMER_STOPPABLE | TIMER_CLIENT_TIME)

/atom/movable/screen/mapvote_hud/proc/clear_hovered()
	hover_timer = null
	if(!hovered)
		return
	hovered = FALSE
	animate(src)
	animate(src, alpha = 128, time = 0.15 SECONDS, easing = EASE_OUT)

/atom/movable/screen/mapvote_hud/MouseEntered(location, control, params)
	. = ..()
	set_hovered(TRUE)

/atom/movable/screen/mapvote_hud/MouseExited(location, control, params)
	. = ..()
	set_hovered(FALSE)

/atom/movable/screen/mapvote_hud/proc/fade_out(time = 0.3 SECONDS)
	if(fade_timer)
		deltimer(fade_timer)
	if(hover_timer)
		deltimer(hover_timer)
		hover_timer = null
	hovered = FALSE

	animate(src)
	animate(src, alpha = 0, time = time, easing = EASE_IN)

	fade_timer = addtimer(CALLBACK(src, PROC_REF(_finish_hide)), time, TIMER_STOPPABLE | TIMER_CLIENT_TIME)

/atom/movable/screen/mapvote_hud/proc/show()
	SIGNAL_HANDLER
	clear_buttons()
	fade_in()

	invisibility = INVISIBILITY_NONE
	var/datum/vote/vote = SSvote.current_vote
	latest_vote_count = vote.count_method
	var/choices = vote.choices
	latest_vote_length = length(choices)
	if(latest_vote_count == VOTE_COUNT_METHOD_RANKED)
		for(var/choice in choices)
			var/rank = vote.choices_by_ckey["[hud.mymob.ckey]_[choice]"]
			if(rank)
				selected_ranks[choice] = rank

	var/color_preference = theme_colors[user_preference] ? theme_colors[user_preference] : "cyan"
	var/text = "[vote.override_question ? vote.override_question : vote.name]"
	var/vote_type = "Multiple"
	if(latest_vote_count == VOTE_COUNT_METHOD_SINGLE)
		vote_type = "Single"
	else if(latest_vote_count == VOTE_COUNT_METHOD_RANKED)
		vote_type = "Ranked"
	text = "[text]\n[vote_type] choice"
	maptext = MAPTEXT("<div align='center' valign='top' style='position:relative;'><font color=[color_preference]>[text]</font></div>")
	maptext_y = -4

	// Find out if we need to use wide buttons or not. If any choice is longer than 16 characters, we use wide buttons.
	var/use_wide_buttons = FALSE
	for(var/choice in choices)
		if(length(choice) >= 16)
			use_wide_buttons = TRUE
			break

	// The spacing between buttons. If we're using wide buttons, we use the game's world.icon_size. Otherwise, we use a smaller value. 16(small) is half of 32 (wide), so it is safe.
	// Adjust '16' to whatever pixel height looks best for your small buttons
	var/spacing_y = use_wide_buttons ? ICON_SIZE_Y : 16
	// Current Y starts at -32 so that the first wide button is placed at -64 and then we subtract -32 again for every button after that.
	var/current_y = -32

	for(var/index in 1 to latest_vote_length)
		var/choice = choices[index]
		var/atom/movable/screen/mapvote_button/button = new(src, hud, choice, color_preference)
		if(vote.has_desc)
			button.desc = vote.return_desc(choice)

		if(use_wide_buttons)
			button.icon_state = "[user_preference]_wide"
		else
			button.icon_state = "[user_preference]_button"
			button.maptext_y = 7
		button.set_selected(!!selected_ranks[choice])

		button.pixel_x = 0 // keep buttons aligned to the center.
		button.pixel_y = current_y
		current_y -= spacing_y

		RegisterSignal(button, COMSIG_VOTE_CHOICE_SELECTED, PROC_REF(handle_vote_click))
		buttons += button
		vis_contents += button

	// bandage fix for the close button not being aligned to the bottom of the HUD when the number of buttons is not a multiple of 32.
	// honestly, if smaller 16px _bottom icons are used, this wouldn't be an issue, but that would have to check if wide buttons are used or not, and then check if the number of buttons is a multiple of 32, and then adjust the close button's position accordingly. This is a simpler solution.
	var/remainder = abs(current_y) % ICON_SIZE_Y
	if(remainder)
		current_y -= (ICON_SIZE_Y - remainder)

	// the exit button. It should be placed below the entire HUD.
	var/atom/movable/screen/mapvote_button/exit/button = new(src, hud)
	button.pixel_y = current_y
	RegisterSignal(button, COMSIG_VOTE_CHOICE_SELECTED, PROC_REF(handle_vote_click))
	buttons += button
	button.icon_state = "[user_preference]_exit"
	vis_contents += button

	// Calculate how many HUD icons we need to cover the entire HUD with the buttons in mind.
	// We divide by 32 (ICON_SIZE_Y) and round up to find out how many extra HUD icons we need.
	var/total_depth = abs(current_y) - ICON_SIZE_Y
	total_depth = max(total_depth, 0) // make sure total_depth is not negative.
	var/bg_tiles_needed = round((total_depth + (ICON_SIZE_Y - 1)) / ICON_SIZE_Y)

	update_overlays(bg_tiles_needed)

/atom/movable/screen/mapvote_hud/proc/hide()
	SIGNAL_HANDLER
	// unregister signals so clicking doesn't do anything while fading out
	for(var/atom/movable/screen/mapvote_button/button as anything in buttons)
		UnregisterSignal(button, COMSIG_VOTE_CHOICE_SELECTED)

	fade_out()

/atom/movable/screen/mapvote_hud/proc/_finish_hide()
	invisibility = INVISIBILITY_ABSTRACT
	last_choice = null
	fade_timer = null
	for(var/atom/movable/screen/mapvote_button/button as anything in buttons)
		vis_contents -= button
		qdel(button)

	buttons.Cut()
	selected_ranks.Cut()

/atom/movable/screen/mapvote_hud/proc/clear_buttons()
	for(var/atom/movable/screen/mapvote_button/button as anything in buttons)
		UnregisterSignal(button, COMSIG_VOTE_CHOICE_SELECTED)
		vis_contents -= button
		qdel(button)

	buttons.Cut()
	selected_ranks.Cut()
	last_choice = null

/atom/movable/screen/mapvote_hud/proc/handle_vote_click(datum/source, mob/user, atom/movable/screen/mapvote_button/button, choice)
	SIGNAL_HANDLER
	if(user != hud?.mymob)
		return

	if(isnull(choice))
		hide()
		return

	if(latest_vote_count == VOTE_COUNT_METHOD_SINGLE)
		if(last_choice && last_choice != button)
			last_choice.color = null
			last_choice.set_selected(FALSE)
		if(button.color)
			button.color = null
			button.set_selected(FALSE)
			last_choice = null
		else
			button.color = COLOR_VERY_PALE_LIME_GREEN
			button.set_selected(TRUE)
			last_choice = button

		SSvote.submit_single_vote(user, choice)
		if(user.client?.prefs?.read_preference(/datum/preference/toggle/mapvote_autoclose))
			hide()
			return
	else if(latest_vote_count == VOTE_COUNT_METHOD_RANKED)
		var/current_rank = selected_ranks[choice]
		if(current_rank)
			for(var/selected_choice in selected_ranks)
				var/rank = selected_ranks[selected_choice]
				if(rank > current_rank)
					selected_ranks[selected_choice] = rank - 1
					SSvote.submit_ranked_vote(user, selected_choice, rank - 1)
			selected_ranks[choice] = null
			SSvote.submit_ranked_vote(user, choice, 0)
		else
			var/max_rank = 0
			for(var/rank in selected_ranks)
				max_rank = max(max_rank, selected_ranks[rank])
			selected_ranks[choice] = max_rank + 1
			SSvote.submit_ranked_vote(user, choice, max_rank + 1)

		for(var/atom/movable/screen/mapvote_button/choice_button as anything in buttons)
			if(choice_button.choice)
				choice_button.color = selected_ranks[choice_button.choice] ? COLOR_VERY_PALE_LIME_GREEN : null
				choice_button.set_selected(!!selected_ranks[choice_button.choice])
	else
		if(button.color)
			button.color = null
			button.set_selected(FALSE)
		else
			button.color = COLOR_VERY_PALE_LIME_GREEN
			button.set_selected(TRUE)

		SSvote.submit_multi_vote(user, choice)
		last_choice = button

/atom/movable/screen/mapvote_button
	name = "map voting button"
	icon = 'modular_zubbers/icons/hud/screen_vote_buttons.dmi'
	icon_state = "Glass_button"
	plane = SPLASHSCREEN_PLANE
	mouse_over_pointer = MOUSE_HAND_POINTER
	maptext_height = 38
	maptext_width = 86
	maptext_x = 6
	var/choice
	var/theme_color
	var/selected

/atom/movable/screen/mapvote_button/Initialize(mapload, datum/hud/hud_owner, wanted_choice = null, color_preference = "cyan")
	. = ..()
	if(isnull(wanted_choice))
		return
	choice = wanted_choice
	theme_color = color_preference
	maptext = MAPTEXT("<div align='center' valign='middle' style='position:relative;'><font color='[color_preference]'>[choice]</font></div>")

/atom/movable/screen/mapvote_button/proc/set_selected(selected)
	src.selected = selected
	remove_filter("selected_outline")
	if(selected)
		add_filter("selected_outline", 1, list("type" = "outline", "size" = 1, "color" = theme_color))

/atom/movable/screen/mapvote_button/proc/update_theme_color(new_theme_color)
	theme_color = new_theme_color
	if(choice)
		maptext = MAPTEXT("<div align='center' valign='middle' style='position:relative;'><font color='[theme_color]'>[choice]</font></div>")
	set_selected(selected)

/atom/movable/screen/mapvote_button/Click(location, control, params)
	if(usr != hud?.mymob)
		return TRUE
	SEND_SIGNAL(src, COMSIG_VOTE_CHOICE_SELECTED, usr, src, choice)

/atom/movable/screen/mapvote_button/MouseEntered(location, control, params)
	. = ..()
	hud?.mapvote_hud?.set_hovered(TRUE)

	if(desc)
		openToolTip(usr, src, params, content = desc)

/atom/movable/screen/mapvote_button/MouseExited()
	hud?.mapvote_hud?.set_hovered(FALSE)
	closeToolTip(usr)

/atom/movable/screen/mapvote_button/exit
	name = "close vote"
	icon = 'modular_zubbers/icons/hud/screen_vote_buttons.dmi'
	icon_state = "Glass_exit"
	plane = SPLASHSCREEN_PLANE
	mouse_over_pointer = MOUSE_HAND_POINTER
