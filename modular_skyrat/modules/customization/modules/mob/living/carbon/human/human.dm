/mob/living/carbon/human/Topic(href, href_list)
	. = ..()

	if(href_list["lookup_info"])
		switch(href_list["lookup_info"])
			if("genitals")
				var/list/line = list()
				for(var/genital in GLOB.possible_genitals)
					if(!dna.species.mutant_bodyparts[genital])
						continue
					var/datum/sprite_accessory/genital/G = SSaccessories.sprite_accessories[genital][dna.species.mutant_bodyparts[genital][MUTANT_INDEX_NAME]]
					if(!G)
						continue
					if(G.is_hidden(src))
						continue
					var/obj/item/organ/genital/ORG = get_organ_slot(G.associated_organ_slot)
					if(!ORG)
						continue
					line += ORG.get_description_string(G)
				if(length(line))
					to_chat(usr, span_notice("[jointext(line, "\n")]"))
			if("open_examine_panel")
				tgui.holder = src
				tgui.ui_interact(usr) //datum has a tgui component, here we open the window

/mob/living/carbon/human/species/vox
	race = /datum/species/vox

/mob/living/carbon/human/species/vox_primalis
	race = /datum/species/vox_primalis

/mob/living/carbon/human/species/synth
	race = /datum/species/synthetic

/mob/living/carbon/human/species/mammal
	race = /datum/species/mammal

/mob/living/carbon/human/species/vulpkanin
	race = /datum/species/vulpkanin

/mob/living/carbon/human/species/tajaran
	race = /datum/species/tajaran

/mob/living/carbon/human/species/unathi
	race = /datum/species/unathi

/mob/living/carbon/human/species/podweak
	race = /datum/species/pod/podweak

/mob/living/carbon/human/species/xeno
	race = /datum/species/xeno

/mob/living/carbon/human/species/dwarf
	race = /datum/species/dwarf

/mob/living/carbon/human/species/ghoul
	race = /datum/species/ghoul

/mob/living/carbon/human/species/roundstartslime
	race = /datum/species/jelly/roundstartslime

/mob/living/carbon/human/species/teshari
	race = /datum/species/teshari

/mob/living/carbon/human/species/skrell
	race = /datum/species/skrell

/mob/living/carbon/human/verb/toggle_undies()
	set category = "IC"
	set name = "Toggle underwear visibility"
	set desc = "Allows you to toggle which underwear should show or be hidden. Underwear will obscure genitals."

	if(stat != CONSCIOUS)
		to_chat(usr, span_warning("You can't toggle underwear visibility right now..."))
		return

	var/underwear_button = underwear_visibility & UNDERWEAR_HIDE_UNDIES ? "Show underwear" : "Hide underwear"
	var/undershirt_button = underwear_visibility & UNDERWEAR_HIDE_SHIRT ? "Show shirt" : "Hide shirt"
	var/socks_button = underwear_visibility & UNDERWEAR_HIDE_SOCKS ? "Show socks" : "Hide socks"
	var/bra_button = underwear_visibility & UNDERWEAR_HIDE_BRA ? "Show bra" : "Hide bra"
	var/list/choice_list = list("[underwear_button]" = "underwear", "[bra_button]" = "bra", "[undershirt_button]" = "shirt", "[socks_button]" = "socks","show all" = "show", "Hide all" = "hide")
	var/picked_visibility = input(src, "Choose visibility setting", "Show/Hide underwear") as null|anything in choice_list
	if(picked_visibility)
		var/picked_choice = choice_list[picked_visibility]
		switch(picked_choice)
			if("underwear")
				underwear_visibility ^= UNDERWEAR_HIDE_UNDIES
			if("bra")
				underwear_visibility ^= UNDERWEAR_HIDE_BRA
			if("shirt")
				underwear_visibility ^= UNDERWEAR_HIDE_SHIRT
			if("socks")
				underwear_visibility ^= UNDERWEAR_HIDE_SOCKS
			if("show")
				underwear_visibility = NONE
			if("hide")
				underwear_visibility = UNDERWEAR_HIDE_UNDIES | UNDERWEAR_HIDE_SHIRT | UNDERWEAR_HIDE_SOCKS | UNDERWEAR_HIDE_BRA
		update_body()
	return

/mob/living/carbon/human/revive(full_heal_flags = NONE, excess_healing = 0, force_grab_ghost = FALSE)
	. = ..()
	if(.)
		if(dna && dna.species)
			dna.species.spec_revival(src)
