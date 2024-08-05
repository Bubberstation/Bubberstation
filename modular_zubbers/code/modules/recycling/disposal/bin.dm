/obj/machinery/disposal/delivery_chute/tagger
	var/currTag = 0 //Destinations are stored in code\globalvars\lists\flavor_misc.dm

/obj/machinery/disposal/delivery_chute/tagger/Initialize(...)
	mounted_tagger = new /obj/item/dest_tagger(null)
	mounted_tagget.currTag = src.currTag

/obj/machinery/disposal/delivery_chute/tagger/engineering
	currTag = 4

/obj/machinery/disposal/delivery_chute/tagger/security
	currTag = 7

/obj/machinery/disposal/delivery_chute/tagger/medbay
	currTag = 9

/obj/machinery/disposal/delivery_chute/tagger/research
	currTag = 12

/obj/machinery/disposal/delivery_chute/tagger/kitchen
	currTag = 20
