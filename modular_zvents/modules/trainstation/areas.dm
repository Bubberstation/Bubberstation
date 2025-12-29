/area/trainstation
	icon = 'modular_zvents/icons/area/trainareas.dmi'
	icon_state = "trainstation13"

/* НАРУЖНИЕ ЗОНЫ */

/area/trainstation/outdoor
	name = "Railways"
	outdoors = TRUE
	requires_power = FALSE
	always_unpowered = TRUE
	min_ambience_cooldown = 2 MINUTES
	max_ambience_cooldown = 6 MINUTES

	allow_shuttle_docking = TRUE
	daylight = TRUE


/area/trainstation/outdoor/rails
	name = "Railways"
	icon_state = "rails"



/* ВНУТРЕННИЕ ЗОНЫ */

/area/trainstation/indoors
	min_ambience_cooldown = 1 MINUTES
	max_ambience_cooldown = 3 MINUTES

	allow_shuttle_docking = FALSE
	daylight = FALSE

/*ЗОНЫ СВЯЗАННЫЕ С ПОЕЗДОМ */

/area/trainstation/indoors/train
	icon_state = "train"

/area/trainstation/indoors/train/bathroom
	icon_state = "bathroom"

/area/trainstation/indoors/train/kitchen
	icon_state = "kitchen"

/area/trainstation/indoors/train/reustoran
	icon_state = "tea"

/area/trainstation/indoors/train/cook
	icon_state = "chef"

/area/trainstation/indoors/train/vip
	icon_state = "vip"

/area/trainstation/indoors/train/security
	icon_state = "security"

/area/trainstation/indoors/train/medical
	icon_state = "medic"


// Индивидуальные зоны вагонов
/area/trainstation/indoors/train/vagon_1
	icon_state = "aux1"

/area/trainstation/indoors/train/vagon_2
	icon_state = "aux2"

/area/trainstation/indoors/train/vagon_3
	icon_state = "aux3"

/area/trainstation/indoors/train/vagon_4
	icon_state = "aux4"

/area/trainstation/indoors/train/vagon_5
	icon_state = "aux5"

/area/trainstation/indoors/train/vagon_6
	icon_state = "aux6"

/area/trainstation/indoors/train/vagon_7
	icon_state = "aux7"

/area/trainstation/indoors/train/vagon_8
	icon_state = "aux8"


/area/trainstation/indoors/train/conductor_1
	icon_state = "conductor1"

/area/trainstation/indoors/train/conductor_2
	icon_state = "conductor2"

/area/trainstation/indoors/train/conductor_3
	icon_state = "conductor3"

/area/trainstation/indoors/train/conductor_4
	icon_state = "conductor4"

/area/trainstation/indoors/train/conductor_5
	icon_state = "conductor5"

/area/trainstation/indoors/train/conductor_6
	icon_state = "conductor6"

/area/trainstation/indoors/train/conductor_7
	icon_state = "conductor7"

/area/trainstation/indoors/train/conductor_8
	icon_state = "conductor8"


/area/trainstation/indoors/train/tech_1
	icon_state = "main1"

/area/trainstation/indoors/train/tech_2
	icon_state = "main2"

/area/trainstation/indoors/train/tech_3
	icon_state = "main3"

/area/trainstation/indoors/train/tech_4
	icon_state = "main4"

/area/trainstation/indoors/train/tech_5
	icon_state = "main5"

/area/trainstation/indoors/train/tech_6
	icon_state = "main6"

/area/trainstation/indoors/train/tech_7
	icon_state = "main7"

/area/trainstation/indoors/train/tech_8
	icon_state = "main8"
