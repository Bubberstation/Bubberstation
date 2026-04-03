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
#define COMSIG_SMITHING_DONE "smithing_done"
#define COMSIG_SMITHING_PASSIVE_COOLED "smithing_passive_cooled"
