/datum/heretic_knowledge/codex_cicatrix
	desc = "Author the Codex Cicatrix.<br>\
		The Codex Cicatrix can be used to drain influences faster.<br>\
		It can also be used to draw and remove transmutation runes easier, and can be opened to restore charges to your Mansus Grasp."

/obj/item/codex_cicatrix/examine(mob/user)
	. = ..()

	. += span_notice("This book allows the user to open influences faster, draw transmutation runes more quickly, and restore charges to the Mansus Grasp.")
	. += span_notice("Additionally, acts as a focus while open.")
