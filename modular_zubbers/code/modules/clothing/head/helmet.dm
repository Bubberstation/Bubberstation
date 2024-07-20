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
	return TRUE

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

//Bunny Ears from Monkee.

/obj/item/clothing/head/playbunnyears
	name = "bunny ears headband"
	desc = "A pair of bunny ears attached to a headband. One of the ears is already crooked."
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/bunnyears.dmi'
	icon_state = "playbunny_ears"
	greyscale_colors = "#39393f"
	greyscale_config = /datum/greyscale_config/playbunnyears
	greyscale_config_worn = /datum/greyscale_config/playbunnyears_worn
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/head/playbunnyears/syndicate
	name = "blood-red bunny ears headband"
	desc = "An unusually suspicious pair of bunny ears attached to a headband. The headband looks reinforced with plasteel... but why?"
	icon_state = "syndibunny_ears"
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
	icon_state = "playbunny_ears_centcom"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/british
	name = "british bunny ears headband"
	desc = "A pair of classy bunny ears attached to a headband. Worn to honor the crown."
	icon_state = "playbunny_ears_brit"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/communist
	name = "really red bunny ears headband"
	desc = "A pair of red and gold bunny ears attached to a headband. Commonly used by any collectivizing bunny waiters."
	icon_state = "playbunny_ears_communist"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/usa
	name = "usa bunny ears headband"
	desc = "A pair of star spangled bunny ears attached to a headband. The headband of a true patriot."
	icon_state = "playbunny_ears_usa"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

//CAPTAIN

/obj/item/clothing/head/hats/caphat/bunnyears_captain
	name = "captain's bunny ears"
	desc = "A pair of dark blue bunny ears attached to a headband. Worn in lieu of the more traditional bicorn hat."
	icon_state = "captain"
	inhand_icon_state = "that"
	dog_fashion = null

//CARGO

/obj/item/clothing/head/playbunnyears/quartermaster
	name = "quartermaster's bunny ears"
	desc = "Brown and gray bunny ears attached to a headband. The brown headband denotes relative importance."
	icon_state = "qm"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/bunnyears.dmi'
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/cargo
	name = "cargo bunny ears"
	desc = "Brown and gray bunny ears attached to a headband. The gray headband denotes relative unimportance."
	icon_state = "cargo_tech"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/bunnyears.dmi'
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/miner
	name = "shaft miner's bunny ears"
	desc = "Muddy gray bunny ears attached to a headband. Has zero resistance against the hostile lavaland atmosphere."
	icon_state = "explorer"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/bunnyears.dmi'
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/mailman
	name = "mailman's bunny ears"
	desc = "Blue and red bunny ears attached to a headband. Shows everyone your commitment to speed and efficiency."
	icon_state = "mail"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/bunnyears.dmi'
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

//ENGI

/obj/item/clothing/head/playbunnyears/engineer
	name = "engineering bunny ears"
	desc = "Yellow and orange bunny ears attached to a headband. Likely to get caught in heavy machinery."
	icon_state = "engi"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/atmos_tech
	name = "atmospheric technician's bunny ears"
	desc = "Yellow and blue bunny ears attached to a headband. Gives zero protection against both fires and extreme pressures."
	icon_state = "atmos"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/ce
	name = "chief engineer's bunny ears"
	desc = "Green and white bunny ears attached to a headband. Just keep them away from the supermatter."
	icon_state = "ce"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

//MEDICAL

/obj/item/clothing/head/playbunnyears/doctor
	name = "medical bunny ears"
	desc = "White and blue bunny ears attached to a headband. Certainly cuter than a head mirror."
	icon_state = "doctor"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/bunnyears.dmi'
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/paramedic
	name = "paramedic's bunny ears"
	desc = "Blue and white bunny ears attached to a headband. Marks you clearly as a bunny first responder, allowing you a high degree of respect and deference… yeah right."
	icon_state = "paramedic"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/bunnyears.dmi'
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/chemist
	name = "chemist's bunny ears"
	desc = "White and orange bunny ears attached to a headband. One of the ears is already crooked."
	icon_state = "chem"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/bunnyears.dmi'
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/pathologist
	name = "pathologist's bunny ears"
	desc = "White and green bunny ears attached to a headband. This is not proper PPE gear."
	icon_state = "virologist"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/bunnyears.dmi'
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/cmo
	name = "chief medical officer's bunny ears"
	desc = "White and blue bunny ears attached to a headband. A headband that commands respect from the entire medical team."
	icon_state = "cmo"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/bunnyears.dmi'
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

//SCIENCE

/obj/item/clothing/head/playbunnyears/scientist
	name = "scientist's bunny ears"
	desc = "Purple and white bunny ears attached to a headband. Completes the look for lagomorphic studies."
	icon_state = "science"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/bunnyears.dmi'
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/roboticist
	name = "roboticist's bunny ears"
	desc = "Black and red bunny ears attached to a headband. Installed with servos to imitate the movement of real bunny ears."
	icon_state = "roboticist"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/bunnyears.dmi'
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/geneticist
	name = "geneticist's bunny ears"
	desc = "Blue and white bunny ears attached to a headband. For when you have no bunnies to splice your genes with."
	icon_state = "genetics"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/bunnyears.dmi'
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/rd
	name = "research director's bunny ears"
	desc = "Purple and black bunny ears attached to a headband. Large amounts of funding went into creating a piece of headgear capable of increasing the wearers height, this is what was produced."
	icon_state = "rd"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/bunnyears.dmi'
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

//SECURITY

/obj/item/clothing/head/playbunnyears/security
	name = "security bunny ears"
	desc = "Red and black bunny ears attached to a headband. The band is made out of hardened steel."
	icon_state = "sec"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/bunnyears.dmi'
	clothing_flags = SNUG_FIT
	armor_type = /datum/armor/playbunnyears_security
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/datum/armor/playbunnyears_security
	melee = 30
	bullet = 30
	laser = 20
	energy = 30
	fire = 30
	bomb = 20
	acid = 30
	wound = 10

/obj/item/clothing/head/playbunnyears/security_assistant
	name = "security assistant's bunny ears"
	desc = "A pair of red and grey bunny ears attatched to a headband. Snugly fit, to keep it attatched during long distance tackles."
	icon_state = "sec_assistant"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/bunnyears.dmi'
	clothing_flags = SNUG_FIT
	armor_type = /datum/armor/playbunnyears_security
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/datum/armor/playbunnyears_security
	melee = 30
	bullet = 30
	laser = 20
	energy = 30
	fire = 30
	bomb = 20
	acid = 30
	wound = 10

//TODO: Find a way to add Warden stuff that isn't hack-y.

/obj/item/clothing/head/playbunnyears/warden
	name = "warden's bunny ears"
	desc = "Red and white bunny ears attached to a headband. Keeps the hair out of the face when checking on cameras."
	icon_state = "warden"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/bunnyears.dmi'
	clothing_flags = SNUG_FIT
	armor_type = /datum/armor/playbunnyears_security
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/brig_phys
	name = "brig physician's bunny ears"
	desc = "A pair of red and grey bunny ears attatched to a headband. Whoever's wearing these is surely a professional... right?"
	icon_state = "brig_phys"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/bunnyears.dmi'
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/detective
	name = "detective's bunny ears"
	desc = "Brown bunny ears attached to a headband. Big ears for listening to calls from hysteric dames."
	icon_state = "detective"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/bunnyears.dmi'
	armor_type = /datum/armor/playbunnyears_detective
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/datum/armor/playbunnyears_detective
	melee = 20
	laser = 20
	energy = 30
	fire = 30
	acid = 50
	wound = 5

/obj/item/clothing/head/playbunnyears/prisoner
	name = "prisoner's bunny ears"
	desc = "Black and orange bunny ears attached to a headband. This outfit was long ago outlawed under the space geneva convention for being a “cruel and unusual punishment”."
	icon_state = "prisoner"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/bunnyears.dmi'
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/hos
	name = "head of security's bunny ears"
	desc = "Red and gold bunny ears attached to a headband. Shows your authority over all bunny officers."
	icon_state = "hos"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/bunnyears.dmi'
	clothing_flags = SNUG_FIT
	armor_type = /datum/armor/playbunnyears_hos
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/datum/armor/playbunnyears_hos
	melee = 30
	bullet = 30
	laser = 20
	energy = 30
	fire = 30
	bomb = 20
	acid = 30
	wound = 10

//SERVICE

/obj/item/clothing/head/playbunnyears/hop
	name = "head of personnel's bunny ears"
	desc = "A pair of muted blue bunny ears attached to a headband. The preferred color of bunnycrats everywhere."
	icon_state = "hop"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/bunnyears.dmi'
	armor_type = /datum/armor/playbunnyears_hop
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/datum/armor/playbunnyears_hop
	melee = 20
	bullet = 10
	laser = 20
	energy = 30
	bomb = 20
	fire = 50
	acid = 50

/obj/item/clothing/head/playbunnyears/janitor
	name = "janitor's bunny ears"
	desc = "A pair of purple bunny ears attached to a headband. Kept meticulously clean."
	icon_state = "janitor"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/bunnyears.dmi'
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/bartender
	name = "bartender's bunny ears"
	desc = "A pair of classy black and white bunny ears attached to a headband. They smell faintly of alchohol."
	icon_state = "bar"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/bunnyears.dmi'
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	custom_price = PAYCHECK_CREW

/obj/item/clothing/head/playbunnyears/cook
	name = "cook's bunny ears"
	desc = "A pair of white and red bunny ears attached to a headband. Helps keep hair out of the food."
	icon_state = "chef"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/bunnyears.dmi'
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/botanist
	name = "botanist's bunny ears"
	desc = "A pair of green and blue bunny ears attached to a headband. Good for keeping the sweat out of your eyes during long days on the farm."
	icon_state = "botany"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/bunnyears.dmi'
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/clown
	name = "clown's bunny ears"
	desc = "A pair of orange and pink bunny ears. They even squeak."
	icon_state = "clown"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/bunnyears.dmi'
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/mime
	name = "mime's bunny ears"
	desc = "Red and black bunny ears attached to a headband. Great for street performers sick of the standard beret."
	icon_state = "mime"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/bunnyears.dmi'
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/chaplain
	name = "chaplain's bunny ears"
	desc = "A pair of black and white bunny ears attached to a headband. Worn in worship of The Gardener of Carota."
	icon_state = "chaplain"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/bunnyears.dmi'
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/curator_red
	name = "curator's red bunny ears"
	desc = "A pair of red and beige bunny ears attached to a headband. Marks you as an expert in all things bunny related."
	icon_state = "curator_red"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/bunnyears.dmi'
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/curator_green
	name = "curator's green bunny ears"
	desc = "A pair of green and black bunny ears attached to a headband. Marks you as an expert in all things bunny related."
	icon_state = "curator_green"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/bunnyears.dmi'
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/curator_teal
	name = "curator's teal bunny ears"
	desc = "A pair of teal bunny ears attached to a headband. Marks you as an expert in all things bunny related."
	icon_state = "curator_teal"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/bunnyears.dmi'
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/lawyer_black
	name = "lawyer's black bunny ears"
	desc = "A pair of black bunny ears attached to a headband. The perfect headband to wear while negotiating a settlement."
	icon_state = "lawyer_black"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/bunnyears.dmi'
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/lawyer_blue
	name = "lawyer's blue bunny ears"
	desc = "A pair of blue and white bunny ears attached to a headband. The perfect headband to wear while negotiating a settlement."
	icon_state = "lawyer_blue"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/bunnyears.dmi'
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/lawyer_red
	name = "lawyer's red bunny ears"
	desc = "A pair of red and white bunny ears attached to a headband. The perfect headband to wear while negotiating a settlement."
	icon_state = "lawyer_red"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/bunnyears.dmi'
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/lawyer_good
	name = "good lawyer's bunny ears"
	desc = "A pair of beige and blue bunny ears attached to a headband. The perfect headband to wear while negotiating a settlement."
	icon_state = "lawyer_good"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/bunnyears.dmi'
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/psychologist
	name = "psychologist's bunny ears"
	desc = "A pair of black bunny ears. And how do they make you feel?"
	icon_state = "psychologist"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/bunnyears.dmi'
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

