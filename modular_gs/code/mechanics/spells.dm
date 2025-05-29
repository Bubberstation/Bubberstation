/obj/effect/proc_holder/spell/targeted/touch/add_weight
	name = "Fattening"
	desc = "Channel fattening energy to your hand to fatten people with."
	drawmessage = "You channel fattening energy into your hand."
	dropmessage = "You let the fattening energy from your hand dissipate."
	hand_path = /obj/item/melee/touch_attack/fattening
	action_icon_state = "spell_default"
	charge_max = 200
	clothes_req = FALSE

/obj/effect/proc_holder/spell/targeted/touch/add_weight/transfer
	name = "Weight transfer"
	hand_path = /obj/item/melee/touch_attack/fattening/transfer
	charge_max = 100

/obj/effect/proc_holder/spell/targeted/touch/add_weight/steal
	name = "Weight steal"
	hand_path = /obj/item/melee/touch_attack/fattening/steal
	charge_max = 100

/obj/item/melee/touch_attack/fattening
	name = "\improper fattening touch"
	desc = "The calories from multiple donuts compressed into pure energy."
	catchphrase = null
	on_use_sound = 'sound/weapons/pulse.ogg'
	icon = 'GainStation13/icons/obj/spells/spell_items.dmi'
	icon_state = "add-hand"
	///How much weight is added?
	var/weight_to_add = 300
	///What verb is used for the spell?
	var/fattening_verb = "fattens"
	///Is weight being transfered from the user to another mob?


/obj/item/melee/touch_attack/fattening/afterattack(atom/target, mob/living/carbon/user, proximity)
	if(!proximity || !iscarbon(target) || target == user)
		return FALSE

	var/mob/living/carbon/gainer = target
	if(!gainer || !weight_to_add)
		return FALSE

	if(!gainer.adjust_fatness(weight_to_add, FATTENING_TYPE_MAGIC))
		to_chat(user,"<span class='warning'[target] seems unaffected by [src]</span>")
		return FALSE

	gainer.visible_message("<span class='danger'>[user] [fattening_verb] [target]!</span>","<span class='userdanger'>[user] [fattening_verb] you!</span>")
	return ..()

/obj/item/melee/touch_attack/fattening/transfer
	name = "\improper weight transfer touch"
	desc = "Your weight compressed into a fattening energy."
	fattening_verb = "transfers weight to"
	icon_state = "transfer-hand"

/obj/item/melee/touch_attack/fattening/transfer/afterattack(atom/target, mob/living/carbon/user, proximity)
	if(!proximity || !target || target == user)
		return FALSE

	if(weight_to_add > user.fatness_real || !user.adjust_fatness(-weight_to_add, FATTENING_TYPE_MAGIC))
		to_chat(user, "<span class='warning'You don't have enough spare weight to transfer</span>")
		return FALSE

	return ..()

/obj/item/melee/touch_attack/fattening/steal
	name = "\improper weight theft touch"
	desc = "Energy that is eager to take weight."
	fattening_verb = "steals weight from"
	weight_to_add = -300
	icon_state = "steal-hand"

/obj/item/melee/touch_attack/fattening/steal/afterattack(atom/target, mob/living/carbon/user, proximity)
	var/mob/living/carbon/loser = target
	if(!proximity || !iscarbon(target) || target == user)
		return FALSE

	if(loser.fatness < -weight_to_add)
		to_chat(user, "<span class='warning'[loser] doesn't have enough spare weight to transfer</span>")
		return FALSE

	. = ..()
	if(. != null && !.)
		return FALSE

	user.adjust_fatness(-weight_to_add, FATTENING_TYPE_MAGIC)

/obj/effect/proc_holder/spell/aoe_turf/conjure/the_traps/fat
	name = "Fat Traps!"
	desc = "Summon a number of traps to fatten your enemies."
	action_icon = 'GainStation13/icons/obj/structure/traps.dmi'
	action_icon_state = "trap-fattening"

	clothes_req = FALSE
	summon_type = list(
		/obj/structure/trap/fattening
	)

	summon_amt = 4

/obj/effect/proc_holder/spell/aoe_turf/conjure/the_traps/fat/belch
	name = "Belch Traps!"
	desc = "Summon a number of traps to force your enemies to belch."
	action_icon_state = "trap-belching"
	summon_type = list(
		/obj/structure/trap/belch
	)

///Spellbooks
/obj/item/book/granter/spell/fattening
	name = "fattening tome"
	spell = /obj/effect/proc_holder/spell/targeted/touch/add_weight
	spellname = "fattening"
	icon = 'GainStation13/icons/obj/spells/spellbooks.dmi'
	icon_state = "add_weight"
	desc = "This book feels warm to the touch."

/obj/item/book/granter/spell/fattening/transfer
	name = "weight transfer tome"
	spell = /obj/effect/proc_holder/spell/targeted/touch/add_weight/transfer
	spellname = "weight transfer"
	icon_state = "transfer_weight"
	desc = "This book feels warm to the touch."

/obj/item/book/granter/spell/fattening/steal
	name = "weight steal tome"
	spell = /obj/effect/proc_holder/spell/targeted/touch/add_weight/steal
	spellname = "weight steal"
	icon_state = "steal_weight"
	desc = "This book feels warm to the touch."

/obj/item/book/granter/spell/fattening/traps
	name = "fattening trap tome"
	spell = /obj/effect/proc_holder/spell/aoe_turf/conjure/the_traps/fat
	spellname = "fattening traps"

/obj/item/book/granter/spell/fattening/belch
	name = "belch trap tome"
	spell = /obj/effect/proc_holder/spell/aoe_turf/conjure/the_traps/fat/belch
	spellname = "belch traps"
