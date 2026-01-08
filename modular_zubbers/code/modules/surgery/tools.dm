/obj/item/scalpel/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/scalpel)

/datum/atom_skin/scalpel
	abstract_type = /datum/atom_skin/scalpel

/datum/atom_skin/scalpel/korve
	preview_name = "korve"
	new_icon_state = "scalpel"
	new_icon = 'modular_zubbers/icons/obj/medical/surgery_tools.dmi'

/datum/atom_skin/scalpel/default
	preview_name = "default"
	new_icon_state = "scalpel"
	new_icon = 'icons/obj/medical/surgery_tools.dmi'

/obj/item/circular_saw/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/saw)

/datum/atom_skin/saw
	abstract_type = /datum/atom_skin/saw

/datum/atom_skin/saw/korve
	preview_name = "korve"
	new_icon_state = "saw"
	new_icon = 'modular_zubbers/icons/obj/medical/surgery_tools.dmi'

/datum/atom_skin/scalpel/default
	preview_name = "default"
	new_icon_state = "saw"
	new_icon = 'icons/obj/medical/surgery_tools.dmi'

/obj/item/surgical_drapes/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/drapes)

/datum/atom_skin/drapes
	abstract_type = /datum/atom_skin/drapes

/datum/atom_skin/drapes/korve
	preview_name = "korve"
	new_icon_state = "drapes"
	new_icon = 'modular_zubbers/icons/obj/medical/surgery_tools.dmi'

/datum/atom_skin/drapes/default
	preview_name = "default"
	new_icon_state = "surgical_drapes"
	new_icon = 'icons/obj/medical/surgery_tools.dmi'

/obj/item/retractor/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/retractor)

/datum/atom_skin/retractor
	abstract_type = /datum/atom_skin/retractor

/datum/atom_skin/retractor/korve
	preview_name = "korve"
	new_icon_state = "retractor"
	new_icon = 'modular_zubbers/icons/obj/medical/surgery_tools.dmi'

/datum/atom_skin/retractor/default
	preview_name = "default"
	new_icon_state = "retractor"
	new_icon = 'icons/obj/medical/surgery_tools.dmi'

/obj/item/hemostat/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/hemostat)

/datum/atom_skin/hemostat
	abstract_type = /datum/atom_skin/hemostat

/datum/atom_skin/hemostat/korve
	preview_name = "korve"
	new_icon_state = "hemostat"
	new_icon = 'modular_zubbers/icons/obj/medical/surgery_tools.dmi'

/datum/atom_skin/hemostat/default
	preview_name = "default"
	new_icon_state = "hemostat"
	new_icon = 'icons/obj/medical/surgery_tools.dmi'

/obj/item/cautery/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/cautery)

/datum/atom_skin/cautery
	abstract_type = /datum/atom_skin/cautery

/datum/atom_skin/cautery/korve
	preview_name = "korve"
	new_icon_state = "cautery"
	new_icon = 'modular_zubbers/icons/obj/medical/surgery_tools.dmi'

/datum/atom_skin/cautery/default
	preview_name = "default"
	new_icon_state = "cautery"
	new_icon = 'icons/obj/medical/surgery_tools.dmi'

/obj/item/blood_filter/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/blood_filter)

/datum/atom_skin/blood_filter
	abstract_type = /datum/atom_skin/blood_filter

/datum/atom_skin/blood_filter/korve
	preview_name = "korve"
	new_icon_state = "bloodfilter"
	new_icon = 'modular_zubbers/icons/obj/medical/surgery_tools.dmi'

/datum/atom_skin/blood_filter/default
	preview_name = "default"
	new_icon_state = "bloodfilter"
	new_icon = 'icons/obj/medical/surgery_tools.dmi'

/obj/item/surgicaldrill/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/surgicaldrill)

/datum/atom_skin/surgicaldrill
	abstract_type = /datum/atom_skin/surgicaldrill

/datum/atom_skin/surgicaldrill/korve
	preview_name = "korve"
	new_icon_state = "drill"
	new_icon = 'modular_zubbers/icons/obj/medical/surgery_tools.dmi'

/datum/atom_skin/surgicaldrill/default
	preview_name = "default"
	new_icon_state = "drill"
	new_icon = 'icons/obj/medical/surgery_tools.dmi'

/obj/item/bonesetter/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/bonesetter)

/datum/atom_skin/bonesetter
	abstract_type = /datum/atom_skin/bonesetter

/datum/atom_skin/bonesetter/korve
	preview_name = "korve"
	new_icon_state = "bonesetter"
	new_icon = 'modular_zubbers/icons/obj/medical/surgery_tools.dmi'

/datum/atom_skin/bonesetter/default
	preview_name = "default"
	new_icon_state = "bonesetter"
	new_icon = 'icons/obj/medical/surgery_tools.dmi'

/obj/item/retractor/advanced/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/retractor_advanced)

/datum/atom_skin/retractor_advanced
	abstract_type = /datum/atom_skin/retractor_advanced

/datum/atom_skin/retractor_advanced/korve
	preview_name = "korve"
	new_icon_state = "adv_retractor"
	new_icon = 'modular_zubbers/icons/obj/medical/surgery_tools.dmi'

/datum/atom_skin/retractor_advanced/default
	preview_name = "default"
	new_icon_state = "adv_retractor"
	new_icon = 'icons/obj/medical/surgery_tools.dmi'

/obj/item/scalpel/advanced/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/scalpel_advanced)

/datum/atom_skin/scalpel_advanced
	abstract_type = /datum/atom_skin/scalpel_advanced

/datum/atom_skin/scalpel_advanced/korve
	preview_name = "korve"
	new_icon_state = "e_scalpel"
	new_icon = 'modular_zubbers/icons/obj/medical/surgery_tools.dmi'

/datum/atom_skin/scalpel_advanced/default
	preview_name = "default"
	new_icon_state = "e_scalpel"
	new_icon = 'icons/obj/medical/surgery_tools.dmi'

/obj/item/cautery/advanced/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/cautery_advanced)

/datum/atom_skin/cautery_advanced
	abstract_type = /datum/atom_skin/cautery_advanced

/datum/atom_skin/cautery_advanced/korve
	preview_name = "korve"
	new_icon_state = "e_cautery"
	new_icon = 'modular_zubbers/icons/obj/medical/surgery_tools.dmi'

/datum/atom_skin/cautery_advanced/default
	preview_name = "default"
	new_icon_state = "e_cautery"
	new_icon = 'icons/obj/medical/surgery_tools.dmi'

/obj/item/blood_filter/advanced/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/blood_filter_advanced)

/datum/atom_skin/blood_filter_advanced
	abstract_type = /datum/atom_skin/blood_filter_advanced

/datum/atom_skin/blood_filter_advanced/korve
	preview_name = "korve"
	new_icon_state = "combitool"
	new_icon = 'modular_zubbers/icons/obj/medical/surgery_tools.dmi'

/datum/atom_skin/blood_filter_advanced/default
	preview_name = "default"
	new_icon_state = "combitool"
	new_icon = 'modular_skyrat/modules/filtersandsetters/icons/surgery_tools.dmi'
