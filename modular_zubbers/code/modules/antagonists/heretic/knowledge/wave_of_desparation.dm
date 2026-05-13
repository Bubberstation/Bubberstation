/datum/heretic_knowledge/spell/opening_blast
	drafting_cost = 3

/datum/action/cooldown/spell/aoe/wave_of_desperation
	cooldown_time = 10 MINUTES

/datum/action/cooldown/spell/aoe/wave_of_desperation/cast(atom/cast_on)
	. = ..()

	owner.visible_message(span_boldwarning("You get the feeling [owner] won't be able to use this spell again any time soon. Capture [owner.p_them()] again! A straightjacket cant be broken out of..."))
