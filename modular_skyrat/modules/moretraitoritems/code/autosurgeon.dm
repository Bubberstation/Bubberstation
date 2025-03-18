/obj/item/autosurgeon/toolset
	starting_organ = /obj/item/organ/cyberimp/arm/toolset

/obj/item/autosurgeon/surgery
	starting_organ = /obj/item/organ/cyberimp/arm/surgery

/obj/item/autosurgeon/botany
	starting_organ = /obj/item/organ/cyberimp/arm/botany

/obj/item/autosurgeon/janitor
	starting_organ = /obj/item/organ/cyberimp/arm/janitor

/obj/item/autosurgeon/armblade
	starting_organ = /obj/item/organ/cyberimp/arm/armblade

/obj/item/autosurgeon/muscle
	starting_organ = /obj/item/organ/cyberimp/arm/strongarm

//syndie
/obj/item/autosurgeon/syndicate/hackerman
	starting_organ = /obj/item/organ/cyberimp/arm/hacker

/obj/item/autosurgeon/syndicate/esword_arm
	starting_organ = /obj/item/organ/cyberimp/arm/esword

/obj/item/autosurgeon/syndicate/nodrop
	starting_organ = /obj/item/organ/cyberimp/brain/anti_drop

/obj/item/autosurgeon/syndicate/baton
	starting_organ = /obj/item/organ/cyberimp/arm/baton

/obj/item/autosurgeon/syndicate/flash
	starting_organ = /obj/item/organ/cyberimp/arm/flash

//bodypart
/obj/item/autosurgeon/bodypart/r_arm_robotic
	starting_bodypart = /obj/item/bodypart/arm/right/robot

/obj/item/autosurgeon/bodypart/r_arm_robotic/Initialize(mapload)
	. = ..()
	storedbodypart.icon = 'modular_skyrat/master_files/icons/mob/augmentation/hi2ipc.dmi'

//xeno-organs
/obj/item/autosurgeon/xeno
	name = "strange autosurgeon"
	icon = 'modular_skyrat/modules/moretraitoritems/icons/alien.dmi'
	surgery_speed = 2
	organ_whitelist = list(/obj/item/organ/alien)

/obj/item/organ/alien/plasmavessel/opfor
	stored_plasma = 500
	max_plasma = 500
	plasma_rate = 10

/obj/item/storage/organbox/strange
	name = "strange organ transport box"
	icon = 'modular_skyrat/modules/moretraitoritems/icons/alien.dmi'

/obj/item/storage/organbox/strange/Initialize(mapload)
	. = ..()
	reagents.add_reagent_list(list(/datum/reagent/cryostylane = 60))

/obj/item/storage/organbox/strange/PopulateContents()
	new /obj/item/autosurgeon/xeno(src)
	new /obj/item/organ/alien/plasmavessel/opfor(src)
	new /obj/item/organ/alien/resinspinner(src)
	new /obj/item/organ/alien/acid(src)
	new /obj/item/organ/alien/neurotoxin(src)
	new /obj/item/organ/alien/hivenode(src)

/obj/item/storage/organbox/strange/eggsac/PopulateContents()
	. = ..()
	new /obj/item/organ/alien/eggsac(src)
