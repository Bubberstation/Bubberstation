/datum/antagonist/ert/families
	name = "Space Police Responder"
	antag_hud_name = "hud_spacecop"
	suicide_cry = "FOR THE SPACE POLICE!!"

/datum/antagonist/ert/families/apply_innate_effects(mob/living/mob_override)
	..()
	var/mob/living/M = mob_override || owner.current
	if(M.hud_used)
		var/datum/hud/H = M.hud_used
		var/atom/movable/screen/wanted/giving_wanted_lvl = new /atom/movable/screen/wanted()
		H.wanted_lvl = giving_wanted_lvl
		giving_wanted_lvl.hud = H
		H.infodisplay += giving_wanted_lvl
		H.mymob.client.screen += giving_wanted_lvl


/datum/antagonist/ert/families/remove_innate_effects(mob/living/mob_override)
	var/mob/living/M = mob_override || owner.current
	if(M.hud_used)
		var/datum/hud/H = M.hud_used
		H.infodisplay -= H.wanted_lvl
		QDEL_NULL(H.wanted_lvl)
	..()

/datum/antagonist/ert/families/greet()
	. = ..()
	var/missiondesc
	missiondesc += "<BR><B><font size=5 color=red>You are NOT a Nanotrasen Employee. You work for the local government.</font></B>"
	missiondesc += "<BR><B><font size=5 color=red>You are NOT a deathsquad. You are here to help innocents escape violence, criminal activity, and other dangerous things.</font></B>"
	missiondesc += "<BR>After an uptick in gang violence on [station_name()], you are responding to emergency calls from the station for immediate SSC Police assistance!\n"
	missiondesc += "<BR><B>Your Mission</B>:"
	missiondesc += "<BR> <B>1.</B> Serve the public trust."
	missiondesc += "<BR> <B>2.</B> Protect the innocent."
	missiondesc += "<BR> <B>3.</B> Uphold the law."
	missiondesc += "<BR> <B>4.</B> Find the Undercover Cops."
	missiondesc += "<BR> <B>5.</B> Detain Nanotrasen Security personnel if they harm any citizen."
	missiondesc += "<BR> You can <B>see gangsters</B> using your <B>special sunglasses</B>.</span>"
	to_chat(owner,missiondesc)
	var/policy = get_policy(ROLE_FAMILIES)
	if(policy)
		to_chat(owner, policy)
	var/mob/living/M = owner.current
	M.playsound_local(M, 'sound/effects/families_police.ogg', 100, FALSE, pressure_affected = FALSE, use_reverb = FALSE)

/datum/antagonist/ert/families/undercover_cop
	name = "Undercover Cop"
	role = "Undercover Cop"
	outfit = /datum/outfit/families_police/beatcop
	plasmaman_outfit = /datum/outfit/plasmaman/security
	var/free_clothes = list(/obj/item/clothing/glasses/hud/spacecop/hidden,
						/obj/item/clothing/under/rank/security/officer/beatcop,
						/obj/item/clothing/head) //DEBUG: Placeholder head clothing. Replace this with something appropriate
	forge_objectives_for_ert = FALSE
	equip_ert = FALSE
	random_names = FALSE

/datum/antagonist/ert/families/undercover_cop/on_gain()
	if(istype(owner.current, /mob/living/carbon/human))
		for(var/C in free_clothes)
			var/obj/O = new C(owner.current)
			var/list/slots = list (
				"backpack" = ITEM_SLOT_BACK,
				"left pocket" = ITEM_SLOT_LPOCKET,
				"right pocket" = ITEM_SLOT_RPOCKET
			)
			var/mob/living/carbon/human/H = owner.current
			var/equipped = H.equip_in_one_of_slots(O, slots)
			if(!equipped)
				to_chat(owner.current, "<span class='warningplain'>Unfortunately, you could not bring your [O] to this shift. You will need to find one.</span>")
				qdel(O)
	. = ..()


/datum/antagonist/ert/families/undercover_cop/greet()
	var/missiondesc = "<span class='warningplain'><B><font size=3 color=red>You are the [name].</font></B>"
	missiondesc += "<BR><B><font size=3 color=red>You are NOT a Nanotrasen Employee. You work for the local government.</font></B>"
	missiondesc += "<BR>You are an undercover police officer on board [station_name()]. You've been sent here by the Spinward Stellar Coalition because of suspected abusive behavior by the security department, and to keep tabs on a potential criminal organization operation."
	missiondesc += "<BR><B>Your Mission</B>:"
	missiondesc += "<BR> <B>1.</B> Keep a close eye on any gangsters you spot. You can view gangsters using your sunglasses in your backpack."
	missiondesc += "<BR> <B>2.</B> Keep an eye on how Security handles any gangsters, and watch for excessive security brutality."
	missiondesc += "<BR> <B>3.</B> Remain undercover and do not get found out by Security or any gangs. Nanotrasen does not take kindly to being spied on."
	missiondesc += "<BR> <B>4.</B> When your backup arrives to extract you in 1 hour, inform them of everything you saw of note, and assist them in securing the situation.</span>"
	to_chat(owner,missiondesc)

/datum/antagonist/ert/families/beatcop
	name = "Beat Cop"
	role = "Police Officer"
	outfit = /datum/outfit/families_police/beatcop

/datum/antagonist/ert/families/beatcop/armored
	name = "Armored Beat Cop"
	role = "Police Officer"
	outfit = /datum/outfit/families_police/beatcop/armored

/datum/antagonist/ert/families/beatcop/swat
	name = "S.W.A.T. Member"
	role = "S.W.A.T. Officer"
	outfit = /datum/outfit/families_police/beatcop/swat

/datum/antagonist/ert/families/beatcop/fbi
	name = "FBI Agent"
	role = "FBI Agent"
	outfit = /datum/outfit/families_police/beatcop/fbi

/datum/antagonist/ert/families/beatcop/military
	name = "Space Military"
	role = "Sergeant"
	outfit = /datum/outfit/families_police/beatcop/military

/datum/antagonist/ert/families/beatcop/military/New()
	. = ..()
	name_source = GLOB.commando_names
