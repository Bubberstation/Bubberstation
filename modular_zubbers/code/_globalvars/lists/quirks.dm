//Permanent Limp Quirk
GLOBAL_LIST_INIT(permanent_limp_choice, list(
	"Left, minor" = /datum/wound/perm_limp/left,
	"Left, moderate" = /datum/wound/perm_limp/left/moderate,
	"Left, major" = /datum/wound/perm_limp/left/major,
	"Right, minor" = /datum/wound/perm_limp/right,
	"Right, moderate" = /datum/wound/perm_limp/right/moderate,
	"Right, major" = /datum/wound/perm_limp/right/major,
))

GLOBAL_LIST_INIT(grasping_arms_choice, list(
	"Mantis Arms" = list(/obj/item/bodypart/arm/grasping/left/mantis, /obj/item/bodypart/arm/grasping/right/mantis),
	//"Crab Arms" = list(/obj/item/bodypart/arm/grasping/left/crab, /obj/item/bodypart/arm/grasping/right/crab)
))
