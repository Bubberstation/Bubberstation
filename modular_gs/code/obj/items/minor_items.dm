/////GS13 - miscellanous items. If it's a small item, a container or something
/////then it should land here, instead of making a seperate .dm file

//fatoray research scraps (maintloot)

/obj/item/trash/fatoray_scrap1
	name = "raygun scraps"
	icon = 'modular_gs/icons/obj/fatoray.dmi'
	icon_state = "fatoray_scrap1"
	desc = "Small parts that seemingly once belonged to some sort of a raygun."

/obj/item/trash/fatoray_scrap2
	name = "raygun scraps"
	icon = 'modular_gs/icons/obj/fatoray.dmi'
	icon_state = "fatoray_scrap2"
	desc = "Small parts that seemingly once belonged to some sort of a raygun."
/*
// GS13 fatty liquid beakers defs, for admin stuff and mapping junk

/obj/item/reagent_containers/glass/beaker/lipoifier
	list_reagents = list(/datum/reagent/consumable/lipoifier = 50)

/obj/item/reagent_containers/glass/beaker/cornoil
	list_reagents = list(/datum/reagent/consumable/cornoil = 50)

/obj/item/reagent_containers/glass/beaker/blueberry_juice
	list_reagents = list(/datum/reagent/blueberry_juice = 50)

/obj/item/reagent_containers/glass/beaker/fizulphite
	list_reagents = list(/datum/reagent/consumable/fizulphite = 50)

/obj/item/reagent_containers/glass/beaker/extilphite
	list_reagents = list(/datum/reagent/consumable/extilphite = 50)

/obj/item/reagent_containers/glass/beaker/calorite_blessing
	list_reagents = list(/datum/reagent/consumable/caloriteblessing = 50)

/obj/item/reagent_containers/glass/beaker/flatulose
	list_reagents = list(/datum/reagent/consumable/flatulose = 50)

/obj/item/reagent_containers/glass/beaker/galbanic
	list_reagents = list(/datum/reagent/fermi_fat = 50)

/obj/item/reagent_containers/glass/beaker/macarenic
	list_reagents = list(/datum/reagent/fermi_slim = 50)

//evil fucking donut

/obj/item/food/donut/evil_superfat
	name = "Evil Fuckin' Donut"
	desc = "Merely looking at this thing makes you feel like you're getting fat..."
	bitesize = 100 // Always eat it in one bite
	list_reagents = list(/datum/reagent/fermi_fat = 120, /datum/reagent/consumable/lipoifier = 70, /datum/reagent/consumable/cornoil = 70)
	tastes = list("imminent immobility" = 10)

//blueberry gum snack

/obj/item/food/blueberry_gum
	name = "blueberry gum"
	icon = 'modular_gs/icons/obj/gum.dmi'
	icon_state = "gum_wrapped"
	desc = "Doesn't cause anything more than some discoloration... probably."
	trash = /obj/item/trash/blueberry_gum
	list_reagents = list(/datum/reagent/blueberry_juice = 50)
	bitesize = 5
	filling_color = "#001aff"
	tastes = list("blueberry gum" = 1)
	foodtype = FRUIT

//blueberry gum trash

/obj/item/trash/blueberry_gum
	name = "chewed gum"
	icon = 'modular_gs/icons/obj/gum.dmi'
	icon_state = "gum_chewed"

// nutriment pump turbo

/obj/item/autosurgeon/nutripump_turbo
	desc = "A single use autosurgeon that contains a turbo version of the nutriment pump. A screwdriver can be used to remove it, but implants can't be placed back in."
	uses = 1
	starting_organ = /obj/item/organ/cyberimp/chest/nutriment/turbo

/obj/item/autosurgeon/fat_mobility
	desc = "A single use autosurgeon that contains a mobility nanite core. A screwdriver can be used to remove it, but implants can't be placed back in."
	uses = 1
	starting_organ = /obj/item/organ/cyberimp/chest/mobility

//fast food restaurant - closed / open signs
/obj/item/holosign_creator/restaurant
	name = "Holosign Projector - Restaurant Adverts"
	desc = "A holo-sign maker, used for placing signs that advertises the local fast food restaurant."
	icon = 'modular_gs/icons/obj/holosign.dmi'
	icon_state = "holo_fastfood"
	holosign_type = /obj/structure/holosign/restaurant
	creation_time = 0
	max_signs = 6

/obj/item/holosign_creator/closed
	name = "Holosign Projector - Closing Sign"
	desc = "A holo-sign maker, used for placing signs that inform people of a location being closed off."
	icon = 'modular_gs/icons/obj/holosign.dmi'
	icon_state = "holo_closed"
	holosign_type = /obj/structure/holosign/barrier/closed
	creation_time = 0
	max_signs = 6

//holosigns used by the holosign creators
/obj/structure/holosign/restaurant
	name = "The Restaurant is OPEN! Come visit!"
	desc = "A holographic projector that displays a sign advertising the nearby Fast Food Restaurant."
	icon = 'modular_gs/icons/obj/holosign.dmi'
	icon_state = "holosign_ad"

/obj/structure/holosign/barrier/closed
	name = "This Location is Closed!"
	desc = "A short holographic barrier used to close off areas. Can be passed by walking."
	icon = 'modular_gs/icons/obj/holosign.dmi'
	icon_state = "holosign_closed"

//ID for fastfood wagies so they can use the tele
/obj/item/card/id/silver/restaurant
	name = "silver identification card"
	desc = "A silver ID, given to the GATO's fast food restaurant workers. Doesn't grant much besides teleporter access."
	access = list(ACCESS_MAINT_TUNNELS, ACCESS_TELEPORTER)

//gato decal, should be moved elsewhere tbh
/obj/effect/decal/big_gato //96x96 px sprite
	name = "GATO"
	desc = "Your employer! Probably."
	icon = 'modular_gs/icons/turf/96x96.dmi'
	icon_state = "gato"
	layer = ABOVE_OPEN_TURF_LAYER
	pixel_x = -32
	pixel_y = -32

/obj/effect/decal/medium_gato //64x64 px sprite
	name = "GATO"
	desc = "Your employer! Probably."
	icon = 'modular_gs/icons/turf/64x64.dmi'
	icon_state = "gato"
	layer = ABOVE_OPEN_TURF_LAYER
	pixel_y = -16
	pixel_x = -16


//collar voice modulators, based on cow/pig masks

/obj/item/clothing/mask/pig/gag //this one only lets you say "oink" and similar
	name = "Voice modulator - pig"
	desc = "A small gag, used to silence people in a rather 'original' way."
	icon = 'modular_gs/icons/obj/masks.dmi'
	mob_overlay_icon = 'modular_gs/icons/mob/mask.dmi'
	icon_state = "ballgag"
	item_state = "ballgag"
	flags_inv = HIDEFACE
	clothing_flags = VOICEBOX_TOGGLABLE
	w_class = WEIGHT_CLASS_SMALL
	modifies_speech = TRUE

/obj/item/clothing/mask/cowmask/gag //this one only lets you say "moo" and similar
	name = "Voice modulator - cow"
	desc = "A small gag, used to silence people in a rather 'original' way."
	icon = 'modular_gs/icons/obj/masks.dmi'
	mob_overlay_icon = 'modular_gs/icons/mob/mask.dmi'
	icon_state = "ballgag"
	item_state = "ballgag"
	flags_inv = HIDEFACE

/obj/item/service_sign
	name = "service sign"
	desc = "A sign that reads 'closed'"
	icon = 'modular_gs/icons/obj/service_sign.dmi'
	icon_state = "sign_closed"

/obj/item/service_sign/attack_self()
	if(icon_state == "sign_closed")
		icon_state = "sign_open"
		desc = "A sign that reads 'open'"
	else
		icon_state = "sign_closed"
		desc = "A sign that reads 'closed'"

/obj/item/trash/odd_disk
	name = "odd disk"
	icon = 'icons/obj/module.dmi'
	icon_state = "datadisk0"
	desc = "A dusty disk, desconstruction will be needed to recover data."

//GS 13 Port - Big gulps in all sizes
/obj/item/reagent_containers/cup/flask/paper_cup
	name = "paper cup"
	icon = 'modular_gs/icons/obj/paper_cups.dmi'
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list(5, 10, 15, 20, 25, 30, 50)
	volume = 50
	reagent_flags = OPENCONTAINER
	spillable = TRUE
	container_HP = 5
	pickup_sound = 'sound/items/handling/cardboardbox_pickup.ogg'
	drop_sound = 'sound/items/handling/cardboardbox_drop.ogg'

/obj/item/reagent_containers/cup/flask/paper_cup/small
	name = "Small Gulp Cup"
	desc = "A paper cup. It can hold up to 50 units. It's not very strong."
	icon_state = "small"
	custom_materials = list(/datum/material/plastic=200)
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/cup/flask/paper_cup/medium
	name = "Medium Gulp Cup"
	desc = "It's a paper cup, but you wouldn't call it 'medium' though. It can hold up to 75 units. It's not very strong."
	icon_state = "medium"
	volume = 75
	custom_materials = list(/datum/material/plastic=300)
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/cup/flask/paper_cup/big
	name = "Big Gulp Cup"
	desc = "A huge paper cup, a normal person would struggle to drink it all in one sitting. It can hold up to 120 units. It's not very strong."
	icon_state = "big"
	volume = 120
	custom_materials = list(/datum/material/plastic=500)
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/reagent_containers/cup/flask/paper_cup/extra_big
	name = "Extra Big Gulp Cup"
	desc = "A comically large paper cup. It can hold up to 160 units. It's not very strong."
	icon_state = "extra_big"
	volume = 160
	custom_materials = list(/datum/material/plastic=600)
	w_class = WEIGHT_CLASS_BULKY

/obj/item/reagent_containers/cup/flask/paper_cup/super_extra_big
	name = "Super Extra Big Gulp Cup"
	desc = "Its called a paper 'cup', but it looks more like an oversized bucket to you. It can hold up to 250 units. It's not very strong."
	icon_state = "super_extra_big"
	volume = 250
	custom_materials = list(/datum/material/plastic=1000)
	w_class = WEIGHT_CLASS_HUGE


//weapon prefabs

/obj/item/melee/curator_whip/fattening
	name = "calorite-lined whip"
	desc = "The whip seems to glisten with an orange gleam inbetween its threads."
	damtype = "fat"
	attack_verb = list("fattened")
	force = 40

/obj/item/melee/curator_whip/permafattening
	name = "galbanic whip"
	desc = "How can a whip even be infused galbanic? No one knows."
	damtype = "perma_fat"
	attack_verb = list("fattened")
	force = 20

/obj/item/gavelhammer/fattening
	desc = "Some madman managed to create a weapon out of calorite... Luckily, it has a rubber handle for you to wield."
	name = "Calorite Hammer"
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "toyhammer"
	damtype = "fat"
	throwforce = 40
	force = 60
	attack_verb = list("fattened")

/obj/item/gavelhammer/permafattening
	desc = "You may ask yourself - how did someone make a hammer out of a chemical? The answer is clear: no one knows."
	name = "Permafat Hammer"
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "toyhammer"
	damtype = "perma_fat"
	throwforce = 10
	force = 20
	attack_verb = list("fattened")

*/