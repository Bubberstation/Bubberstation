// I'm not putting this into the main airlocks file. Who the fuck at TG thought that was a good idea?

/obj/machinery/door/airlock/command
	airlock_paint = "#334E6D"
	stripe_paint = "#43769D"

/obj/machinery/door/airlock/hop
	airlock_paint = "#334E6D"
	stripe_paint = "#43769D"

/obj/machinery/door/airlock/hos
	airlock_paint = "#334E6D"
	stripe_paint = "#43769D"

/obj/machinery/door/airlock/ce
	airlock_paint = "#334E6D"
	stripe_paint = "#43769D"

/obj/machinery/door/airlock/rd
	airlock_paint = "#334E6D"
	stripe_paint = "#43769D"

/obj/machinery/door/airlock/qm
	airlock_paint = "#334E6D"
	stripe_paint = "#43769D"

/obj/machinery/door/airlock/cmo
	airlock_paint = "#334E6D"
	stripe_paint = "#43769D"

/obj/machinery/door/airlock/security
	airlock_paint = "#9F2828"
	stripe_paint = "#D27428"

/obj/machinery/door/airlock/engineering
	airlock_paint = "#A28226"
	stripe_paint = "#7F292F"

/obj/machinery/door/airlock/medical
	airlock_paint = "#BBBBBB"
	stripe_paint = "#5995BA"

/obj/machinery/door/airlock/psych
	airlock_paint = "#BBBBBB"
	stripe_paint = "#5995BA"

/obj/machinery/door/airlock/asylum
	airlock_paint = "#BBBBBB"
	stripe_paint = "#464849"

/obj/machinery/door/airlock/bathroom
	airlock_paint = "#ebebeb"

/obj/machinery/door/airlock/hydroponics
	airlock_paint = "#559958"
	stripe_paint = "#0650A4"

/obj/machinery/door/airlock/maintenance
	stripe_paint = "#B69F3C"

/obj/machinery/door/airlock/maintenance/external
	stripe_paint = "#9F2828"

/obj/machinery/door/airlock/mining
	airlock_paint = "#967032"
	stripe_paint = "#5F350B"

/obj/machinery/door/airlock/atmos
	airlock_paint = "#A28226"
	stripe_paint = "#469085"

/obj/machinery/door/airlock/research
	airlock_paint = "#BBBBBB"
	stripe_paint = "#563758"

/obj/machinery/door/airlock/freezer
	airlock_paint = "#BBBBBB"

/obj/machinery/door/airlock/science
	airlock_paint = "#BBBBBB"
	stripe_paint = "#6633CC"

/obj/machinery/door/airlock/virology
	airlock_paint = "#BBBBBB"
	stripe_paint = "#2a7a25"

/obj/machinery/door/airlock/corporate
	airlock_paint = "#a1a1a1"
	stripe_paint = "#235d81"

/obj/machinery/door/airlock/service
	airlock_paint = "#559958"
	stripe_paint = "#3b3b3b"

// Mineral airlocks

/obj/machinery/door/airlock/gold
	airlock_paint = "#9F891F"

/obj/machinery/door/airlock/silver
	airlock_paint = "#C9C9C9"

/obj/machinery/door/airlock/diamond
	airlock_paint = "#4AB4B4"

/obj/machinery/door/airlock/uranium
	airlock_paint = "#174207"

/obj/machinery/door/airlock/plasma
	airlock_paint = "#65217B"

/obj/machinery/door/airlock/bananium
	airlock_paint = "#FFFF00"

/obj/machinery/door/airlock/sandstone
	airlock_paint = "#C09A72"

/obj/machinery/door/airlock/wood
	airlock_paint = "#805F44"

/obj/machinery/door/airlock/titanium
	airlock_paint = "#b3c0c7"

/obj/machinery/door/airlock/bronze
	airlock_paint = "#9c5f05"

// Station 2

/obj/machinery/door/airlock/public
	icon = 'modular_zubbers/icons/obj/doors/airlocks/station/airlock.dmi'
	overlays_file = 'modular_zubbers/icons/obj/doors/airlocks/station/airlock.dmi'

/*
	External Airlocks
*/

/obj/machinery/door/airlock/external
	icon = 'modular_zubbers/icons/obj/doors/airlocks/external/airlock.dmi'
	color_overlays = 'modular_zubbers/icons/obj/doors/airlocks/external/airlock_color.dmi'
	glass_fill_overlays = 'modular_zubbers/icons/obj/doors/airlocks/external/glass_overlays.dmi'
	overlays_file = 'modular_zubbers/icons/obj/doors/airlocks/external/overlays.dmi'
	airlock_paint = "#9F2828"

/*
	CentCom Airlocks
*/

/obj/machinery/door/airlock/centcom //Use grunge as a station side version, as these have special effects related to them via phobias and such.
	icon = 'modular_zubbers/icons/obj/doors/airlocks/centcom/airlock.dmi'

/obj/machinery/door/airlock/grunge
	icon = 'modular_zubbers/icons/obj/doors/airlocks/centcom/airlock.dmi'

/*
	Vault Airlocks
*/

/obj/machinery/door/airlock/vault
	icon = 'modular_zubbers/icons/obj/doors/airlocks/vault/airlock.dmi'
	overlays_file = 'modular_zubbers/icons/obj/doors/airlocks/vault/overlays.dmi'
	has_fill_overlays = FALSE

/*
	Hatch Airlocks
*/

/obj/machinery/door/airlock/hatch
	icon = 'modular_zubbers/icons/obj/doors/airlocks/hatch/airlock.dmi'
	stripe_overlays = 'modular_zubbers/icons/obj/doors/airlocks/hatch/airlock_stripe.dmi'

/obj/machinery/door/airlock/maintenance_hatch
	icon = 'modular_zubbers/icons/obj/doors/airlocks/hatch/airlock.dmi'
	stripe_overlays = 'modular_zubbers/icons/obj/doors/airlocks/hatch/airlock_stripe.dmi'
	overlays_file = 'modular_zubbers/icons/obj/doors/airlocks/hatch/overlays.dmi'
	stripe_paint = "#B69F3C"

/*
	High Security Airlocks
*/

/obj/machinery/door/airlock/highsecurity
	icon = 'modular_zubbers/icons/obj/doors/airlocks/highsec/airlock.dmi'
	color_overlays = null
	stripe_overlays = null
	has_fill_overlays = FALSE

/*
	Shuttle Airlocks
*/

/obj/machinery/door/airlock/shuttle
	airlock_paint = "#b3c0c7"

/obj/machinery/door/airlock/abductor
	airlock_paint = "#333333"
	stripe_paint = "#6633CC"

/*
	Cult Airlocks
*/

/obj/machinery/door/airlock/cult
	airlock_paint = "#333333"
	stripe_paint = "#610000"
