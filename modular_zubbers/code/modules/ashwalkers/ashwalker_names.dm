/proc/generate_one_word_objects()

	. = list()

	var/regex/regex_inclusion = regex(@'^(\w+)$',"i") //limits to things with one word

	for(var/obj/object as anything in subtypesof(/obj))
		var/object_name = initial(object.name)
		if(!object_name || !regex_inclusion.Find(object_name))
			continue
		.[capitalize(LOWER_TEXT(object_name))] = TRUE

	return .

GLOBAL_LIST_INIT(one_word_objects,generate_one_word_objects())


GLOBAL_LIST_INIT(ashwalker_vowels,list(
	"e",
	"ee",
	"ea",
	"u",
	"i",
	"o",
	"oo",
	"a"
))

GLOBAL_LIST_INIT(ashwalker_consonants,list(
	"w",
	"r",
	"t",
	"th",
	"s",
	"d",
	"g",
	"h",
	"k",
	"z",
	"x",
	"v",
	"b",
	"n",
	"m"
))

/proc/generate_ashwalker_word(min_chars=3,max_chars=5)
	. = ""
	var/is_vowel = !prob(80) //Atmos optimization
	for(var/i in 1 to rand(min_chars,max_chars))
		. += is_vowel ? pick(GLOB.ashwalker_vowels) : pick(GLOB.ashwalker_consonants)
		is_vowel = !is_vowel
	return .

/proc/generate_ashwalker_name(english_name=!prob(80))

	if(english_name)

		var/chosen_verb = capitalize(pick(GLOB.verbs))
		// Code copied from pronouns. Had to do it raw here since it doesn't work without a datum.
		switch(copytext_char(chosen_verb, -2))
			if ("ss")
				chosen_verb = "[chosen_verb]es"
			if ("sh")
				chosen_verb = "[chosen_verb]es"
			if ("ch")
				chosen_verb = "[chosen_verb]es"
			else
				switch(copytext_char(chosen_verb, -1))
					if("s", "x", "z")
						chosen_verb = "[chosen_verb]es"
					else
						chosen_verb = "[chosen_verb]s"
		return "[chosen_verb]-The-[capitalize(pick(GLOB.one_word_objects))]"

	//Unironically can generate slurs or other funny words. If that happens, just use Verbs-the-Noun.
	. = reject_bad_name("[capitalize(generate_ashwalker_word(3,5))]-[capitalize(generate_ashwalker_word(3,7))]",strict=TRUE)

	if(!.)
		return generate_ashwalker_name(TRUE)

	return .

ADMIN_VERB(generate_ashwalker_names, R_DEBUG, "Generate Ashwalker Names", "Generate a list of 50 random ashwalker names.", ADMIN_CATEGORY_DEBUG)

	var/list/returning_data = ""
	for(var/i in 1 to 50)
		returning_data += "[generate_ashwalker_name(i % 2)]<br>"

	user << browse(returning_data, "window=random_ashwalker_names")

/obj/effect/mob_spawn/ghost_role/human/pirate/silverscale/generate_pirate_name(spawn_gender)
	return generate_ashwalker_name(TRUE)
