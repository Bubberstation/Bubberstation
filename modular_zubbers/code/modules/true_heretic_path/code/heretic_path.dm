#define EXILE_ASCENSION_TRAIT "Exile Ascension"
#define EXILE_FISHING_TRAIT "Exile Fishing"
#define EXILE_MAGIC "Exile Magic"
#define EXILE_VISION_TRAIT "Exile Vision"




GLOBAL_LIST_INIT(heretic_loot_grasp_table_currency,list(
	/obj/item/heretic_currency/alchemical = 195, //65.0%
	/obj/item/heretic_currency/chaotic = 50, //16.6%
	/obj/item/heretic_currency/divination = 25, //8.3%
	/obj/item/heretic_currency/exalting = 25, //8.3%
	/obj/item/heretic_currency/mirroring = 5 // 1.6%
))


#define span_velvet(str) ("<span class='velvet'>" + str + "</span>")