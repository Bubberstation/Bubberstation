// extra bubber borg sprites in a seperate folder so my github is happy

//haiii - aKhro

#define CYBORG_ICON_TYPE_SMOLRAPTOR "smolraptor"

#define CYBORG_ICON_GEN_SMOLRAPTOR 'modular_zubbers/modules/smolraptors/icons/smolraptor.dmi'
#define CYBORG_ICON_SCI_SMOLRAPTOR 'modular_zubbers/modules/smolraptors/icons/smolraptor_sci.dmi'
#define CYBORG_ICON_ENG_SMOLRAPTOR 'modular_zubbers/modules/smolraptors/icons/smolraptor_eng.dmi'
#define CYBORG_ICON_PK_SMOLRAPTOR 'modular_zubbers/modules/smolraptors/icons/smolraptor_eng.dmi'
#define CYBORG_ICON_JANI_SMOLRAPTOR 'modular_zubbers/modules/smolraptors/icons/smolraptor_eng.dmi'
#define CYBORG_ICON_MED_SMOLRAPTOR 'modular_zubbers/modules/smolraptors/icons/smolraptor_med.dmi'
#define CYBORG_ICON_MIN_SMOLRAPTOR 'modular_zubbers/modules/smolraptors/icons/smolraptor_eng.dmi'
#define CYBORG_ICON_SERV_SMOLRAPTOR 'modular_zubbers/modules/smolraptors/icons/smolraptor_eng.dmi'
#define CYBORG_ICON_SYND_SMOLRAPTOR 'modular_zubbers/modules/smolraptors/icons/smolraptor_eng.dmi'
#define CYBORG_ICON_NINJ_SMOLRAPTOR 'modular_zubbers/modules/smolraptors/icons/smolraptor_eng.dmi'

/obj/item/robot_model/standard/Initialize(mapload)
	. = ..()
	borg_skins |= list(
		"SmolRaptor" = list(SKIN_ICON_STATE = "smolraptor", SKIN_ICON = CYBORG_ICON_GEN_SMOLRAPTOR, SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_WIDE, TRAIT_R_SMALL)),
	)

/obj/item/robot_model/engineering/Initialize(mapload)
	. = ..()
	borg_skins |= list(
		"SmolRaptor" = list(SKIN_ICON_STATE = "smolraptor", SKIN_ICON = CYBORG_ICON_ENG_SMOLRAPTOR, SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_WIDE, TRAIT_R_SMALL)),
	)

/*
sciborg isnt in yet
/obj/item/robot_model/sci/Initialize(mapload)
	. = ..()
	borg_skins |= list(
		"SmolRaptor" = list(SKIN_ICON_STATE = "smolraptor", SKIN_ICON = CYBORG_ICON_SCI_SMOLRAPTOR, SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_WIDE, TRAIT_R_SMALL)),
	)

*/

/obj/item/robot_model/medical/Initialize(mapload)
	. = ..()
	borg_skins |= list(
		"SmolRaptor" = list(SKIN_ICON_STATE = "smolraptor", SKIN_ICON = CYBORG_ICON_MED_SMOLRAPTOR, SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_WIDE, TRAIT_R_SMALL)),
	)

/*
/obj/item/robot_model/min/Initialize(mapload)
	. = ..()
	borg_skins |= list(
		"SmolRaptor" = list(SKIN_ICON_STATE = "smolraptor", SKIN_ICON = CYBORG_ICON_MIN_SMOLRAPTOR, SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_WIDE, TRAIT_R_SMALL)),
	)

/obj/item/robot_model/serv/Initialize(mapload)
	. = ..()
	borg_skins |= list(
		"SmolRaptor" = list(SKIN_ICON_STATE = "smolraptor", SKIN_ICON = CYBORG_ICON_SERV_SMOLRAPTOR, SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_WIDE, TRAIT_R_SMALL)),
	)

/obj/item/robot_model/pk/Initialize(mapload)
	. = ..()
	borg_skins |= list(
		"SmolRaptor" = list(SKIN_ICON_STATE = "smolraptor", SKIN_ICON = CYBORG_ICON_PK_SMOLRAPTOR, SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_WIDE, TRAIT_R_SMALL)),
	)

/obj/item/robot_model/jani/Initialize(mapload)
	. = ..()
	borg_skins |= list(
		"SmolRaptor" = list(SKIN_ICON_STATE = "smolraptor", SKIN_ICON = CYBORG_ICON_JANI_SMOLRAPTOR, SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_WIDE, TRAIT_R_SMALL)),
	)

/obj/item/robot_model/synd/Initialize(mapload)
	. = ..()
	borg_skins |= list(
		"SmolRaptor" = list(SKIN_ICON_STATE = "smolraptor", SKIN_ICON = CYBORG_ICON_SYND_SMOLRAPTOR, SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_WIDE, TRAIT_R_SMALL)),
	)

*/
