/mob/living/carbon/human/examine(mob/user)
	.=..()
	if(!CONFIG_GET(flag/use_rr_opt_in_preferences) || !client)
		return
	var/rr_status = src.client.prefs.read_preference(/datum/preference/toggle/be_round_removed)
	. += span_info("Round Removal: <b><font color='[rr_status ? COLOR_RED : COLOR_EMERALD]'>[rr_status ? "Yes" : "No"]</font></b>")
