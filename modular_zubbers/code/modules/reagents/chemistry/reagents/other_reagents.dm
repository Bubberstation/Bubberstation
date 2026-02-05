#define MUT_MSG_IMMEDIATE 1
#define MUT_MSG_EXTENDED 2
#define MUT_MSG_ABOUT2TURN 3

#define CYCLES_TO_TURN 20
#define CYCLES_MSG_IMMEDIATE 6
#define CYCLES_MSG_EXTENDED 16

/datum/reagent/transformative_virus/
	var/transformation_disease = /datum/disease/transformation_race

/datum/reagent/transformative_virus/expose_mob(mob/living/exposed_mob, methods = TOUCH, reac_volume, show_message = TRUE, touch_protection = 0)
	. = ..()
	if((methods & (PATCH | INGEST | INJECT | INHALE)) || ((methods & (VAPOR | TOUCH)) && prob(min(reac_volume,100) * (1 - touch_protection))))
		exposed_mob.ForceContractDisease(new transformation_disease(), FALSE, TRUE)

/datum/reagent/mutationtoxin/on_mob_life(mob/living/carbon/human/affected_mob, seconds_per_tick, times_fired)
	. = ..()
	if(SPT_PROB(12, seconds_per_tick))
		var/list/pick_ur_fav = list()
		var/filter = NONE
		if(current_cycle <= CYCLES_MSG_IMMEDIATE)
			filter = MUT_MSG_IMMEDIATE
		else if(current_cycle <= CYCLES_MSG_EXTENDED)
			filter = MUT_MSG_EXTENDED
		else
			filter = MUT_MSG_ABOUT2TURN

		for(var/i in mutationtexts)
			if(mutationtexts[i] == filter)
				pick_ur_fav += i
		to_chat(affected_mob, span_warning("[pick(pick_ur_fav)]"))

/datum/reagent/mutationtoxin/abductor
	mutationtexts = list(
		"Your skin is turning grey." = MUT_MSG_IMMEDIATE,
		"Your hair falls out in clumps." = MUT_MSG_IMMEDIATE,
		"You are finding it harder to speak." = MUT_MSG_EXTENDED,
		"You feel a shooting pain in your head." = MUT_MSG_EXTENDED,
		"Xap Xoorp!" = MUT_MSG_ABOUT2TURN)


/datum/reagent/mutationtoxin/akula
	name = "Akula Mutation Toxin"
	description = "An akula toxin."
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/akula
	taste_description = "fish"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE
	mutationtexts = list(
		"You feel itchy." = MUT_MSG_IMMEDIATE,
		"Your skin feels wet." = MUT_MSG_IMMEDIATE,
		"You are growing fish scales on your skin." = MUT_MSG_EXTENDED,
		"You struggle to breathe." = MUT_MSG_EXTENDED,
		"You need to find water, NOW!" = MUT_MSG_ABOUT2TURN)

/datum/reagent/transformative_virus/android
	name = "Android Nanomachines"
	description = "One with the machine."
	color = "#535E66"  //RGB: 94, 255, 59
	taste_description = "circuitry and steel"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE
	transformation_disease = /datum/disease/transformation_race/android

/datum/reagent/mutationtoxin/anthromorph
	name = "Anthromorph Mutation Toxin"
	description = "An anthromorph toxin."
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/mammal
	taste_description = "wet dog"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE
	mutationtexts = list(
		"You feel pinpricks on your skin." = MUT_MSG_IMMEDIATE,
		"You notice a dusting of hair covering your body." = MUT_MSG_IMMEDIATE,
		"You are getting furrier." = MUT_MSG_EXTENDED,
		"Your nose is wet." = MUT_MSG_EXTENDED,
		"You feel very fuzzy." = MUT_MSG_ABOUT2TURN)

/datum/reagent/mutationtoxin/ash
	mutationtexts = list(
		"You feel very cold." = MUT_MSG_IMMEDIATE,
		"Your skin feels dry." = MUT_MSG_IMMEDIATE,
		"Your skin begins to grow scales. They feel very robust." = MUT_MSG_EXTENDED,
		"Your mind feels clouded." = MUT_MSG_EXTENDED,
		"You yearn for the volcanic wastes." = MUT_MSG_ABOUT2TURN)

/datum/reagent/mutationtoxin/dwarf
	name = "Dwarf Mutation Toxin"
	description = "A dwarf toxin."
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/dwarf
	taste_description = "ale and earth"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE
	mutationtexts = list(
		"You feel a desire for some ale." = MUT_MSG_IMMEDIATE,
		"You feel a sensation of vertigo." = MUT_MSG_IMMEDIATE,
		"The claustrophobic maintenance tunnels feel at home to you." = MUT_MSG_EXTENDED,
		"Your bones feel denser." = MUT_MSG_EXTENDED,
		"Rock and stone to the bone." = MUT_MSG_ABOUT2TURN)

/datum/reagent/mutationtoxin/ethereal
	name = "Ethereal Mutation Toxin"
	description = "A lightbulb toxin."
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/ethereal
	taste_description = "electricity"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE
	mutationtexts = list(
		"You feel your skin tingle." = MUT_MSG_IMMEDIATE,
		"Your hair stands on end." = MUT_MSG_IMMEDIATE,
		"You feel warm." = MUT_MSG_EXTENDED,
		"Nearby electronics seem to hum louder." = MUT_MSG_EXTENDED,
		"Your flesh glows brightly." = MUT_MSG_ABOUT2TURN)

/datum/reagent/mutationtoxin/felinid
	mutationtexts = list(
		"You feel your skin tingle." = MUT_MSG_IMMEDIATE,
		"Your hair stands on end." = MUT_MSG_IMMEDIATE,
		"Your ears begin to get very fuzzy." = MUT_MSG_EXTENDED,
		"Lasers begin to hold your attention." = MUT_MSG_EXTENDED,
		"Mrrp Mrowl Mggaow!" = MUT_MSG_ABOUT2TURN)

/datum/reagent/mutationtoxin/felinid/primitive
	name = "Ice Walker Mutation Toxin"
	description = "A ice Walker toxin."
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/human/felinid/primitive
	taste_description = "something ancient and cold"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE
	mutationtexts = list(
		"Your mind feels clouded." = MUT_MSG_IMMEDIATE,
		"Your hair stands on end." = MUT_MSG_IMMEDIATE,
		"You feel very warm." = MUT_MSG_EXTENDED,
		"You feel like going hunting." = MUT_MSG_EXTENDED,
		"You feel more at home in the snow." = MUT_MSG_ABOUT2TURN)

/datum/reagent/mutationtoxin/fly
	mutationtexts = list(
		"Your tongue tingles." = MUT_MSG_IMMEDIATE,
		"Your stomach churns." = MUT_MSG_IMMEDIATE,
		"Your eyes sting." = MUT_MSG_IMMEDIATE,
		"Your tongue turns into a proboscis." = MUT_MSG_EXTENDED,
		"Your eyes become compound, splitting your sight into thousands of images." = MUT_MSG_EXTENDED,
		"Trash and rotting flesh begins to be appetizing." = MUT_MSG_EXTENDED,
		"Buzz Buzz Buzz." = MUT_MSG_ABOUT2TURN)

/datum/reagent/mutationtoxin/ghoul
	name = "Ghoul Mutation Toxin"
	description = "A ghoul toxin."
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/ghoul
	taste_description = "rotting flesh"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE
	mutationtexts = list(
		"Your muscles are sore." = MUT_MSG_IMMEDIATE,
		"Your stomach churns." = MUT_MSG_IMMEDIATE,
		"You notice putrecent spots on your skin." = MUT_MSG_EXTENDED,
		"Rotting flesh begins to be appetizing." = MUT_MSG_EXTENDED,
		"Much of your flesh sloughs off." = MUT_MSG_ABOUT2TURN)

/datum/reagent/mutationtoxin/golem
	mutationtexts = list(
		"You feel like you have gravel in your stomach." = MUT_MSG_IMMEDIATE,
		"Your joints feel stiff." = MUT_MSG_IMMEDIATE,
		"Your joints feel very stiff." = MUT_MSG_EXTENDED,
		"Rock begins growing on your skin. Somehow it does not feel heavy." = MUT_MSG_EXTENDED,
		"The stony growths completely encase you. " = MUT_MSG_ABOUT2TURN)

/datum/reagent/transformative_virus/hemophage
	name = "Hemophage Corruption Virus"
	description = "A hemophage virus."
	color = BLOOD_COLOR_RED
	taste_description = "blood"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE
	transformation_disease =/datum/disease/transformation_race/hemophage

/datum/reagent/mutationtoxin/insect
	name = "Insect Mutation Toxin"
	description = "An insect toxin."
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/insect
	taste_description = "honey"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE
	mutationtexts = list(
		"Your tongue tingles." = MUT_MSG_IMMEDIATE,
		"Your skin feels loose." = MUT_MSG_IMMEDIATE,
		"Your skin begins tearing, revealing a shiny carapace underneath." = MUT_MSG_EXTENDED,
		"Your tongue turns into a proboscis and you have a craving for honey." = MUT_MSG_EXTENDED,
		"A pair of antennae sprout from your head. " = MUT_MSG_ABOUT2TURN)

/datum/reagent/mutationtoxin/jelly
	mutationtexts = list(
		"Your mouth feels gooey" = MUT_MSG_IMMEDIATE,
		"Your skin feels wet and starts to take a transparent character" = MUT_MSG_IMMEDIATE,
		"Your limbs begin to turn to goop. Your fingers melt together." = MUT_MSG_EXTENDED,
		"Your legs give out and you fall into a puddle of yourself" = MUT_MSG_EXTENDED,
		"Your organs coalesce together into a slime core. You reform yourself into a more anthropomorphic shape." = MUT_MSG_ABOUT2TURN)

/datum/reagent/mutationtoxin/lizard
	mutationtexts = list(
		"You feel cold." = MUT_MSG_IMMEDIATE,
		"Your skin feels dry." = MUT_MSG_IMMEDIATE,
		"Your skin begins to grow scales." = MUT_MSG_EXTENDED,
		"You flick your tongue." = MUT_MSG_EXTENDED,
		"You feel like licking your eyeballs." = MUT_MSG_ABOUT2TURN)

/datum/reagent/mutationtoxin/monkey
	name = "Monkey Mutation Toxin"
	description = "A monkey toxin."
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/monkey
	taste_description = "bananas"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE
	mutationtexts = list(
		"You breathe through your mouth." = MUT_MSG_IMMEDIATE,
		"You have a craving for bananas." = MUT_MSG_IMMEDIATE,
		"Your back hurts." = MUT_MSG_EXTENDED,
		"Your mind feels clouded." = MUT_MSG_EXTENDED,
		"You feel like monkeying around." = MUT_MSG_ABOUT2TURN)

/datum/reagent/mutationtoxin/moth
	mutationtexts = list(
		"Your eyes suddenly become very light sensitive." = MUT_MSG_IMMEDIATE,
		"Your skin feels prickly." = MUT_MSG_IMMEDIATE,
		"You grow a very fluffy moth fluff." = MUT_MSG_EXTENDED,
		"A pair of antennae sprout from your head." = MUT_MSG_EXTENDED,
		"A pair of moth wings sprout from your back." = MUT_MSG_EXTENDED,
		"You feel like hugging a lamp." = MUT_MSG_ABOUT2TURN)

/datum/reagent/mutationtoxin/plasma
	mutationtexts = list(
		"You have a sharp pain in your stomach" = MUT_MSG_IMMEDIATE,
		"Your skin develops purple boils" = MUT_MSG_IMMEDIATE,
		"The boils on your skin erupt as the flesh melts away, replaced by a purple goo" = MUT_MSG_EXTENDED,
		"You can see your own skeleton." = MUT_MSG_EXTENDED,
		"You begin to warm rapidly. You need plasma not air!" = MUT_MSG_ABOUT2TURN)

/datum/reagent/mutationtoxin/pod
	mutationtexts = list(
		"Your skin begins to have a green tinge." = MUT_MSG_IMMEDIATE,
		"Your mouth feels dry." = MUT_MSG_IMMEDIATE,
		"Normal food does not seem to sustain you as it has done before." = MUT_MSG_EXTENDED,
		"You feel very weak in the darkness." = MUT_MSG_EXTENDED,
		"You feel like basking in the sunlight." = MUT_MSG_ABOUT2TURN)

/datum/reagent/mutationtoxin/shadekin
	name = "Shadekin Mutation Toxin"
	description = "A shadekin toxin."
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/shadekin
	taste_description = "something dark and furry"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE
	mutationtexts = list(
		"You feel at home in the darkness." = MUT_MSG_IMMEDIATE,
		"You notice a dusting of hair covering your body." = MUT_MSG_IMMEDIATE,
		"You are getting furrier." = MUT_MSG_EXTENDED,
		"Your ears flop over your head." = MUT_MSG_EXTENDED,
		"You hear a cacophony of voices in your head." = MUT_MSG_ABOUT2TURN)

/datum/reagent/mutationtoxin/shadow
	name = "Shadow Mutation Toxin"
	description = "A dark toxin."
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/shadow
	taste_description = "the night"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE
	mutationtexts = list(
		"You feel at home in the darkness." = MUT_MSG_IMMEDIATE,
		"Your eyes adjust faster to the shadows." = MUT_MSG_IMMEDIATE,
		"Your get a migraine from the light" = MUT_MSG_EXTENDED,
		"Your skin blackens and becomes transparent." = MUT_MSG_EXTENDED,
		"The light burns!" = MUT_MSG_ABOUT2TURN)

/datum/reagent/mutationtoxin/skeleton
	mutationtexts = list(
		"You are losing weight" = MUT_MSG_IMMEDIATE,
		"You have a yearning for milk." = MUT_MSG_IMMEDIATE,
		"You are all skin and bones." = MUT_MSG_EXTENDED,
		"Your eyes are heavily recessed." = MUT_MSG_EXTENDED,
		"The rest of your flesh sloughs off your bones." = MUT_MSG_ABOUT2TURN)

/datum/reagent/mutationtoxin/skrell
	name = "Skrell Mutation Toxin"
	description = "A skrell toxin."
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/skrell
	taste_description = "salted squid"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE
	mutationtexts = list(
		"Your skin feels rubbery" = MUT_MSG_IMMEDIATE,
		"Your hair clumps together." = MUT_MSG_IMMEDIATE,
		"Your skin becomes coated in a mucus." = MUT_MSG_EXTENDED,
		"Your hair merges together into large head tentacles." = MUT_MSG_EXTENDED,
		"You feel most at home near water." = MUT_MSG_ABOUT2TURN)

/datum/reagent/transformative_virus/synthetic
	name = "Synthetic Nanomachines"
	description = "We can rebuild them."
	color = "#535E66"  //RGB: 94, 255, 59
	taste_description = "metal"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE
	transformation_disease = /datum/disease/transformation_race/synthetic

/datum/reagent/mutationtoxin/tajaran
	name = "Tajaran Mutation Toxin"
	description = "A tajaran toxin."
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/tajaran
	taste_description = "toxoplasmosis"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE
	mutationtexts = list(
		"You feel pinpricks on your skin." = MUT_MSG_IMMEDIATE,
		"You notice a dusting of hair covering your body." = MUT_MSG_IMMEDIATE,
		"You are getting furrier." = MUT_MSG_EXTENDED,
		"Your nose is wet." = MUT_MSG_EXTENDED,
		"You feel very fuzzy." = MUT_MSG_ABOUT2TURN)

/datum/reagent/mutationtoxin/teshari
	name = "Teshari Mutation Toxin"
	description = "A teshari toxin."
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/teshari
	taste_description = "fried chicken"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE
	mutationtexts = list(
		"You feel pinpricks on your skin." = MUT_MSG_IMMEDIATE,
		"Your skin feels oily." = MUT_MSG_IMMEDIATE,
		"You begin growing feathers." = MUT_MSG_EXTENDED,
		"You feel very excitable." = MUT_MSG_EXTENDED,
		"You feel like a little gremlin, like you need to do some crimes." = MUT_MSG_ABOUT2TURN)

/datum/reagent/mutationtoxin/vox
	name = "Vox Mutation Toxin"
	description = "A voxin."
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/vox
	taste_description = "skreeing with a metallic tinge"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE
	mutationtexts = list(
		"Your throat feels scratchy." = MUT_MSG_IMMEDIATE,
		"Your lungs burn!" = MUT_MSG_IMMEDIATE,
		"Quills push through your skin." = MUT_MSG_EXTENDED,
		"A beak forms on your face." = MUT_MSG_EXTENDED,
		"You need to find nitrogen fast! SKREE!" = MUT_MSG_ABOUT2TURN)

/datum/reagent/mutationtoxin/vox_primalis
	name = "Vox Primalis Mutation Toxin"
	description = "A vox primalis toxin."
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/vox_primalis
	taste_description = "screeching with a metallic tinge"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE
	mutationtexts = list(
		"Your throat feels scratchy." = MUT_MSG_IMMEDIATE,
		"Your lungs burn!" = MUT_MSG_IMMEDIATE,
		"Quills push through your skin." = MUT_MSG_EXTENDED,
		"A beak forms on your face and splits into three parts." = MUT_MSG_EXTENDED,
		"You need to find nitrogen fast! SKREE!" = MUT_MSG_ABOUT2TURN)

/datum/reagent/mutationtoxin/vulpkanin
	name = "Fox Mutation Toxin"
	description = "A foxin."
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/vulpkanin
	taste_description = "orange chicken"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE
	mutationtexts = list(
		"You feel pinpricks on your skin." = MUT_MSG_IMMEDIATE,
		"You notice a dusting of hair covering your body." = MUT_MSG_IMMEDIATE,
		"You are getting furrier." = MUT_MSG_EXTENDED,
		"Your nose is wet." = MUT_MSG_EXTENDED,
		"You feel very fuzzy." = MUT_MSG_ABOUT2TURN)

/datum/reagent/mutationtoxin/xenohybrid
	name = "Xenohybrid Mutation Toxin"
	description = "A xenohybrid toxin."
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/xeno
	taste_description = "sour apples"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE
	mutationtexts = list(
		"Your throat feels scratchy." = MUT_MSG_IMMEDIATE,
		"You can feel something move...inside." = MUT_MSG_IMMEDIATE,
		"Your skin feels tight." = MUT_MSG_EXTENDED,
		"Your blood boils!" = MUT_MSG_EXTENDED,
		"Your skin feels as if it's about to burst off!" = MUT_MSG_ABOUT2TURN)

/datum/reagent/mutationtoxin/zombie
	mutationtexts = list(
		"You notice a foul smell. It is you." = MUT_MSG_IMMEDIATE,
		"Black and green spots appear on your skin." = MUT_MSG_IMMEDIATE,
		"Your flesh rots but you feel nothing!" = MUT_MSG_EXTENDED,
		"Your blood coagulates!" = MUT_MSG_EXTENDED,
		"You feel a yearning for flesh and brains" = MUT_MSG_ABOUT2TURN)

//New chemical which only causes people to perform the 'weh' emote. No way to create this, currently will only be in rare foam grenades found as loot
/datum/reagent/juice_that_makes_you_weh
	name = "Juice That Makes You Weh"
	description = "A strange green chemical, will cause iliving beings to 'weh' uncontrollably for a time"
	color = "#37e427" // rgb: 165, 240, 238
	taste_description = "an odd sweetness with a hint of spice"
	metabolization_rate = 2 // metabolises 10x faster, will occur more often but not hang around for ages
	penetrates_skin = VAPOR
	ph = 5.5

//This code allows it to randomly proc regularly, causing a random pitch 'weh' sound
/datum/reagent/juice_that_makes_you_weh/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	. = ..()

	if (prob(50))
		to_chat(affected_mob, span_warning("You feel the urge to weh..."))
		addtimer(CALLBACK(src, PROC_REF(do_weh), affected_mob), rand(1, 4) SECONDS)

/datum/reagent/juice_that_makes_you_weh/proc/do_weh(mob/living/carbon/M)
	if (QDELETED(M))
		return
	M.emote("weh")


#undef MUT_MSG_IMMEDIATE
#undef MUT_MSG_EXTENDED
#undef MUT_MSG_ABOUT2TURN

#undef CYCLES_TO_TURN
#undef CYCLES_MSG_IMMEDIATE
#undef CYCLES_MSG_EXTENDED
