//The list of possible things anyone can make with materials used on the forge
#define FORGING_ASDF list( \"Chain" = /obj/machinery/door/airlock, \
/obj/structure/door_assembly, /obj/machinery/door/firedoor, /obj/machinery/door/window)
#define FORGING_ITEMS_ANYONE list(\
	"Chain" = /obj/item/forging/incomplete/chain \
	"Plate" = /obj/item/forging/incomplete/plate \
	"Dagger" = /obj/item/forging/incomplete/dagger \
	"Pickaxe" = /obj/item/forging/incomplete/pickaxe \
	"Shovel" = /obj/item/forging/incomplete/shovel \
	"Arrowhead" = /obj/item/forging/incomplete/arrowhead \
	"Rail Nail" = /obj/item/forging/incomplete/rail_nail \
	"Rail Cart" = /obj/item/forging/incomplete/rail_cart \
)

//the list of possible things people can make if they have the skillchip
#define FORGING_ITEMS_SKILLCHIP list(\
	"Sword" = /obj/item/forging/incomplete/sword \
	"Katana" = /obj/item/forging/incomplete/katana \
	"Rapier" = /obj/item/forging/incomplete/rapier \
	"Staff" = /obj/item/forging/incomplete/staff \
	"Spear" = /obj/item/forging/incomplete/spear \
	"Axe" = /obj/item/forging/incomplete/axe \
	"Hammer" = /obj/item/forging/incomplete/hammer \
)

//the list of possible things people can make if they have maxed forging skill
#define COMSIG_SMITHING_QUENCH "smithing_done"
#define COMSIG_SMITHING_PASSIVE_COOLED "smithing_passive_cooled"

#define DOAFTER_SMITHING_FORGE "smithing_forging_doafter"
#define DOAFTER_SMITHING_ANVIL "smithing_anvil_doafter"

#define DOAFTER_REVOLVER_HAMMER_COCK "smithing_revolver_hammer_cock_doafter"

#define FORGING_WEAPON_REFORGING_MAX_QUALITY 16
#define FORGING_WEAPON_REFORGING_AVERAGE_WAIT 2 SECONDS
#define FORGING_WEAPON_REFORGING_MAX_PERFECT_HITS 10
#define FORGING_WEAPON_REFORGING_MAX_BAD_HITS 6

/// Minimum and maximum force multiplier if a weapon contains incomplete parts
#define MIN_INCOMPLETE_DAMAGE_MULT 0.1
#define MAX_INCOMPLETE_DAMAGE_MULT 0.5
//ditto, with staff reagents
#define MIN_INCOMPLETE_STAFF_INJECT_MULT 0.2
#define MAX_INCOMPLETE_STAFF_INJECT_MULT 0.5
/// The maximum force that can be given to a weapon via perfect hits
#define MAX_PERFECT_FORCE_BONUS 3
/// maximum force that can be given to a reagent staff via perfect hits
#define MAX_PERFECT_STAFF_INTEG_BONUS 20

///amount of chems that can be stored into the result
#define MAX_PRE_IMBUE_STORAGE 60
///amount of chems that the result reads as
#define DEFAULT_IMBUE_STORAGE 10
#define REAGENT_CLOTHING_INJECT_AMOUNT 0.5
#define REAGENT_WEAPON_INJECT_AMOUNT 4
#define REAGENT_STAFF_INJECT_AMOUNT 10
#define MAX_OIL_AP_AMOUNT 10

#define MAX_QUENCH_HEAT 600
#define MIN_VOLUME_TO_QUENCH 300
