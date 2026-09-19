/atom/proc/examine_title_worn(mob/user)
	var/regular_examine = src.examine_title(user)
	if(HAS_TRAIT_FROM(src, TRAIT_WORN_EXAMINE, TRAIT_SUBTREE_REQUIRED_OPERATIONAL_DATUM)) // Uses /datum/element/examined_when_worn
		return "<a href='byond://?src=[REF(src)];examine_loadout=1;'>[regular_examine]</a>"
	else
		return regular_examine

/mob/living/carbon/proc/get_flavor_text()
	var/flavor_text_link
	/// The first 1-FLAVOR_PREVIEW_LIMIT characters in the mob's "flavor_text" DNA feature. FLAVOR_PREVIEW_LIMIT is defined in flavor_defines.dm.
	var/preview_text = copytext_char((dna.features["flavor_text"]), 1, FLAVOR_PREVIEW_LIMIT)
	// What examine_tgui.dm uses to determine if flavor text appears as "Obscured".
	var/obscurity_examine_pref = (client?.prefs?.read_preference(/datum/preference/toggle/obscurity_examine))
	var/face_obscured = (covered_slots & HIDEFACE) && obscurity_examine_pref

	if (!(face_obscured))
		flavor_text_link = span_notice("[preview_text]... <a href='byond://?src=[REF(src)];lookup_info=open_examine_panel'>\[Look closer?\]</a>")
	else
		flavor_text_link = span_notice("<a href='byond://?src=[REF(src)];lookup_info=open_examine_panel'>\[Examine closely...\]</a>")
	return flavor_text_link


/atom/proc/get_chat_examine_headshot(mob/user)
	return null

/mob/living/carbon/human/get_chat_examine_headshot(mob/user)
	if(!user?.client)
		return null
	if(!user.client.prefs?.read_preference(/datum/preference/toggle/chat_examine_headshot))
		return null

	var/is_unidentified = is_face_obscured() && !length(get_id_name(""))
	if(is_unidentified)
		return null

	var/headshot = dna?.features?["headshot"]
	if(!length(headshot))
		return null

	var/obscurity_examine_pref = client?.prefs?.read_preference(/datum/preference/toggle/obscurity_examine)
	var/face_obscured = (covered_slots & HIDEFACE) && obscurity_examine_pref
	if(face_obscured && !isobserver(user))
		return null

	return "<div class='chat_headshot_top chat_headshot_frame'>[chat_headshot(html_encode(headshot))]</div>"


/mob/living/carbon/alien/get_flavor_text()
	return desc
