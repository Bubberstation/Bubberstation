/datum/religion_sect/affection
	name = "Affection God"
	quote = "A gentle touch is where true strength lies."
	desc = "Receiving affection grants you favor. Headpats, Hugs, and Tail-tugs are all fair game."
	rites_list = list()

/datum/religion_sect/affection/on_conversion(mob/living/chap)
	. = ..()
	var/datum/component/affection_favor/comp = chap.AddComponent(/datum/component/affection_favor, src)
	if (!comp)
		message_admins("DEBUG: Failed to add component")
