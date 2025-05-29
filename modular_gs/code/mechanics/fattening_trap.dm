/obj/structure/trap/fattening
	name = "fattening trap"
	desc = "A trap that ensures you won't be stepping around for much longer."
	icon = 'GainStation13/icons/obj/structure/traps.dmi'
	icon_state = "trap-fattening"

	var/fattening_amount = 250 // Using a variable incase we want to have a stronger version.
	// This is at half of the power of the singe-use cannonshot fatray.

/obj/structure/trap/fattening/trap_effect(mob/living/carbon/crosser)
	if(ishuman(crosser))
		to_chat(crosser, "<span class='danger'><B>You feel heavier!</B></span>")
		crosser.adjust_fatness(fattening_amount, FATTENING_TYPE_MAGIC)

/obj/structure/trap/belch
	name = "belch trap"
	desc = "A trap that forcefully releases all the air in your stomach."
	icon = 'GainStation13/icons/obj/structure/traps.dmi'
	icon_state = "trap-belching"

/obj/structure/trap/belch/trap_effect(mob/living/crosser)
	if(crosser?.client?.prefs.weight_gain_chems)
		to_chat(crosser, "<span class='danger'><B>You feel all of the air leave your stomach!</B></span>")
		crosser.emote(pick("belch","burp"))

	crosser.Knockdown(500)

