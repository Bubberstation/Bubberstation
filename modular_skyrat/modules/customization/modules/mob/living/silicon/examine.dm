/**
 *  Returns a list of lines containing silicon flavourtext, temporary flavourtext, ERP preferences and a link to "look closer" and open the examine panel.
 *  Intended to be appended at the end of examine() result.
 */
/mob/living/silicon/proc/get_silicon_flavortext(mob/user = null)
	. = list()
	var/flavor_text_link
	/// The first 1-FLAVOR_PREVIEW_LIMIT characters in the mob's client's silicon_flavor_text preference datum. FLAVOR_PREVIEW_LIMIT is defined in flavor_defines.dm.
	var/silicon_preview_text = copytext_char((client?.prefs.read_preference(/datum/preference/text/silicon_flavor_text)), 1, FLAVOR_PREVIEW_LIMIT)

	flavor_text_link = span_notice("[silicon_preview_text]... <a href='byond://?src=[REF(src)];lookup_info=open_examine_panel'>Look closer?</a>")

	if (flavor_text_link)
		. += flavor_text_link

	if(client)
		var/erp_status_pref = client.prefs.read_preference(/datum/preference/choiced/erp_status)
		var/free_use_pref = client.prefs.read_preference(/datum/preference/toggle/erp_free_use)
		if(erp_status_pref && !CONFIG_GET(flag/disable_erp_preferences))
			. += span_info("ERP Status: [span_revenboldnotice(erp_status_pref)][free_use_pref ? "[span_revenboldnotice(" - Free Use")]" : ""]")
		var/line = get_gender_attraction_string(client.prefs.read_preference(/datum/preference/choiced/display_gender), client.prefs.read_preference(/datum/preference/choiced/attraction))
		if(line)
			. += span_info(line)
	if(temporary_flavor_text)
		if(length_char(temporary_flavor_text) <= 40)
			. += span_notice("<b>They look different than usual:</b> [temporary_flavor_text]")
		else
			. += span_notice("<b>They look different than usual:</b> [copytext_char(temporary_flavor_text, 1, 37)]... <a href='byond://?src=[REF(src)];temporary_flavor=1'>More...</a>")

	if(iscyborg(src))
		var/mob/living/silicon/robot/robot = src
		if(robot.client?.prefs?.read_preference(/datum/preference/toggle/erp) && (!user || user.client?.prefs?.read_preference(/datum/preference/toggle/erp)))
			if(!robot.synthetic_genitals_hidden)
				if(robot.synthetic_penis)
					. += span_purple("[p_Their()] synthetic [robot.synthetic_penis_type] cock is exposed.")
				if(robot.synthetic_vagina)
					. += span_purple("[p_Their()] synthetic vagina is exposed.")
				if(robot.synthetic_breasts)
					. += span_purple("[p_Their()] synthetic breasts are exposed.")
				if(robot.synthetic_anus)
					. += span_purple("[p_Their()] synthetic anus is exposed.")
			if(robot.cum_on_body)
				. += span_purple("[p_They()] [p_are()] [robot.get_lewd_coverage_string(robot.cum_on_body)] [robot.get_lewd_fluid_string(robot.cum_on_body_type)].")
			if(robot.cum_in_vagina && !robot.synthetic_genitals_hidden)
				. += span_purple("[capitalize(robot.get_lewd_drip_text(robot.cum_in_vagina_type, robot.cum_in_vagina))] from [p_their()] slit.")
			if(robot.cum_in_anus && !robot.synthetic_genitals_hidden)
				. += span_purple("[capitalize(robot.get_lewd_drip_text(robot.cum_in_anus_type, robot.cum_in_anus))] from [p_their()] rear.")

/mob/living/silicon/get_chat_examine_headshot(mob/user)
	if(!client?.prefs || !user?.client?.prefs)
		return null
	if(!user.client.prefs.read_preference(/datum/preference/toggle/chat_examine_headshot))
		return null

	var/headshot = client.prefs.read_preference(/datum/preference/text/headshot/silicon)
	if(!length(headshot))
		return null

	return "<div class='chat_headshot_top chat_headshot_frame'>[chat_headshot(html_encode(headshot))]</div>"
