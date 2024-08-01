/obj/item/flashlight/flare/candle/cake

/obj/item/food/cake/birthday
	var/obj/item/flashlight/flare/candle/cake/candle

/obj/item/food/cake/birthday/Initialize(mapload)
	. = ..()
	candle = new(src)

/obj/item/food/cake/birthday/extinguish()
	. = ..()
	candle.extinguish()

/obj/item/food/cake/birthday/fire_act(exposed_temperature, exposed_volume)
	candle.fire_act(exposed_temperature, exposed_volume)
	return ..()

/obj/item/food/cake/birthday/attackby(obj/item/attacking_item, mob/user, params)
	candle.attackby(attacking_item, user, params)
	return ..()

// allows lighting an unlit candle from some fire source by left clicking the source with the candle
/obj/item/food/cake/birthday/pre_attack(atom/target, mob/living/user, params)
	candle.pre_attack(target, user, params)
	return ..()
