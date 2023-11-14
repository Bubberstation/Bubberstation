/obj/item/clothing/mask/gas/sechailer/swat/spacepolice
	name = "space police mask"
	desc = "A close-fitting tactical mask created in cooperation with a certain megacorporation, comes with an especially aggressive Compli-o-nator 3000."
	icon = 'modular_zubbers/icons/obj/clothing/masks.dmi'
	icon_state = "spacepol"
	worn_icon = 'modular_zubbers/icons/mob/clothing/masks.dmi'
	inhand_icon_state = "spacepol_mask"
	flags_cover = MASKCOVERSMOUTH | MASKCOVERSEYES | PEPPERPROOF
	visor_flags_cover = MASKCOVERSMOUTH | MASKCOVERSEYES | PEPPERPROOF
	unique_death = 'sound/voice/police_death.ogg'
	voice_filter = @{"[0:a] asetrate=%SAMPLE_RATE%*0.7,aresample=16000,atempo=1/0.7,lowshelf=g=-20:f=500,highpass=f=500,aphaser=in_gain=1:out_gain=1:delay=3.0:decay=0.4:speed=0.5:type=t [out]; [out]atempo=1.2,volume=15dB [final]; anoisesrc=a=0.01:d=60 [noise]; [final][noise] amix=duration=shortest"}
