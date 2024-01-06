/datum/smite/femboy //Aka how to get demoted from staff for prefbreak --K3 2024
	name = "Femboyification"

/datum/smite/femboy/effect(client/user, mob/living/carbon/human/target)
	. = ..()
	if(!ishuman(target))
		return
	var/main_color
	var/second_color
	var/random = rand(1,5)
	switch(random)
		if(1)
			main_color = "#ffd88a"
			second_color = "#FFDD44"
		if(2)
			main_color = "#73fbb9"
			second_color = "#00c3ff"
		if(3)
			main_color = "#ddc004"
			second_color = "#ff9898"
		if(4)
			main_color = "#ffff00"
			second_color = "#FFFFFF"
		if(5)
			main_color = "#fd3797"
			second_color = "#fef7f7"

	target.dna.features["mcolor"] = main_color
	target.dna.features["mcolor2"] = second_color
	target.dna.features["mcolor3"] = second_color

	var/snout_name = pick("Mammal, Long", "Mammal, Long ALT" , "Mammal, Short" ,"Mammal, Short ALT 2" , "Mammal, Thick ALT")
	var/tail_name = pick("Eevee", "Fennec", "Fox", "Fox (Alt 1)", "Fox (Alt 2)")
	var/ears_name = pick("Wolf", "Big Wolf (ALT)", "Eevee", "Fox", "Husky")

	target.dna.mutant_bodyparts["snout"] = list(MUTANT_INDEX_NAME = snout_name, MUTANT_INDEX_COLOR_LIST = list(main_color, second_color, main_color))
	target.dna.mutant_bodyparts["tail"] = list(MUTANT_INDEX_NAME = tail_name, MUTANT_INDEX_COLOR_LIST = list(second_color, main_color, main_color))
	target.dna.mutant_bodyparts["ears"] = list(MUTANT_INDEX_NAME = ears_name, MUTANT_INDEX_COLOR_LIST = list(main_color, second_color, second_color))
	target.set_species(/datum/species/vulpkanin)
	target.update_body()
	target.update_mutations_overlay()

	to_chat(target, span_boldnotice("Something is n-n-nya~"))
	playsound(get_turf(target), 'modular_skyrat/modules/modular_items/lewd_items/sounds/under_moan_f4.ogg', 50, TRUE, -1)

	// Init femboyflavor.
	var/head = strings("zubbers/femboy_flavor.json", "head")
	var/body = strings("zubbers/femboy_flavor.json", "body")
	var/legs = strings("zubbers/femboy_flavor.json", "legs")
	var/erot = strings("zubbers/femboy_flavor.json", "erotic")

	var/femboy_flavor = pick(head) + " " + pick(erot) + " " + pick(body) + " " + pick(erot) + " " + pick(legs)
	target.dna.features["flavor_text"] = femboy_flavor
