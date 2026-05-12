/datum/heretic_knowledge/codex_cicatrix
	desc = "Allows you to transmute a book, any pen, and your pick from any carcass (animal or human), leather, or hide to create a Codex Cicatrix. \
		The Codex Cicatrix can be used when draining influences to drain them faster, but comes at greater risk of being noticed. \
		It can also be used to draw and remove transmutation runes easier, and as a spell focus in a pinch. Very useful for opening ways."

/obj/item/codex_cicatrix/examine(mob/user)
	. = ..()

	. += span_notice("This book allows the user to open influences faster, as well as draw transmutation runes more quickly.")
	. += span_notice("Additionally, acts as a focus while held.")
