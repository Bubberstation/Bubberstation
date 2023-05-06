
//Splash-based recipe to turn improvised gauze into sterile gauze.
/datum/reagent/space_cleaner/sterilizine/expose_obj(obj/O, reac_volume)
	. = ..()
	if(istype(O, /obj/item/stack/medical/gauze/improvised))
		var/obj/item/stack/medical/gauze/G = O
		reac_volume = min((reac_volume/10), G.amount)
		new /obj/item/stack/medical/gauze(get_turf(G), reac_volume)
		G.use(reac_volume)
