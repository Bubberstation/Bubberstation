/mob/living/carbon/human/examine(mob/user)
	.=..()
	if(!CONFIG_GET(flag/use_rr_opt_in_preferences))
		return
	var/effective_opt_in_level = mind?.get_effective_opt_in_level()
	var/stringified_optin = GLOB.rr_opt_in_strings["[effective_opt_in_level]"]
	. += span_info("Round Removal: <b><font color='[GLOB.rr_opt_in_colors[stringified_optin]]'>[stringified_optin]</font></b>")
