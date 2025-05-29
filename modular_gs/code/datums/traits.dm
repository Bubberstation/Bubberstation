/datum/quirk/fatness_liker //GS13
	name = "Fat Affinity"
	desc = "You like being fat, alot, maybe even a little bit too much. Being fat gives you a bigger mood boost."
	mob_trait = TRAIT_FAT_GOOD
	value = 0
	medical_record_text = "Patient seems overly content with gaining weight."

/datum/quirk/fatness_hater //GS13
	name = "Fat Aversion"
	desc = "You dislike being fat. Being fat brings your mood down, alot."
	mob_trait = TRAIT_FAT_BAD
	value = 0
	medical_record_text = "Patient seems distressed by gaining weight."

/datum/quirk/weak_legs //GS13
	name = "Weak Legs"
	desc = "Your legs can't handle the heaviest of charges. Being too fat will render you unable to move at all."
	mob_trait = TRAIT_WEAKLEGS
	value = -1
	medical_record_text = "Patient's legs seem to lack strength"

/datum/quirk/strong_legs //GS13
	name = "Strong Legs"
	desc = "Your body is able to handle heavier sizes very well."
	value = 2
	mob_trait = TRAIT_STRONGLEGS
	gain_text = "<span class='notice'>You feel like you can carry more weight.</span>"
	lose_text = "<span class='notice'>Your legs cannot bear heavier loads anymore.</span>"
	medical_record_text = "Patient exhibits increased muscle strength in their legs."

/datum/quirk/draconicspeaker
	name = "Draconic speaker"
	desc = "Due to your time spent around lizards, you can speak Draconic!"
	value = 1
	gain_text = "<span class='notice'>You feel sensitive to hissing noises and your tongue curls comfortably.</span>"
	lose_text = "<span class='notice'>You forget how to speak Draconic!</span>"

/datum/quirk/draconicspeaker/add()
	var/mob/living/M = quirk_holder
	M.grant_language(/datum/language/draconic)

/datum/quirk/draconicspeaker/remove()
	var/mob/living/M = quirk_holder
	M?.remove_language(/datum/language/draconic)

/datum/quirk/slimespeaker
	name = "Slime speaker"
	desc = "Due to your time spent around slimes, you can speak Slimespeak!"
	value = 1
	gain_text = "<span class='notice'>You feel sensitive to blorbling noises, and your throat produces melodic sounds.</span>"
	lose_text = "<span class='notice'>You forget how to speak Slimespeak!</span>"

/datum/quirk/slimespeaker/add()
	var/mob/living/M = quirk_holder
	M.grant_language(/datum/language/slime)

/datum/quirk/slimespeaker/remove()
	var/mob/living/M = quirk_holder
	M?.remove_language(/datum/language/slime)

/datum/quirk/SpawnWithWheelchair
	name = "Mobility Assistance"
	desc = "After your last failed fitness test, you were advised to start using a hoverchair"

/datum/quirk/SpawnWithWheelchair/on_spawn()
	if(quirk_holder.buckled) // Handle late joins being buckled to arrival shuttle chairs.
		quirk_holder.buckled.unbuckle_mob(quirk_holder)

	var/turf/T = get_turf(quirk_holder)
	var/obj/structure/chair/spawn_chair = locate() in T

	var/obj/vehicle/ridden/wheelchair/wheels = new(T)
	if(spawn_chair) // Makes spawning on the arrivals shuttle more consistent looking
		wheels.setDir(spawn_chair.dir)

	wheels.buckle_mob(quirk_holder)


/datum/quirk/universal_diet
	name = "Universal diet"
	desc = "You are fine with eating just about anything normally edible, you have no strong dislikes in food. Toxic food will still hurt you, though."
	value = 0
	gain_text = "<span class='notice'>You feel like you can eat any food type.</span>"
	lose_text = "<span class='notice'>You start to dislike certain food types again.</span>"
	medical_record_text = "Patient reports no strong dietary dislikes."

/datum/quirk/universal_diet/add()
	var/mob/living/carbon/human/H = quirk_holder
	var/datum/species/species = H.dna.species
	species.disliked_food = null

/datum/quirk/universal_diet/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(H)
		var/datum/species/species = H.dna.species
		species.disliked_food = initial(species.disliked_food)

//GS13 Port
//Port from Shadow
/datum/quirk/donotclone
	name = "DNC"
	desc = "You have filed a Do Not Clone order, stating that you do not wish to be cloned. You can still be revived by other means."
	value = -2
	mob_trait = TRAIT_NEVER_CLONE
	medical_record_text = "Patient has a DNC (Do not clone) order on file, and cannot be cloned as a result."

/datum/quirk/inheat
	name = "In Heat"
	desc = "Your system burns with the desire to be bred, your body will betray you and alert others' to your desire when examining you. Satisfying your lust will make you happy, but ignoring it may cause you to become sad and needy."
	value = 0
	mob_trait = TRAIT_HEAT
	gain_text = "<span class='notice'>You body burns with the desire to be bred.</span>"
	lose_text = "<span class='notice'>You feel more in control of your body and thoughts.</span>"

/datum/quirk/headpat_slut
	name = "Headpat Slut"
	desc = "You like headpats, alot, maybe even a little bit too much. Headpats give you a bigger mood boost and cause arousal"
	mob_trait = TRAIT_HEADPAT_SLUT
	value = 0
	medical_record_text = "Patient seems overly affectionate."

/datum/quirk/headpat_hater
	name = "Distant"
	desc = "You don't seem to show much care for being touched. Whether it's because you're reserved or due to self control, you won't wag your tail outside of your own control should you possess one."
	mob_trait = TRAIT_DISTANT
	value = 0
	medical_record_text = "Patient cares little with or dislikes being touched."

/datum/quirk/vegetarian
	name = "Vegetarian"
	desc = "You find the idea of eating meat morally and physically repulsive."
	value = 0
	gain_text = "<span class='notice'>You feel repulsion at the idea of eating meat.</span>"
	lose_text = "<span class='notice'>You feel like eating meat isn't that bad.</span>"
	medical_record_text = "Patient reports a vegetarian diet."

/datum/quirk/vegetarian/add()
	var/mob/living/carbon/human/H = quirk_holder
	var/datum/species/species = H.dna.species
	species.liked_food &= ~MEAT
	species.disliked_food |= MEAT

/datum/quirk/vegetarian/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(H)
		var/datum/species/species = H.dna.species
		if(initial(species.liked_food) & MEAT)
			species.liked_food |= MEAT
		else
			species.disliked_food &= ~MEAT

/datum/quirk/biofuel
	name = "Biofuel Processor"
	desc = "Your robotic body is equipped to eat and digest food the same way organic crew can."
	value = 0
	mob_trait = TRAIT_BIOFUEL

/datum/quirk/biofuel/post_add()
	REMOVE_TRAIT(quirk_holder, TRAIT_NO_PROCESS_FOOD, SPECIES_TRAIT)
