/obj/item/clothing/underwear/shirt
	name = "shirt"
	desc = "A shirt."
	icon_state = "undershirt"
	body_parts_covered = CHEST | ARMS
	extra_slot_flags = ITEM_SLOT_SHIRT
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/underwear/shirt/equipped(mob/living/user, slot)
	. = ..()
	if(!istype(user, /mob/living/carbon/human) || istype(src, /obj/item/clothing/underwear/shirt/bra))
		return
	var/mob/living/carbon/human/human = user
	if(slot == ITEM_SLOT_SHIRT)
		human.undershirt = name
	else
		human.undershirt = "Nude"

/obj/item/clothing/underwear/shirt/bra
	name = "bra"
	desc = "A bra."
	icon_state = "bra"
	body_parts_covered = CHEST
	extra_slot_flags = ITEM_SLOT_BRA
	female_sprite_flags = NO_FEMALE_UNIFORM

/obj/item/clothing/underwear/shirt/bra/equipped(mob/living/user, slot)
	. = ..()
	if(!istype(user, /mob/living/carbon/human))
		return
	var/mob/living/carbon/human/human = user
	if(slot == ITEM_SLOT_BRA)
		human.bra = name
	else
		human.bra = "Nude"

// please make sure they're sorted alphabetically and categorized, above is the only exception

/* Old shirt objects, already handled by the sprite accessories
/obj/item/clothing/underwear/shirt/alien
	name = "alien shirt"
	desc = "I regret nothing."
	icon_state = "undershirt_alien"

/obj/item/clothing/underwear/shirt/band
	name = "band shirt"
	icon_state = "undershirt_band"

/obj/item/clothing/underwear/shirt/bee
	name = "bee shirt"
	desc = "Bee yourself!"
	icon_state = "undershirt_bee"

/obj/item/clothing/underwear/shirt/corset
	name = "corset"
	desc = "A support garment commonly worn to hold and train the torso into a desired shape, traditionally a smaller waist or larger bottom, for aesthetic or medical purposes, or support the breasts."
	body_parts_covered = CHEST
	icon_state = "corset"

/obj/item/clothing/underwear/shirt/bluejersey
	name = "blue jersey shirt"
	icon_state = "undershirt_bluejersey"

/obj/item/clothing/underwear/shirt/bowling
	name = "red bowling shirt"
	icon_state = "undershirt_bowling_red"

/obj/item/clothing/underwear/shirt/bowling/cyan
	name = "cyan bowling shirt"
	icon_state = "undershirt_bowling_cyan"

/obj/item/clothing/underwear/shirt/bowling/grey
	name = "grey bowling shirt"
	icon_state = "undershirt_bowling_grey"

/obj/item/clothing/underwear/shirt/bowling/pink
	name = "pink bowling shirt"
	icon_state = "undershirt_bowling_pink"

/obj/item/clothing/underwear/shirt/bra
	name = "bra"
	desc = "A bra."
	body_parts_covered = CHEST
	icon_state = "bra"

/obj/item/clothing/underwear/shirt/bra/alt
	name = "bra (alt)"
	icon_state = "bra_alt"

/obj/item/clothing/underwear/shirt/bra/babydoll
	name = "babydoll"
	desc = "A babydoll."
	icon_state = "babydoll"

/obj/item/clothing/underwear/shirt/bra/beekini
	name = "bee-kini bra"
	desc = "Buzz buzz."
	icon_state = "bra_bee-kini"

/obj/item/clothing/underwear/shirt/bra/bikini
	name = "bikini"
	desc = "A bikini."
	body_parts_covered = CHEST | GROIN
	icon_state = "swimming"

/obj/item/clothing/underwear/shirt/bra/bikini/black
	name = "black bikini"
	icon_state = "swimming_black"

/obj/item/clothing/underwear/shirt/bra/bikini/blue
	name = "blue bikini"
	icon_state = "swimming_blue"

/obj/item/clothing/underwear/shirt/bra/bikini/red
	name = "red bikini"
	icon_state = "swimming_red"

/obj/item/clothing/underwear/shirt/top/bra_binder
	name = "Bra (binder)"
	icon_state = "bra_binder"
	body_parts_covered = CHEST

/obj/item/clothing/underwear/shirt/top/bra_binder/strapless
	name = "Bra (binder, strapless)"
	icon_state = "bra_binder_strapless"

/obj/item/clothing/underwear/shirt/bra/commie
	name = "commie bra"
	desc = "Seize the mammaries of production."
	icon_state = "bra_commie"

/obj/item/clothing/underwear/shirt/bra/fishnet
	name = "fishnet bra"
	icon_state = "bra_fishnet"

/obj/item/clothing/underwear/shirt/bra/fishnet/sleeves
	name = "sleeved fishnet bra"
	body_parts_covered = CHEST | ARMS
	icon_state = "bra_fishnet_sleeves"

/obj/item/clothing/underwear/shirt/bra/fishnet/sleeves/gloves
	name = "gloved fishnet bra"
	body_parts_covered = CHEST | ARMS | HANDS
	icon_state = "bra_fishnet_gloves"

/obj/item/clothing/underwear/shirt/bra/halterneck
	name = "halterneck bra"
	icon_state = "bra_halterneck"

/obj/item/clothing/underwear/shirt/bra/kinky
	name = "kinky bra"
	desc = "Kinky."
	icon_state = "bra_kinky"

/obj/item/clothing/underwear/shirt/bra/neko
	name = "neko bra"
	desc = "Favored by cat \"girls\"."
	icon_state = "bra_neko"

/obj/item/clothing/underwear/shirt/bra/sports
	name = "sports bra"
	icon_state = "bra_sports"

/obj/item/clothing/underwear/shirt/bra/sports/alt
	name = "sports bra (alt)"
	icon_state = "bra_sports_alt"

/obj/item/clothing/underwear/shirt/bra/strapless
	name = "strapless bra"
	icon_state = "bra_strapless"

/obj/item/clothing/underwear/shirt/bra/strapless/alt
	name = "strapless bra (alt)"
	icon_state = "bra_strapless_alt"

/obj/item/clothing/underwear/shirt/bra/striped
	name = "striped bra"
	icon_state = "bra_striped"

/obj/item/clothing/underwear/shirt/bra/swimming
	name = "swimming bra"
	icon_state = "bra_swimming"

/obj/item/clothing/underwear/shirt/bra/swimming/alt
	name = "swimming bra (alt)"
	icon_state = "bra_swimming_alt"

/obj/item/clothing/underwear/shirt/bra/thin
	name = "thin bra"
	icon_state = "bra_thin"

/obj/item/clothing/underwear/shirt/bra/tubetop
	name = "tubetop bra"
	icon_state = "bra_tubetop"

/obj/item/clothing/underwear/shirt/bra/uk
	name = "uk bra"
	desc = "You got a loicense for those tiddies?"
	icon_state = "bra_uk"

/obj/item/clothing/underwear/shirt/bra/usa
	name = "usa bra"
	desc = "Not nearly as free as letting them bounce."
	icon_state = "bra_assblastusa"

/obj/item/clothing/underwear/shirt/clown
	name = "clown shirt"
	desc = "HONK!"
	icon_state = "undershirt_clown"

/obj/item/clothing/underwear/shirt/commie
	name = "commie shirt"
	icon_state = "undershirt_commie"

/obj/item/clothing/underwear/shirt/cowboy
	name = "cowboy shirt"
	desc = "Yee haw."
	icon_state = "undershirt_cowboy"

/obj/item/clothing/underwear/shirt/cowboy/navy
	name = "navy cowboy shirt"
	icon_state = "undershirt_cowboy_navy"

/obj/item/clothing/underwear/shirt/cowboy/red
	name = "red cowboy shirt"
	icon_state = "undershirt_cowboy_red"

/obj/item/clothing/underwear/shirt/cowboy/short
	name = "short sleeved cowboy shirt"
	icon_state = "undershirt_cowboy_short"

/obj/item/clothing/underwear/shirt/cowboy/short/navy
	name = "short sleeved navy cowboy shirt"
	icon_state = "undershirt_cowboy_short_navy"

/obj/item/clothing/underwear/shirt/cowboy/short/red
	name = "short sleeved red cowboy shirt"
	icon_state = "undershirt_cowboy_short_red"

/obj/item/clothing/underwear/shirt/cowboy/short/white
	name = "short sleeved white cowboy shirt"
	icon_state = "undershirt_cowboy_short_white"

/obj/item/clothing/underwear/shirt/cowboy/white
	name = "white cowboy shirt"
	icon_state = "undershirt_cowboy_white"

/obj/item/clothing/underwear/shirt/ian
	name = "ian shirt"
	icon_state = "undershirt_ian"

/obj/item/clothing/underwear/shirt/ilovent
	name = "\"I love NT\" shirt"
	icon_state = "undershirt_ilovent"

/obj/item/clothing/underwear/shirt/long
	name = "longsleeved shirt"
	body_parts_covered = CHEST | ARMS
	icon_state = "undershirt_long"

/obj/item/clothing/underwear/shirt/long/striped
	name = "striped longsleeved shirt"
	icon_state = "undershirt_long_striped"

/obj/item/clothing/underwear/shirt/long/striped/blue
	name = "blue striped longsleeved shirt"
	icon_state = "undershirt_long_striped_blue"

/obj/item/clothing/underwear/shirt/lover
	name = "lover shirt"
	icon_state = "undershirt_lover"

/obj/item/clothing/underwear/shirt/matroska
	name = "matroska shirt"
	icon_state = "undershirt_matroska"

/obj/item/clothing/underwear/shirt/meat
	name = "meat shirt"
	icon_state = "undershirt_meat"

/obj/item/clothing/underwear/shirt/nano
	name = "NT shirt"
	icon_state = "undershirt_nano"

/obj/item/clothing/underwear/shirt/peace
	name = "peace shirt"
	icon_state = "undershirt_peace"

/obj/item/clothing/underwear/shirt/pogoman
	name = "pogoman shirt"
	icon_state = "undershirt_pogoman"

/obj/item/clothing/underwear/shirt/polo
	name = "polo shirt"
	icon_state = "undershirt_polo"

/obj/item/clothing/underwear/shirt/question
	name = "question shirt"
	icon_state = "undershirt_question"

/obj/item/clothing/underwear/shirt/redjersey
	name = "red jersey shirt"
	icon_state = "undershirt_redjersey"

/obj/item/clothing/underwear/shirt/shortsleeve
	name = "shortsleeve shirt"
	body_parts_covered = CHEST
	icon_state = "undershirt_short"

/obj/item/clothing/underwear/shirt/skull
	name = "skull shirt"
	icon_state = "undershirt_skull"

/obj/item/clothing/underwear/shirt/sportblue
	name = "blue sports shirt"
	icon_state = "undershirt_sport_blue"

/obj/item/clothing/underwear/shirt/sportgreen
	name = "green sports shirt"
	icon_state = "undershirt_sport_green"

/obj/item/clothing/underwear/shirt/sportred
	name = "red sports shirt"
	icon_state = "undershirt_sport_red"

/obj/item/clothing/underwear/shirt/ss13
	name = "SS13 shirt"
	icon_state = "undershirt_ss13"

/obj/item/clothing/underwear/shirt/striped
	name = "striped shirt"
	icon_state = "undershirt_striped"

/obj/item/clothing/underwear/shirt/tanktop
	name = "tanktop shirt"
	body_parts_covered = CHEST
	icon_state = "undershirt_tanktop"

/obj/item/clothing/underwear/shirt/tanktop/alt
	name = "tanktop shirt (alt)"
	icon_state = "undershirt_tanktop_alt"

/obj/item/clothing/underwear/shirt/tanktop/fire
	name = "fire tanktop shirt"
	icon_state = "undershirt_tanktop_fire"

/obj/item/clothing/underwear/shirt/tanktop/midriff
	name = "midriff tanktop shirt"
	icon_state = "undershirt_tanktop_midriff"

/obj/item/clothing/underwear/shirt/tanktop/midriff/alt
	name = "midriff tanktop shirt (alt)"
	icon_state = "undershirt_tanktop_midriff_alt"

/obj/item/clothing/underwear/shirt/tanktop/rainbow
	name = "rainbow tanktop shirt"
	icon_state = "undershirt_tanktop_rainbow"

/obj/item/clothing/underwear/shirt/tanktop/striped
	name = "striped tanktop shirt"
	icon_state = "undershirt_tanktop_striped"

/obj/item/clothing/underwear/shirt/tanktop/sun
	name = "sun tanktop shirt"
	icon_state = "undershirt_tanktop_sun"

/obj/item/clothing/underwear/shirt/tiedye
	name = "tiedye shirt"
	icon_state = "undershirt_tiedye"

/obj/item/clothing/underwear/shirt/top/shibari
	name = "Shibari Ropes"
	body_parts_covered = CHEST
	icon_state = "shibari"

/obj/item/clothing/underwear/shirt/top/shibari_sleeved
	name = "Shibari Ropes - sleeves"
	icon_state = "shibari_sleeves"

/obj/item/clothing/underwear/shirt/uk
	name = "uk shirt"
	desc = "I'm running out of UK jokes."
	icon_state = "undershirt_uk"

/obj/item/clothing/underwear/shirt/usa
	name = "usa shirt"
	desc = "Freedom and obesity."
	icon_state = "undershirt_assblastusa"
*/
