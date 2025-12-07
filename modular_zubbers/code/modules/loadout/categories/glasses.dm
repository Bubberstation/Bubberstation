//Title Capitalization for names please!!!

/*
*	GLASSES
*/

/datum/loadout_item/glasses/prescription_glasses/thin
	name = "Thin Glasses"
	item_path = /obj/item/clothing/glasses/thin

/datum/loadout_item/glasses/prescription_glasses/better
	name = "Modern Glasses"
	item_path = /obj/item/clothing/glasses/regular/betterunshit

/datum/loadout_item/glasses/orange_glasses
	name = "Orange Glasses"
	item_path = /obj/item/clothing/glasses/orange

/datum/loadout_item/glasses/psych_glasses
	name = "Psych Glasses"
	item_path = /obj/item/clothing/glasses/psych

/datum/loadout_item/glasses/red_glasses
	name = "Red Glasses"
	item_path = /obj/item/clothing/glasses/red

/datum/loadout_item/glasses/roseglasses
	name = "Rose-Colored Glasses"
	item_path = /obj/item/clothing/glasses/rosecolored
	//ckeywhitelist = list("1ceres", "irrigoimport", "zeskorion", "wizardlywoz", "duckymomo", "samarai1000", "funkyfetusstrikesback", "m97screwsyourparents", "lynxqueen", "kaynite", "mahalia", "sapphoqueer", "emmakisst", "ceasethebridge", "valorthix" )

/*
*	GOGGLES
*/

/datum/loadout_item/glasses/goggles
	abstract_type = /datum/loadout_item/glasses/goggles
	group = "Goggles"

/datum/loadout_item/glasses/goggles/geist
	name = "Geist Gazers"
	item_path = /obj/item/clothing/glasses/geist_gazers

/datum/loadout_item/glasses/goggles/biker
	name = "Biker Goggles"
	item_path = /obj/item/clothing/glasses/biker

/datum/loadout_item/glasses/goggles/surgery
	name = "Recovery Goggles"
	item_path = /obj/item/clothing/glasses/surgerygoggles

/datum/loadout_item/glasses/goggles/surgery/med
	name = "Surgery Goggles"
	item_path = /obj/item/clothing/glasses/hud/health/surgerygoggles
	restricted_roles = list(ALL_JOBS_MEDICAL, JOB_GENETICIST)

/*
*	MISC
*/

/datum/loadout_item/glasses/eyepatch
	abstract_type = /datum/loadout_item/glasses/eyepatch
	group = "Eyepatches"

/datum/loadout_item/glasses/eyepatch/black
	name = "Eyepatch"
	item_path = /obj/item/clothing/glasses/eyepatch

/datum/loadout_item/glasses/eyepatch/white
	name = "White Eyepatch"
	item_path = /obj/item/clothing/glasses/eyepatch/white

/datum/loadout_item/glasses/eyepatch/wrap
	name = "Eyepatch Wrap"
	item_path = /obj/item/clothing/glasses/eyepatch/wrap

/datum/loadout_item/glasses/eyepatch/rose
	name = "Rose-Colored Eyepatch"
	item_path = /obj/item/clothing/glasses/eyepatch/rosecolored
	//ckeywhitelist = list("kaynite")

/datum/loadout_item/glasses/eyepatch/medical
	name = "Medical Eyepatch (Skyrat)"
	item_path = /obj/item/clothing/glasses/hud/eyepatch/med
	restricted_roles = list(JOB_MEDICAL_DOCTOR, JOB_CHIEF_MEDICAL_OFFICER, JOB_GENETICIST, JOB_CHEMIST, JOB_PARAMEDIC, JOB_ORDERLY, JOB_CORONER)

/datum/loadout_item/glasses/eyepatch/robotics
	name = "Diagnostic Eyepatch"
	item_path = /obj/item/clothing/glasses/hud/eyepatch/diagnostic
	restricted_roles = list(JOB_SCIENTIST, JOB_ROBOTICIST, JOB_GENETICIST, JOB_RESEARCH_DIRECTOR, JOB_SCIENCE_GUARD)

/datum/loadout_item/glasses/eyepatch/science
	name = "Science Eyepatch"
	item_path = /obj/item/clothing/glasses/hud/eyepatch/sci
	restricted_roles = list(JOB_SCIENTIST, JOB_ROBOTICIST, JOB_GENETICIST, JOB_RESEARCH_DIRECTOR, JOB_CHEMIST, JOB_SCIENCE_GUARD)

/datum/loadout_item/glasses/eyepatch/meson
	name = "Meson Eyepatch"
	item_path = /obj/item/clothing/glasses/hud/eyepatch/meson
	restricted_roles = list(JOB_QUARTERMASTER, JOB_CARGO_TECHNICIAN, JOB_SHAFT_MINER, JOB_CUSTOMS_AGENT, JOB_CHIEF_ENGINEER, JOB_STATION_ENGINEER, JOB_ATMOSPHERIC_TECHNICIAN, JOB_ENGINEERING_GUARD)

/datum/loadout_item/glasses/eyepatch/security
	name = "Security Eyepatch HUD"
	item_path = /obj/item/clothing/glasses/hud/eyepatch/sec
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER, JOB_BOUNCER, JOB_ORDERLY, JOB_SCIENCE_GUARD, JOB_CUSTOMS_AGENT, JOB_ENGINEERING_GUARD, JOB_BLUESHIELD)

//COSTUMES

/datum/loadout_item/glasses/costume
	abstract_type = /datum/loadout_item/glasses/costume
	group = "Costumes and Silly Glasses"

/datum/loadout_item/glasses/costume/fakeblindfold
	name = "Fake Blindfold"
	item_path = /obj/item/clothing/glasses/trickblindfold

/datum/loadout_item/glasses/costume/obsoleteblindfold
	name = "Obselete Fake Blindfold"
	item_path = /obj/item/clothing/glasses/trickblindfold/obsolete

/*
*	JOB-LOCKED
*/

/datum/loadout_item/glasses/hud
	abstract_type = /datum/loadout_item/glasses/hud
	group = "HUDs"

/datum/loadout_item/glasses/hud/civ
	name = "Civilian HUD"
	item_path = /obj/item/clothing/glasses/hud/civilian

/datum/loadout_item/glasses/hud/retinal_projector
	name = "Retinal Projector"
	item_path = /obj/item/clothing/glasses/hud/ar/projector

/datum/loadout_item/glasses/hud/sec
	name = "Security HUD"
	item_path = /obj/item/clothing/glasses/hud/security
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER, JOB_BOUNCER, JOB_ORDERLY, JOB_SCIENCE_GUARD, JOB_CUSTOMS_AGENT, JOB_ENGINEERING_GUARD, JOB_BLUESHIELD)

/datum/loadout_item/glasses/hud/sec/glasses
	name = "Prescription Security HUD"
	item_path = /obj/item/clothing/glasses/hud/security/prescription
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER, JOB_BOUNCER, JOB_ORDERLY, JOB_SCIENCE_GUARD, JOB_CUSTOMS_AGENT, JOB_ENGINEERING_GUARD, JOB_BLUESHIELD)

/datum/loadout_item/glasses/hud/med/glasses
	name = "Prescription Medical HUD"
	item_path = /obj/item/clothing/glasses/hud/health/prescription
	restricted_roles = list(JOB_MEDICAL_DOCTOR, JOB_CHIEF_MEDICAL_OFFICER, JOB_GENETICIST, JOB_CHEMIST, JOB_PARAMEDIC, JOB_ORDERLY, JOB_CORONER)

/datum/loadout_item/glasses/hud/diag/glasses
	name = "Prescription Diagnostic HUD"
	item_path = /obj/item/clothing/glasses/hud/diagnostic/prescription
	restricted_roles = list(JOB_RESEARCH_DIRECTOR,JOB_SCIENTIST, JOB_ROBOTICIST)

/datum/loadout_item/glasses/hud/science/glasses
	name = "Prescription Science Glasses"
	item_path = /obj/item/clothing/glasses/science/prescription
	restricted_roles = list(JOB_SCIENTIST, JOB_ROBOTICIST, JOB_GENETICIST, JOB_RESEARCH_DIRECTOR, JOB_CHEMIST, JOB_SCIENCE_GUARD)

/datum/loadout_item/glasses/hud/retinalprojector/security
	name = "Retinal Projector Security HUD"
	item_path = /obj/item/clothing/glasses/hud/ar/projector/security
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER, JOB_BOUNCER, JOB_ORDERLY, JOB_SCIENCE_GUARD, JOB_CUSTOMS_AGENT, JOB_ENGINEERING_GUARD, JOB_BLUESHIELD)

/datum/loadout_item/glasses/hud/retinalprojector/health
	name = "Retinal Projector Health HUD"
	item_path = /obj/item/clothing/glasses/hud/ar/projector/health
	restricted_roles = list(JOB_MEDICAL_DOCTOR, JOB_CHIEF_MEDICAL_OFFICER, JOB_GENETICIST, JOB_CHEMIST, JOB_PARAMEDIC, JOB_ORDERLY, JOB_CORONER)

/datum/loadout_item/glasses/hud/retinalprojector/meson
	name = "Retinal Projector Meson HUD"
	item_path = /obj/item/clothing/glasses/hud/ar/projector/meson
	restricted_roles = list(JOB_QUARTERMASTER, JOB_CARGO_TECHNICIAN, JOB_SHAFT_MINER, JOB_CUSTOMS_AGENT, JOB_CHIEF_ENGINEER, JOB_STATION_ENGINEER, JOB_ATMOSPHERIC_TECHNICIAN, JOB_ENGINEERING_GUARD)

/datum/loadout_item/glasses/hud/retinalprojector/diagnostic
	name = "Retinal Projector Diagnostic HUD"
	item_path = /obj/item/clothing/glasses/hud/ar/projector/diagnostic
	restricted_roles = list(JOB_RESEARCH_DIRECTOR, JOB_SCIENTIST, JOB_ROBOTICIST)

/datum/loadout_item/glasses/hud/retinalprojector/science
	name = "Science Retinal Projector"
	item_path = /obj/item/clothing/glasses/hud/ar/projector/science
	restricted_roles = list(JOB_SCIENTIST, JOB_ROBOTICIST, JOB_GENETICIST, JOB_RESEARCH_DIRECTOR, JOB_CHEMIST, JOB_SCIENCE_GUARD)

/datum/loadout_item/glasses/hud/redgigagar
	name = "Red-tinted Giga HUD Gar Glasses"
	item_path = /obj/item/clothing/glasses/hud/security/sunglasses/gars/giga/roselia
	//ckeywhitelist = list("ultimarifox")
	restricted_roles = list(JOB_HEAD_OF_SECURITY, JOB_SECURITY_OFFICER)

/*
*	SHADES
*/

/datum/loadout_item/glasses/shades
	abstract_type = /datum/loadout_item/glasses/shades
	group = "Sunglasses and Aviators"

/datum/loadout_item/glasses/shades/aviator/gold
	name = "Purple and Gold Aviators"
	item_path = /obj/item/clothing/glasses/gold_aviators
	//ckeywhitelist = list("nikohyena")

/datum/loadout_item/glasses/shades/osi
	name = "OSI Glasses"
	item_path = /obj/item/clothing/glasses/osi

/datum/loadout_item/glasses/shades/phantom
	name = "Phantom Glasses"
	item_path = /obj/item/clothing/glasses/phantom

/datum/loadout_item/glasses/shades/fake_sunglasses
	name = "Fake Sunglasses"
	item_path = /obj/item/clothing/glasses/fake_sunglasses

/datum/loadout_item/glasses/shades/salesman
	name = "Colored Glasses"
	item_path = /obj/item/clothing/glasses/salesman

/datum/loadout_item/glasses/shades/aviator/security
	name = "Security HUD Aviators"
	item_path = /obj/item/clothing/glasses/hud/ar/aviator/security
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER, JOB_BOUNCER, JOB_ORDERLY, JOB_SCIENCE_GUARD, JOB_CUSTOMS_AGENT, JOB_ENGINEERING_GUARD, JOB_BLUESHIELD)

/datum/loadout_item/glasses/shades/aviator/health
	name = "Medical HUD Aviators"
	item_path = /obj/item/clothing/glasses/hud/ar/aviator/health
	restricted_roles = list(JOB_MEDICAL_DOCTOR, JOB_CHIEF_MEDICAL_OFFICER, JOB_GENETICIST, JOB_CHEMIST, JOB_PARAMEDIC, JOB_ORDERLY, JOB_CORONER)

/datum/loadout_item/glasses/shades/aviator/meson
	name = "Meson HUD Aviators"
	item_path = /obj/item/clothing/glasses/hud/ar/aviator/meson
	restricted_roles = list(JOB_QUARTERMASTER, JOB_CARGO_TECHNICIAN, JOB_SHAFT_MINER, JOB_CUSTOMS_AGENT, JOB_CHIEF_ENGINEER, JOB_STATION_ENGINEER, JOB_ATMOSPHERIC_TECHNICIAN, JOB_ENGINEERING_GUARD)

/datum/loadout_item/glasses/shades/aviator/diagnostic
	name = "Diagnostic HUD Aviators"
	item_path = /obj/item/clothing/glasses/hud/ar/aviator/diagnostic
	restricted_roles = list(JOB_RESEARCH_DIRECTOR, JOB_SCIENTIST, JOB_ROBOTICIST)

/datum/loadout_item/glasses/shades/aviator/science
	name = "Science Aviators"
	item_path = /obj/item/clothing/glasses/hud/ar/aviator/science
	restricted_roles = list(JOB_SCIENTIST, JOB_ROBOTICIST, JOB_GENETICIST, JOB_RESEARCH_DIRECTOR, JOB_CHEMIST, JOB_SCIENCE_GUARD)

/datum/loadout_item/glasses/shades/prescription/aviator/security
	name = "Prescription Security HUD Aviators"
	item_path = /obj/item/clothing/glasses/hud/ar/aviator/security/prescription
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER, JOB_BOUNCER, JOB_ORDERLY, JOB_SCIENCE_GUARD, JOB_CUSTOMS_AGENT, JOB_ENGINEERING_GUARD, JOB_BLUESHIELD)

/datum/loadout_item/glasses/shades/prescription/aviator/health
	name = "Prescription Medical HUD Aviators"
	item_path = /obj/item/clothing/glasses/hud/ar/aviator/health/prescription
	restricted_roles = list(JOB_MEDICAL_DOCTOR, JOB_CHIEF_MEDICAL_OFFICER, JOB_GENETICIST, JOB_CHEMIST, JOB_PARAMEDIC, JOB_ORDERLY, JOB_CORONER)

/datum/loadout_item/glasses/shades/prescription/aviator/meson
	name = "Prescription Meson HUD Aviators"
	item_path = /obj/item/clothing/glasses/hud/ar/aviator/meson/prescription
	restricted_roles = list(JOB_QUARTERMASTER, JOB_CARGO_TECHNICIAN, JOB_SHAFT_MINER, JOB_CUSTOMS_AGENT, JOB_CHIEF_ENGINEER, JOB_STATION_ENGINEER, JOB_ATMOSPHERIC_TECHNICIAN, JOB_ENGINEERING_GUARD)

/datum/loadout_item/glasses/shades/prescription/aviator/diagnostic
	name = "Prescription Diagnostic HUD Aviators"
	item_path = /obj/item/clothing/glasses/hud/ar/aviator/diagnostic/prescription
	restricted_roles = list(JOB_RESEARCH_DIRECTOR, JOB_SCIENTIST, JOB_ROBOTICIST)

/datum/loadout_item/glasses/shades/prescription/aviator/science
	name = "Prescription Science Aviators"
	item_path = /obj/item/clothing/glasses/hud/ar/aviator/science/prescription
	restricted_roles = list(JOB_SCIENTIST, JOB_ROBOTICIST, JOB_GENETICIST, JOB_RESEARCH_DIRECTOR, JOB_CHEMIST, JOB_SCIENCE_GUARD)

/datum/loadout_item/glasses/shades/aviator_fake
	name = "Fake Aviators"
	item_path = /obj/item/clothing/glasses/fake_sunglasses/aviator
