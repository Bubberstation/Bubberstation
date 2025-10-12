//Title Capitalization for names please!!!

/datum/loadout_item/uniform/wetsuit_norm
	name = "Fitted Wetsuit"
	item_path = /obj/item/clothing/under/wetsuit_norm
	ckeywhitelist = list("ChillyLobster")

/datum/loadout_item/uniform/security/hecu
	name = "Urban Camouflage BDU"
	item_path = /obj/item/clothing/under/rank/security/officer/hecu
	donator_only = TRUE
	restricted_roles = list(ALL_JOBS_SEC, JOB_BLUESHIELD)

/datum/loadout_item/uniform/command/stripper //Sprites by SierraGenevese
	name = "Command Bikini"
	item_path = /obj/item/clothing/under/rank/civilian/head_of_personnel/stripper
	restricted_roles = list(JOB_CAPTAIN, JOB_HEAD_OF_PERSONNEL, JOB_HEAD_OF_SECURITY, JOB_RESEARCH_DIRECTOR, JOB_CHIEF_ENGINEER, JOB_CHIEF_MEDICAL_OFFICER, JOB_QUARTERMASTER, JOB_NT_REP)

/datum/loadout_item/uniform/nanotrasen_consultant/stripper //Sprites by SierraGenevese
	name = "Consultant Bikini"
	item_path = /obj/item/clothing/under/rank/nanotrasen_consultant/stripper
	restricted_roles = list(JOB_NT_REP)

/datum/loadout_item/uniform/medrscrubs
	name = "Security Medic's Scrubs"
	item_path = /obj/item/clothing/under/rank/medical/scrubs/skyrat/red/sec
	restricted_roles = list(JOB_SECURITY_MEDIC)

/datum/loadout_item/uniform/security/officer/redsec
	name = "Security Red Uniform"
	item_path = /obj/item/clothing/under/rank/security/officer/redsec
	restricted_roles = list(ALL_JOBS_SEC)

/datum/loadout_item/uniform/security/peacekeeper/armadyne
	name = "Armadyne Corporate Uniform"
	item_path =/obj/item/clothing/under/rank/security/peacekeeper/armadyne
	restricted_roles = list(ALL_JOBS_SEC)

/datum/loadout_item/uniform/security/utility/redsec
	name = "Security Red Utility Uniform"
	item_path = /obj/item/clothing/under/rank/security/skyrat/utility/redsec
	restricted_roles = list(ALL_JOBS_SEC)

/datum/loadout_item/uniform/security/officer/formal
	name = "Security Officer's Formal Uniform"
	item_path = /obj/item/clothing/under/rank/security/officer/formal
	restricted_roles = list(ALL_JOBS_SEC)

/datum/loadout_item/uniform/security/peacekeeper/security_medic
	name = "Security Medic Turtleneck"
	item_path =/obj/item/clothing/under/rank/security/peacekeeper/security_medic
	restricted_roles = list(JOB_SECURITY_MEDIC)

/datum/loadout_item/uniform/security/peacekeeper/security_medic/skirt
	name = "Security Medic Skirtleneck"
	item_path =/obj/item/clothing/under/rank/security/peacekeeper/security_medic/skirt
	restricted_roles = list(JOB_SECURITY_MEDIC)

/datum/loadout_item/uniform/security/peacekeeper/security_medic/alternate
	name = "Security Medic Jumpsuit"
	item_path = /obj/item/clothing/under/rank/security/peacekeeper/security_medic/alternate
	restricted_roles = list(JOB_SECURITY_MEDIC)

/datum/loadout_item/uniform/security/corrections_officer
	name = "Correction's Officer Jumpsuit"
	item_path = /obj/item/clothing/under/rank/security/corrections_officer
	restricted_roles = list(JOB_CORRECTIONS_OFFICER, JOB_WARDEN)

/datum/loadout_item/uniform/security/corrections_officer
	name = "Correction's Officer Jumpskirt"
	item_path = /obj/item/clothing/under/rank/security/corrections_officer/skirt
	restricted_roles = list(JOB_CORRECTIONS_OFFICER, JOB_WARDEN)

/datum/loadout_item/uniform/security/corrections_officer
	name = "Correction's Officer Sweater"
	item_path = /obj/item/clothing/under/rank/security/corrections_officer/sweater
	restricted_roles = list(JOB_CORRECTIONS_OFFICER, JOB_WARDEN)

/datum/loadout_item/uniform/security/corrections_officer
	name = "Correction's Officer Sweater Skirt"
	item_path = /obj/item/clothing/under/rank/security/corrections_officer/sweater/skirt
	restricted_roles = list(JOB_CORRECTIONS_OFFICER, JOB_WARDEN)

/datum/loadout_item/uniform/miscellaneous/tactical_maid //Donor item for skyefree
	name = "Tactical Maid Costume"
	item_path = /obj/item/clothing/under/misc/maid/tactical
	donator_only = TRUE

/datum/loadout_item/uniform/miscellaneous/bubber/clown/skirt/red
	name = "Clown Skirt"
	item_path = /obj/item/clothing/under/rank/civilian/bubber/clown/skirt
	restricted_roles = list(JOB_CLOWN)

/datum/loadout_item/uniform/miscellaneous/bubber/clown/skirt/pink //Shouldn't do too much harm having these unlocked...Right?
	name = "Pink Clown Skirt"
	item_path = /obj/item/clothing/under/rank/civilian/bubber/clown/skirt/clussy

/datum/loadout_item/uniform/miscellaneous/bubber/clown/jester/amazing
	name = "Amazing Jester Uniform"
	item_path = /obj/item/clothing/under/rank/civilian/bubber/clown/jester
	restricted_roles = list(JOB_CLOWN)

/datum/loadout_item/uniform/miscellaneous/dress_strapped
	name = "Formal Evening Gown"
	item_path = /obj/item/clothing/under/dress/bubber/strapped

/datum/loadout_item/uniform/miscellaneous/syndicate_skyrat_overalls_unarmoured
	name = "Tacticool Utility Overalls"
	item_path = /obj/item/clothing/under/syndicate/skyrat/overalls/unarmoured

/datum/loadout_item/uniform/miscellaneous/syndicate_skyrat_overalls_unarmoured_skirt
	name = "Tacticool Utility Skirt and Suspenders"
	item_path = /obj/item/clothing/under/syndicate/skyrat/overalls/unarmoured/skirt

/datum/loadout_item/uniform/miscellaneous/loincloth
	name = "Leather Loincloth"
	item_path = /obj/item/clothing/under/costume/loincloth/sensor

/datum/loadout_item/uniform/miscellaneous/loincloth/cloth
	name = "Loincloth"
	item_path = /obj/item/clothing/under/costume/loincloth/cloth/sensor

/datum/loadout_item/uniform/miscellaneous/miniskirt
	name = "Recolourable Miniskirt"
	item_path = /obj/item/clothing/under/dress/miniskirt

/datum/loadout_item/uniform/miscellaneous/pirate_outfit
	name = "Pirate Outfit"
	item_path = /obj/item/clothing/under/costume/pirate

/datum/loadout_item/uniform/miscellaneous/bunny_suit
	name = "Bunny Suit"
	item_path = /obj/item/clothing/under/costume/bunnylewd

/datum/loadout_item/uniform/miscellaneous/centcom_officer_replica
	name = "CentCom turtleneck replica"
	item_path = /obj/item/clothing/under/rank/centcom/officer/replica

/datum/loadout_item/uniform/miscellaneous/centcom_officer_skirt_replica
	name = "CentCom skirtleneck replica"
	item_path = /obj/item/clothing/under/rank/centcom/officer_skirt/replica

/datum/loadout_item/uniform/miscellaneous/latex_catsuit
	name = "Latex Catsuit"
	item_path = /obj/item/clothing/under/misc/latex_catsuit

/datum/loadout_item/uniform/miscellaneous/latex_halfcatsuit
	name = "Latex Half-Catsuit"
	item_path = /obj/item/clothing/under/misc/latex_halfcatsuit

/datum/loadout_item/uniform/miscellaneous/custom_bunnysuit
	name = "Custom Bunnysuit"
	item_path = /obj/item/clothing/under/costume/playbunny/custom_playbunny

/datum/loadout_item/uniform/miscellaneous/nurse
	name = "Nurse's Suit"
	item_path = /obj/item/clothing/under/rank/medical/doctor/nurse

/datum/loadout_item/uniform/miscellaneous/microstar_suit
	name = "MicroStar SCI-MED suit"
	item_path = /obj/item/clothing/under/rank/civilian/microstar_suit

/datum/loadout_item/uniform/miscellaneous/frontier_colonist
	name = "Frontier Jumpsuit"
	item_path = /obj/item/clothing/under/frontier_colonist

/datum/loadout_item/uniform/miscellaneous/red_and_white_collared_outfit
	name = "Red and White Collared Suit"
	item_path = /obj/item/clothing/under/red_and_white_collared_outfit

/datum/loadout_item/uniform/black_turtleneck
	name = "Black turtleneck"
	item_path = /obj/item/clothing/under/syndicate/tacticool/black
	//ckeywhitelist = list("thedragmeme")

/datum/loadout_item/uniform/draculass
	name = "Draculass Dress"
	item_path = /obj/item/clothing/under/costume/draculass
	//ckeywhitelist = list("grunnyyy", "joe_duhan")

/datum/loadout_item/uniform/rax_banded_uniform
	name = "Banded Uniform"
	item_path = /obj/item/clothing/under/rank/security/rax
	//ckeywhitelist = list("raxraus")
	restricted_roles = list(JOB_BLUESHIELD, JOB_HEAD_OF_SECURITY, JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_DETECTIVE, JOB_CORRECTIONS_OFFICER, JOB_SECURITY_MEDIC,)

/datum/loadout_item/uniform/plasmaman_jax
	name = "XuraCorp Biohazard Underfitting"
	item_path = /obj/item/clothing/under/plasmaman/jax2
	//ckeywhitelist = list("candlejax")
	restricted_roles = list(JOB_RESEARCH_DIRECTOR, JOB_SCIENTIST, JOB_SCIENCE_GUARD, JOB_GENETICIST)

/datum/loadout_item/uniform/emissionsuit
	name = "Emission's Suit"
	item_path = /obj/item/clothing/under/plasmaman/candlejax
	//ckeywhitelist = list("candlejax")

/datum/loadout_item/uniform/anasuit
	name = "Azulean's Enviro-Suit"
	item_path = /obj/item/clothing/under/plasmaman/candlejax2
//	ckeywhitelist = list("candlejax")

/datum/loadout_item/uniform/britches_dress
	name = "Britches' dress"
	item_path = /obj/item/clothing/under/rank/civilian/clown/britches
	//ckeywhitelist = list("bloodrite")

/datum/loadout_item/uniform/caligram_fatigues_tan
	name = "Blacktide Tan Fatigues"
	item_path = /obj/item/clothing/under/jumpsuit/caligram_fatigues_tan
	can_be_reskinned = TRUE
//	ckeywhitelist = list("farsightednightlight", "raxraus", "1ceres", "marcoalbaredaa", "itzshift_yt", "drifter7371", "AvianAviator", "Katty Kat", "Investigator77", "Dalao Azure", "Socialistion", "ChillyLobster", "Sylvara", "AmZee", "Tf4", "rb303", "Kay_Nite", "whataboutism", "taac", "Halkyon", "Lupo_di_rosa", "Merek2", "lowpowermia", "RyeanBread", "Jesterz7", "Saund_Minah", "Ruediger4")

/datum/loadout_item/uniform/lannese
	name = "Lannese Dress"
	item_path = /obj/item/clothing/under/custom/lannese
	//ckeywhitelist = list("kathrinbailey")

/datum/loadout_item/uniform/lannese/vambrace
	name = "Lannese Dress w/ Vambraces"
	item_path = /obj/item/clothing/under/custom/lannese/vambrace
	//ckeywhitelist = list("kathrinbailey")

/datum/loadout_item/uniform/mechanic
	name = "Mechanic's Overalls"
	item_path = /obj/item/clothing/under/misc/skyrat/mechanic
	//ckeywhitelist = list("cypressb")

/datum/loadout_item/uniform/mikubikini
	name = "starlight singer bikini"
	item_path = /obj/item/clothing/under/mikubikini
	//ckeywhitelist = list("grandvegeta")

/datum/loadout_item/uniform/hubertcc
	name = "CC Ensign's uniform"
	item_path = /obj/item/clothing/under/rank/nanotrasen_consultant/hubert
	//ckeywhitelist = list("hackertdog")
	restricted_roles = list(JOB_NT_REP)

/datum/loadout_item/uniform/occult_outfit
	name = "Occult Collector's Outfit"
	item_path = /obj/item/clothing/under/occult
	//ckeywhitelist = list("gamerguy14948")

/datum/loadout_item/uniform/redhosneck
	name = "Black and Red Turtleneck"
	item_path = /obj/item/clothing/under/rank/security/head_of_security/alt/roselia
	//ckeywhitelist = list("ultimarifox")
	restricted_roles = list(JOB_HEAD_OF_SECURITY)

/datum/loadout_item/uniform/recruiter_uniform
	name = "Recruiter's Uniform"
	item_path = /obj/item/clothing/under/recruiter_uniform
	//ckeywhitelist = list("m97screwsyourparents")

/datum/loadout_item/uniform/nt_idol
	name = "NT Idol's Skirt"
	item_path = /obj/item/clothing/under/nt_idol_skirt
	//ckeywhitelist = list("tetrako")
	restricted_roles = list(JOB_NT_REP)

/datum/loadout_item/uniform/bubbly_clown
	name = "Bubbly Clown Dress"
	item_path = /obj/item/clothing/under/bubbly_clown/skirt
	restricted_roles = list(JOB_CLOWN)
	//ckeywhitelist = list("boisterousbeebz", "aether217")

/datum/loadout_item/uniform/tactichill
	name = "Tactichill Jacket"
	item_path = /obj/item/clothing/under/tactichill
	//ckeywhitelist = list("kaynite")

/datum/loadout_item/uniform/caged_dress
	name = "Caged Purple Dress"
	item_path = /obj/item/clothing/under/caged_dress/skirt
	//ckeywhitelist = list("thedragmeme")

/datum/loadout_item/uniform/goldenkimono
	name = "Short-Sleeved Kimono"
	item_path = /obj/item/clothing/under/costume/skyrat/kimono/sigmar
	//ckeywhitelist = list("sigmaralkahest")

/datum/loadout_item/uniform/miscellaneous/lt3_jeans
	name = "Silver Jeans"
	item_path = /obj/item/clothing/under/pants/skyy

/datum/loadout_item/uniform/noble_gambeson
	name = "Noble Gambeson"
	item_path = /obj/item/clothing/under/rank/civilian/chaplain/divine_archer/noble
//	ckeywhitelist = list("grasshand")

/datum/loadout_item/uniform/formal/dragon_maid
	name = "Dragon Maid Uniform"
	item_path = /obj/item/clothing/under/costume/dragon_maid
	//ckeywhitelist = list("sigmaralkahest")

/datum/loadout_item/uniform/old_qm_jumpskirt
	name = "Old Quartermaster's Jumpskirt"
	item_path = /obj/item/clothing/under/rank/cargo/qm/skirt/old
//	ckeywhitelist = list("jasohavents")
