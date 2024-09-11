#define EXILE_ASCENSION_TRAIT "Exile Ascension"
#define EXILE_FISHING_TRAIT "Exile Fishing"
#define EXILE_MAGIC "Exile Magic"
#define EXILE_VISION_TRAIT "Exile Vision"
#define EXILE_UNIQUE "Exile Unique Item"

GLOBAL_LIST_INIT(heretic_loot_grasp_table_currency,list(
	/obj/item/heretic_currency/alchemical = 190, //63.3%
	/obj/item/heretic_currency/chaotic = 50, //16.6%
	/obj/item/heretic_currency/divination = 25, //8.3%
	/obj/item/heretic_currency/exalting = 25, //8.3%
	/obj/item/heretic_currency/mirroring = 10 // 3.3%
))


#define span_velvet(str) ("<span class='velvet'>" + str + "</span>")