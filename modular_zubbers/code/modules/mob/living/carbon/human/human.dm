#define NUTSHOT_VOMIT_CHANCE 10

/mob/living/carbon/human/species/shadekin
	race = /datum/species/shadekin


// This is expected to be called or used in situations where you already know the mob is dead
/mob/living/carbon/human/proc/get_dnr()
	return ((HAS_TRAIT(src, TRAIT_DNR) || !((src.mind?.get_ghost(FALSE, TRUE)) ? 1 : 0)))


// For when you want to hurt a motherfucker
/mob/living/carbon/human/proc/nut_shot(mob/living/attacker)
	if(stat >= UNCONSCIOUS)
		message_admins("not conscious")
		return
	if(!(attacker.zone_selected == BODY_ZONE_PRECISE_GROIN))
		message_admins("not selected groin, selected [attacker.zone_selected]")
		return
	message_admins("groin check passed, selected [attacker.zone_selected]")
	if(!has_balls(REQUIRE_GENITAL_EXPOSED))
		message_admins("no exposed balls on [src]!")
		return
	Knockdown(1 SECONDS)

	var/nauseating = prob(NUTSHOT_VOMIT_CHANCE)
	if(nauseating)
		vomit(VOMIT_CATEGORY_DEFAULT)

	visible_message(span_danger("[attacker] punches [src] right in the nuts[nauseating ? ", causing them to throw up in pain" : ""]! Fuck!"))
