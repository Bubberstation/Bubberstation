/datum/augment_item/organ
	category = AUGMENT_CATEGORY_ORGANS

/datum/augment_item/organ/apply(mob/living/carbon/human/human_holder, character_setup = FALSE, datum/preferences/prefs)
	if(character_setup)
		return

	var/obj/item/organ/organ_path = path // cast this to an organ so we can get the slot from it using initial()

	if(slot == AUGMENT_SLOT_BRAIN)
		var/obj/item/organ/brain/old_brain = human_holder.get_organ_slot(ORGAN_SLOT_BRAIN)
		var/obj/item/organ/brain/new_brain = new organ_path()

		var/datum/mind/holder_mind = human_holder.mind

		new_brain.modular_persistence = old_brain.modular_persistence
		new_brain.modular_persistence?.owner = new_brain
		old_brain.modular_persistence = null

		new_brain.copy_traits_from(old_brain)
		new_brain.Insert(human_holder, special = TRUE)
		old_brain.moveToNullspace()  //for some reason it doesn't want to be deleted. So I'm using this hack method until it can be figured out why. But, it works!
		STOP_PROCESSING(SSobj, old_brain)

		if(!holder_mind)
			return

		holder_mind.transfer_to(human_holder, TRUE)
	else
		var/obj/item/organ/new_organ = new path()

		new_organ.copy_traits_from(human_holder.get_organ_slot(initial(organ_path.slot)))
		new_organ.Insert(human_holder, special = TRUE, movement_flags = DELETE_IF_REPLACED)

//BUBBER EDIT - New brain
//BRAINS
/datum/augment_item/organ/brain
	slot = AUGMENT_SLOT_BRAIN

/datum/augment_item/organ/brain/cortical
	name = "Cortically-Augmented Brain"
	slot = AUGMENT_SLOT_BRAIN
	path = /obj/item/organ/brain/cybernetic/cortical
//EDIT END

//HEARTS
/datum/augment_item/organ/heart
	slot = AUGMENT_SLOT_HEART

/datum/augment_item/organ/heart/cybernetic
	name = "Cybernetic heart"
	path = /obj/item/organ/heart/cybernetic

//LUNGS
/datum/augment_item/organ/lungs
	slot = AUGMENT_SLOT_LUNGS

/datum/augment_item/organ/lungs/normal
	name = "Normal Lungs"
	slot = AUGMENT_SLOT_LUNGS
	path = /obj/item/organ/lungs
	cost = 1 // if you dont have normal lungs, still an investment to switch it out

/datum/augment_item/organ/lungs/hot
	name = "Heat-Adapted Lungs"
	slot = AUGMENT_SLOT_LUNGS
	path = /obj/item/organ/lungs/adaptive/hot
	cost = 1

/datum/augment_item/organ/lungs/cold
	name = "Cold-Adapted Lungs"
	slot = AUGMENT_SLOT_LUNGS
	path = /obj/item/organ/lungs/adaptive/cold
	cost = 1
/datum/augment_item/organ/lungs/toxin
	name = "Toxins-Adapted Lungs"
	slot = AUGMENT_SLOT_LUNGS
	path = /obj/item/organ/lungs/toxin
	cost = 1
/datum/augment_item/organ/lungs/oxy
	name = "Low Oxygen-Adapted Lungs"
	slot = AUGMENT_SLOT_LUNGS
	path = /obj/item/organ/lungs/oxy
	cost = 1
/datum/augment_item/organ/lungs/cybernetic
	name = "Cybernetic lungs"
	path = /obj/item/organ/lungs/cybernetic

//LIVERS
/datum/augment_item/organ/liver
	slot = AUGMENT_SLOT_LIVER

/datum/augment_item/organ/liver/cybernetic
	name = "Cybernetic liver"
	path = /obj/item/organ/liver/cybernetic

//STOMACHES
/datum/augment_item/organ/stomach
	slot = AUGMENT_SLOT_STOMACH

/datum/augment_item/organ/stomach/cybernetic
	name = "Cybernetic stomach"
	path = /obj/item/organ/stomach/cybernetic

//EYES
/datum/augment_item/organ/eyes
	slot = AUGMENT_SLOT_EYES

/datum/augment_item/organ/eyes/cybernetic
	name = "Cybernetic eyes"
	path = /obj/item/organ/eyes/robotic

/datum/augment_item/organ/eyes/cybernetic/moth
	name = "Cybernetic moth eyes"
	path = /obj/item/organ/eyes/robotic/moth

/datum/augment_item/organ/eyes/highlumi
	name = "High-luminosity eyes"
	path = /obj/item/organ/eyes/robotic/glow
	allowed_biotypes = MOB_ORGANIC|MOB_ROBOTIC
	cost = 1

/datum/augment_item/organ/eyes/highlumi/moth
	name = "High Luminosity Moth Eyes"
	path = /obj/item/organ/eyes/robotic/glow/moth
	allowed_biotypes = MOB_ORGANIC|MOB_ROBOTIC
	cost = 1

//TONGUES
/datum/augment_item/organ/tongue
	slot = AUGMENT_SLOT_TONGUE

/datum/augment_item/organ/tongue/normal
	name = "Organic tongue"
	path = /obj/item/organ/tongue/human

/datum/augment_item/organ/tongue/robo
	name = "Robotic voicebox"
	path = /obj/item/organ/tongue/robot

/datum/augment_item/organ/tongue/robo/forked
	name = "Robotic lizard voicebox"
	path = /obj/item/organ/tongue/lizard/robot

/datum/augment_item/organ/tongue/cybernetic
	name = "Cybernetic tongue"
	path = /obj/item/organ/tongue/cybernetic

/datum/augment_item/organ/tongue/cybernetic/forked
	name = "Forked cybernetic tongue"
	path = /obj/item/organ/tongue/lizard/cybernetic

/datum/augment_item/organ/tongue/forked
	name = "Forked tongue"
	path = /obj/item/organ/tongue/lizard

/datum/augment_item/organ/tongue/akula
	name = "Aquatic tongue"
	path = /obj/item/organ/tongue/akula

//EARS
/datum/augment_item/organ/ears
	slot = AUGMENT_SLOT_EARS

/datum/augment_item/organ/ears/cybernetic
	name = "Cybernetic ears"
	path = /obj/item/organ/ears/cybernetic
