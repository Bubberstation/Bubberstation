/obj/item/paper/employment_contract/attack(mob/living/target, mob/user)
	if(user == target)
		return

	if(isliving(target) && HAS_TRAIT_FROM(target, TRAIT_NO_SOUL, DEVIL_TRAIT))
		target.remove_traits(list(TRAIT_DEFIB_BLACKLISTED, TRAIT_BADDNA, TRAIT_NO_SOUL), DEVIL_TRAIT)
		for(var/datum/antagonist/devil/satan in world)
			satan.remove_contract(target.mind, target.mind.current)
			satan.contracted -= target.mind
