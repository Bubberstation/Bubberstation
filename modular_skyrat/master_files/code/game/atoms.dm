// Stop All Animations nulls the mob's transform.
/atom/vv_do_topic(list/href_list)
	. = ..()
	if(href_list[VV_HK_STOP_ALL_ANIMATIONS] && check_rights(R_VAREDIT))
		var/mob/living/carbon/human/human_mob = src
		if(!istype(human_mob))
			return

/// Called after a loadout item gets custom named
/atom/proc/on_loadout_custom_named()
	return

/// Called after a loadout item gets a custom description
/atom/proc/on_loadout_custom_described()
	return
