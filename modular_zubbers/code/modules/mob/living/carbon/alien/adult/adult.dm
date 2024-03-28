/mob/living/carbon/alien/adult/can_consume(atom/movable/poor_soul)
	. = ..()
	if(!.)
		return .
	if(isliving(poor_soul))
		var/mob/living/L = poor_soul
		var/ventcrawler = HAS_TRAIT(L, TRAIT_VENTCRAWLER_ALWAYS) || HAS_TRAIT(L, TRAIT_VENTCRAWLER_NUDE)
		if(!ventcrawler)
			return FALSE
