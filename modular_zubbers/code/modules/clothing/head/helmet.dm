/obj/item/clothing/head/helmet/metrocophelmet
	name = "Civil Protection Helmet"
	flags_inv = HIDEHAIR | HIDEFACE | HIDESNOUT | HIDEFACIALHAIR
	desc = "Standard issue helmet for Civil Protection."
	icon = 'modular_zubbers/icons/mob/clothing/head/helmet.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/helmet.dmi'
	icon_state = "metrocopHelm"
	inhand_icon_state = null
	armor_type = /datum/armor/head_helmet

/obj/item/clothing/head/helmet/abductor/fake
	name = "Kabrus Utility Helmet"
	desc = "A very plain helmet used by the Greys of the Kabrus Mining Site. This helmet only protects the wearer from wind and rain it seems."
	icon_state = "alienhelmet"
	inhand_icon_state = null
	armor_type = /datum/armor/none
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT

/obj/item/clothing/head/helmet/toggleable/pinwheel //sprites by Keila
	name = "pinwheel hat"
	desc = "Space Jesus gives his silliest hats to his most whimsical of goobers."
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/hats.dmi'
	icon_state = "pinwheel"
	inhand_icon_state = null
	lefthand_file = null
	righthand_file = null
	armor_type = /datum/armor/none
	clothing_flags = null
	flags_cover = null
	flags_inv = null
	toggle_message = "You stop the spinner on"
	alt_toggle_message = "You spin the spinner on"
	actions_types = list(/datum/action/item_action/toggle_helmet_light)
	///Cooldown for toggling the spinner.
	COOLDOWN_DECLARE(pinwheel_toggle_cooldown)

/obj/item/clothing/head/helmet/toggleable/pinwheel/adjust_visor()
	if(!COOLDOWN_FINISHED(src, pinwheel_toggle_cooldown))
		return FALSE
	COOLDOWN_START(src, pinwheel_toggle_cooldown, 1 SECONDS)
	return ..()

/obj/item/clothing/head/helmet/toggleable/pinwheel/gold
	name = "magnificent pinwheel hat"
	desc = "The strongest possible pinwheel pinwheel hat. Such is fate that the silliest things in the world are also the most beautiful; others may not see the shine in you, but the magnificent pinwheel hat does. It appreciates you for who you are and what you've done. It feels alive, and makes you feel alive too. You see the totality of existence reflected in the golden shimmer of the pin." //Does literally nothing more than the regular pinwheel hat. Just for emphasis.
	icon_state = "pinwheel_gold"


//Clussy and Jester sprites from Splurt.
/obj/item/clothing/head/costume/bubber/jester
	name = "amazing jester hat"
	desc = "It's my money, it's my game, Kill Jester."
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/hats.dmi'
	icon_state = "striped_jester_hat"

/obj/item/clothing/head/costume/bubber/clussy
	name = "pink clown wig"
	desc = "Did you know that the first Wig was made for John William Whig, founder of the Whig Party? They only allowed bald men until the year 1972, when the party became unpopular."
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/hats.dmi'
	icon_state = "clussy_wig"
	flags_inv = HIDEHAIR

// Henchmen Sprites by Cannibal Hunter of MonkeStation

/obj/item/clothing/head/henchmen_hat
	name = "henchmen cap"
	desc = "Alright boss.. I'll handle it."
	icon = 'icons/map_icons/clothing/head/_head.dmi'
	icon_state = "/obj/item/clothing/head/henchmen_hat"
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/hats.dmi'
	post_init_icon_state = "greyscale_cap"
	greyscale_colors = "#201b1a"
	greyscale_config = /datum/greyscale_config/henchmen
	greyscale_config_worn = /datum/greyscale_config/henchmen/worn
	flags_1 = IS_PLAYER_COLORABLE_1


//ALL BUNNY STUFF BY DimWhat OF MONKEESTATION

/obj/item/clothing/head/playbunnyears
	name = "bunny ears headband"
	desc = "A pair of bunny ears attached to a headband. One of the ears is already crooked."
	icon = 'icons/map_icons/clothing/head/_head.dmi'
	icon_state = "/obj/item/clothing/head/playbunnyears"
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/bunnyears.dmi'
	post_init_icon_state = "playbunny_ears"
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON
	greyscale_colors = "#39393f"
	greyscale_config = /datum/greyscale_config/playbunnyears
	greyscale_config_worn = /datum/greyscale_config/playbunnyears_worn
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/head/playbunnyears/syndicate
	name = "blood-red bunny ears headband"
	desc = "An unusually suspicious pair of bunny ears attached to a headband. The headband looks reinforced with plasteel... but why?"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "syndibunny_ears"
	post_init_icon_state = null
	clothing_flags = SNUG_FIT
	armor_type = /datum/armor/head_helmet
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/syndicate/fake
	armor_type = /datum/armor/none

/obj/item/clothing/head/playbunnyears/centcom
	name = "centcom bunny ears headband"
	desc = "A pair of very professional bunny ears attached to a headband. The ears themselves came from an endangered species of green rabbits."
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "playbunny_ears_centcom"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/british
	name = "british bunny ears headband"
	desc = "A pair of classy bunny ears attached to a headband. Worn to honor the crown."
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "playbunny_ears_brit"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/communist
	name = "really red bunny ears headband"
	desc = "A pair of red and gold bunny ears attached to a headband. Commonly used by any collectivizing bunny waiters."
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "playbunny_ears_communist"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/usa
	name = "usa bunny ears headband"
	desc = "A pair of star spangled bunny ears attached to a headband. The headband of a true patriot."
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "playbunny_ears_usa"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

//CAPTAIN

/obj/item/clothing/head/hats/caphat/bunnyears_captain
	name = "captain's bunny ears"
	desc = "A pair of dark blue bunny ears attached to a headband. Worn in lieu of the more traditional bicorn hat."
	icon_state = "captain"
	inhand_icon_state = "that"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/bunnyears.dmi'
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON
	dog_fashion = null

//CARGO

/obj/item/clothing/head/playbunnyears/quartermaster
	name = "quartermaster's bunny ears"
	desc = "Brown and gray bunny ears attached to a headband. The brown headband denotes relative importance."
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "qm"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/cargo
	name = "cargo bunny ears"
	desc = "Brown and gray bunny ears attached to a headband. The gray headband denotes relative unimportance."
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "cargo_tech"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/miner
	name = "shaft miner's bunny ears"
	desc = "Muddy gray bunny ears attached to a headband. Has zero resistance against the hostile lavaland atmosphere."
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "explorer"
	post_init_icon_state = null
	armor_type = /datum/armor/hooded_explorer
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/mailman
	name = "mailman's bunny ears"
	desc = "Blue and red bunny ears attached to a headband. Shows everyone your commitment to speed and efficiency."
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "mail"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/bitrunner
	name = "bunrunner's bunny ears"
	desc = "Black and gold with stains of space mountain. The official wear of the Carota E-Sports team."
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "bitrunner"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

//ENGI

/obj/item/clothing/head/playbunnyears/engineer
	name = "engineering bunny ears"
	desc = "Yellow and orange bunny ears attached to a headband. Likely to get caught in heavy machinery."
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "engi"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/atmos_tech
	name = "atmospheric technician's bunny ears"
	desc = "Yellow and blue bunny ears attached to a headband. Gives zero protection against both fires and extreme pressures."
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "atmos"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/ce
	name = "chief engineer's bunny ears"
	desc = "Green and white bunny ears attached to a headband. Just keep them away from the supermatter."
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "ce"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

//MEDICAL

/obj/item/clothing/head/playbunnyears/doctor
	name = "medical bunny ears"
	desc = "White and blue bunny ears attached to a headband. Certainly cuter than a head mirror."
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "doctor"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/paramedic
	name = "paramedic's bunny ears"
	desc = "Blue and white bunny ears attached to a headband. Marks you clearly as a bunny first responder, allowing you a high degree of respect and deference… yeah right."
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "paramedic"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/chemist
	name = "chemist's bunny ears"
	desc = "White and orange bunny ears attached to a headband. One of the ears is already crooked."
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "chem"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/pathologist
	name = "pathologist's bunny ears"
	desc = "White and green bunny ears attached to a headband. This is not proper PPE gear."
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "virologist"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/coroner
	name = "coroner's bunny ears"
	desc = "Black and white bunny ears attached to a headband. Please don't wear this to a funeral."
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "coroner"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/cmo
	name = "chief medical officer's bunny ears"
	desc = "White and blue bunny ears attached to a headband. A headband that commands respect from the entire medical team."
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "cmo"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

//SCIENCE

/obj/item/clothing/head/playbunnyears/scientist
	name = "scientist's bunny ears"
	desc = "Purple and white bunny ears attached to a headband. Completes the look for lagomorphic studies."
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "science"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/roboticist
	name = "roboticist's bunny ears"
	desc = "Black and red bunny ears attached to a headband. Installed with servos to imitate the movement of real bunny ears."
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "roboticist"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/geneticist
	name = "geneticist's bunny ears"
	desc = "Blue and white bunny ears attached to a headband. For when you have no bunnies to splice your genes with."
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "genetics"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/rd
	name = "research director's bunny ears"
	desc = "Purple and black bunny ears attached to a headband. Large amounts of funding went into creating a piece of headgear capable of increasing the wearers height, this is what was produced."
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "rd"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

//SECURITY

/obj/item/clothing/head/playbunnyears/security
	name = "security bunny ears"
	desc = "Red and black bunny ears attached to a headband. The band is made out of hardened steel."
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "sec"
	post_init_icon_state = null
	clothing_flags = SNUG_FIT
	armor_type = /datum/armor/head_helmet
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null


/obj/item/clothing/head/playbunnyears/security/assistant
	name = "security assistant's bunny ears"
	desc = "A pair of red and grey bunny ears attatched to a headband. Snugly fit, to keep it attatched during long distance tackles."
	icon_state = "sec_assistant"

//TODO: Find a way to add Warden stuff that isn't hack-y.

/obj/item/clothing/head/playbunnyears/warden
	name = "warden's bunny ears"
	desc = "Red and white bunny ears attached to a headband. Keeps the hair out of the face when checking on cameras."
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "warden"
	post_init_icon_state = null
	clothing_flags = SNUG_FIT
	armor_type = /datum/armor/head_helmet
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/brig_phys
	name = "brig physician's bunny ears"
	desc = "A pair of red and grey bunny ears attatched to a headband. Whoever's wearing these is surely a professional... right?"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "brig_phys"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/detective
	name = "detective's bunny ears"
	desc = "Brown bunny ears attached to a headband. Big ears for listening to calls from hysteric dames."
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "detective"
	post_init_icon_state = null
	armor_type = /datum/armor/fedora_det_hat
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null


/obj/item/clothing/head/playbunnyears/detective/noir
	name = "noir detective's bunny ears"
	desc = "Black bunny ears attached to a white headband. Big ears for listening to calls from hysteric dames. In glorious black and white!"
	icon_state = "detective_noir"

/obj/item/clothing/head/playbunnyears/prisoner
	name = "prisoner's bunny ears"
	desc = "Black and orange bunny ears attached to a headband. This outfit was long ago outlawed under the space geneva convention for being a “cruel and unusual punishment”."
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "prisoner"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/hos
	name = "head of security's bunny ears"
	desc = "Red and gold bunny ears attached to a headband. Shows your authority over all bunny officers."
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "hos"
	post_init_icon_state = null
	clothing_flags = SNUG_FIT
	armor_type = /datum/armor/hats_hos
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

//SERVICE

/obj/item/clothing/head/playbunnyears/hop
	name = "head of personnel's bunny ears"
	desc = "A pair of muted blue bunny ears attached to a headband. The preferred color of bunnycrats everywhere."
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "hop"
	post_init_icon_state = null
	armor_type = /datum/armor/hats_hopcap
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/janitor
	name = "janitor's bunny ears"
	desc = "A pair of purple bunny ears attached to a headband. Kept meticulously clean."
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "janitor"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/bartender
	name = "bartender's bunny ears"
	desc = "A pair of classy black and white bunny ears attached to a headband. They smell faintly of alchohol."
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "bar"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	custom_price = PAYCHECK_CREW

/obj/item/clothing/head/playbunnyears/cook
	name = "cook's bunny ears"
	desc = "A pair of white and red bunny ears attached to a headband. Helps keep hair out of the food."
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "chef"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/botanist
	name = "botanist's bunny ears"
	desc = "A pair of green and blue bunny ears attached to a headband. Good for keeping the sweat out of your eyes during long days on the farm."
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "botany"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/clown
	name = "clown's bunny ears"
	desc = "A pair of orange and pink bunny ears. They even squeak."
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "clown"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/mime
	name = "mime's bunny ears"
	desc = "Red and black bunny ears attached to a headband. Great for street performers sick of the standard beret."
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "mime"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/chaplain
	name = "chaplain's bunny ears"
	desc = "A pair of black and white bunny ears attached to a headband. Worn in worship of The Gardener of Carota."
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "chaplain"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/curator_red
	name = "curator's red bunny ears"
	desc = "A pair of red and beige bunny ears attached to a headband. Marks you as an expert in all things bunny related."
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "curator_red"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/curator_green
	name = "curator's green bunny ears"
	desc = "A pair of green and black bunny ears attached to a headband. Marks you as an expert in all things bunny related."
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "curator_green"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/curator_teal
	name = "curator's teal bunny ears"
	desc = "A pair of teal bunny ears attached to a headband. Marks you as an expert in all things bunny related."
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "curator_teal"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/lawyer_black
	name = "lawyer's black bunny ears"
	desc = "A pair of black bunny ears attached to a headband. The perfect headband to wear while negotiating a settlement."
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "lawyer_black"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/lawyer_blue
	name = "lawyer's blue bunny ears"
	desc = "A pair of blue and white bunny ears attached to a headband. The perfect headband to wear while negotiating a settlement."
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "lawyer_blue"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/lawyer_red
	name = "lawyer's red bunny ears"
	desc = "A pair of red and white bunny ears attached to a headband. The perfect headband to wear while negotiating a settlement."
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "lawyer_red"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/lawyer_good
	name = "good lawyer's bunny ears"
	desc = "A pair of beige and blue bunny ears attached to a headband. The perfect headband to wear while negotiating a settlement."
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "lawyer_good"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/psychologist
	name = "psychologist's bunny ears"
	desc = "A pair of black bunny ears. And how do they make you feel?"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "psychologist"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

//BUNNY STUFF END, SPRITES BY DimWhat OF MONKE STATION

//Maid SEC
/obj/item/clothing/head/security_maid //Icon by Onule!
	name = "cnc maid headband"
	desc = "A highly durable headband with the 'cleaning and clearing' insignia emblazoned on it. Uses reinforced fabric to offer sufficient protection."
	icon_state = "security_maid"
	icon = 'modular_zubbers/icons/obj/clothing/head/helmet.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/helmet.dmi'
	armor_type = /datum/armor/head_helmet
	strip_delay = 60

//BEGIN HAT SPRITES BY APRIL

/obj/item/clothing/head/security_kepi
	name = "security kepi"
	desc = "Bonjour, inspecteur. A kepi police cap first popularized by planetary police on Pluto. This one appears armored."
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/hats.dmi'
	icon_state = "kepi_sec_red"
	uses_advanced_reskins = TRUE
	armor_type = /datum/armor/head_helmet
	strip_delay = 60
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON
	unique_reskin = list(
		"Red Security Kepi" = list(
			RESKIN_ICON_STATE = "kepi_sec_red",
			RESKIN_WORN_ICON_STATE = "kepi_sec_red"
		),
		"Blue Security Kepi" = list(
			RESKIN_ICON_STATE = "kepi_sec_blue",
			RESKIN_WORN_ICON_STATE = "kepi_sec_blue"
		),
		"White Security Kepi" = list(
			RESKIN_ICON_STATE = "kepi_sec_white",
			RESKIN_WORN_ICON_STATE = "kepi_sec_white"
		),
		"Black Security Kepi" = list(
			RESKIN_ICON_STATE = "kepi_sec_black",
			RESKIN_WORN_ICON_STATE = "kepi_sec_black"
		),
	)

/obj/item/clothing/head/hos_kepi
	name = "HoS kepi"
	desc = "Bonjour, commandante. A kepi for the Head of Security. It has a embroidered pattern going around it. This one appears well armored."
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/hats.dmi'
	icon_state = "kepi_sec_red_hos"
	uses_advanced_reskins = TRUE
	armor_type = /datum/armor/hats_hos
	strip_delay = 60
	unique_reskin = list(
		"Red HoS Kepi" = list(
			RESKIN_ICON_STATE = "kepi_sec_red_hos",
			RESKIN_WORN_ICON_STATE = "kepi_sec_red_hos"
		),
		"Blue HoS Kepi" = list(
			RESKIN_ICON_STATE = "kepi_sec_blue_hos",
			RESKIN_WORN_ICON_STATE = "kepi_sec_blue_hos"
		),
	)

// END HATS ADDED BY APRIL

/obj/item/clothing/head/helmet/elder_atmosian
	desc = "The pinnacle of atmospherics equipment, an expensive modified atmospherics fire helmet plated in one of the most luxurous and durable metals known to man. Providing full atmos coverage without the heavy materials to slow the user down, it also offers far greater protection to most sources of damage, even offering great protection against gases, and other nasty things that try to get into your face."
	icon = 'modular_zubbers/icons/obj/clothing/head/helmet.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/helmet.dmi'
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/head/helmet_teshari.dmi'
	clothing_flags = STOPSPRESSUREDAMAGE | THICKMATERIAL | BLOCK_GAS_SMOKE_EFFECT | STACKABLE_HELMET_EXEMPT | SNUG_FIT | HEADINTERNALS
	material_flags = NONE
	heat_protection = HEAD
	cold_protection = HEAD
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	min_cold_protection_temperature = FIRE_HELM_MIN_TEMP_PROTECT
	resistance_flags = FIRE_PROOF
	flags_inv = HIDEFACE | HIDEFACIALHAIR | HIDEHAIR | HIDEMASK | HIDEEYES | HIDEEARS

/datum/armor/helmet_elder_atmosian
	melee = 40
	bullet = 30
	laser = 40
	energy = 40
	bomb = 100
	bio = 50
	fire = 100
	acid = 50
	wound = 25
