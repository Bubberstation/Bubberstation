/datum/mutation/human/cluwne
	name = "Cluwne"
	quality = NEGATIVE
	locked = TRUE
	text_gain_indication = span_danger("You feel like your brain is tearing itself apart.")

/datum/mutation/human/cluwne/on_acquiring(mob/living/carbon/human/owner)
	if(..())
		return
	owner.dna.add_mutation(/datum/mutation/clumsy, MUTATION_SOURCE_CLUWNEIFICATION)
	owner.dna.add_mutation(/datum/mutation/epilepsy, MUTATION_SOURCE_CLUWNEIFICATION)
	owner.set_organ_loss(ORGAN_SLOT_BRAIN,199)

	var/mob/living/carbon/human/H = owner

	if(!istype(H.wear_mask, /obj/item/clothing/mask/yogs/cluwne))
		if(!H.temporarilyRemoveItemFromInventory(H.wear_mask))
			qdel(H.wear_mask)
		H.equip_to_slot_or_del(new /obj/item/clothing/mask/yogs/cluwne(H), ITEM_SLOT_MASK)
	if(!istype(H.w_uniform, /obj/item/clothing/under/yogs/cluwne))
		if(!H.temporarilyRemoveItemFromInventory(H.w_uniform))
			qdel(H.w_uniform)
		H.equip_to_slot_or_del(new /obj/item/clothing/under/yogs/cluwne(H), ITEM_SLOT_ICLOTHING)
	if(!istype(H.shoes, /obj/item/clothing/shoes/yogs/cluwne))
		if(!H.temporarilyRemoveItemFromInventory(H.shoes))
			qdel(H.shoes)
		H.equip_to_slot_or_del(new /obj/item/clothing/shoes/yogs/cluwne(H), ITEM_SLOT_FEET)

	owner.equip_to_slot_or_del(new /obj/item/clothing/gloves/color/white(owner), ITEM_SLOT_GLOVES) // this is purely for cosmetic purposes incase they aren't wearing anything in that slot
	owner.equip_to_slot_or_del(new /obj/item/storage/backpack/clown(owner), ITEM_SLOT_BACK) // ditto

/datum/mutation/human/cluwne/on_life(mob/living/carbon/human/owner)
	if((prob(15) && owner.IsUnconscious()))
		owner.set_organ_loss(ORGAN_SLOT_BRAIN,199)
		switch(rand(1, 6))
			if(1)
				owner.say("HONK")
			if(2 to 5)
				owner.emote("scream")
			if(6)
				owner.Stun(1)
				owner.Knockdown(20)
				owner.adjust_jitter(500 SECONDS)

/datum/mutation/human/cluwne/on_losing(mob/living/carbon/human/owner)
	owner.adjust_fire_stacks(1)
	owner.ignite_mob()
	owner.dna.add_mutation(CLUWNEMUT)

/mob/living/carbon/human/proc/cluwneify()
	dna.add_mutation(CLUWNEMUT)
	emote("scream")
	regenerate_icons()
	visible_message(span_danger("[src]'s body glows green, the glow dissipating only to leave behind a cluwne formerly known as [src]!"), \
					span_danger("Your brain feels like it's being torn apart, and after a short while, you notice that you've become a cluwne!"))
	flash_act()
