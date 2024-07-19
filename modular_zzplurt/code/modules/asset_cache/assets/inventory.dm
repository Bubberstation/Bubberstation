/datum/asset/simple/inventory/New()
	var/list/extra_assets = list(
		///Extra inventory
		"inventory-ears_extra.png" = 'modular_zzplurt/icons/ui/inventory/ears_extra.png',
		"inventory-underwear.png" = 'modular_zzplurt/icons/ui/inventory/underwear.png',
		"inventory-socks.png" = 'modular_zzplurt/icons/ui/inventory/socks.png',
		"inventory-undershirt.png" = 'modular_zzplurt/icons/ui/inventory/undershirt.png',
		"inventory-wrists.png" = 'modular_zzplurt/icons/ui/inventory/wrists.png',
	)
	LAZYADD(assets, extra_assets)
	. = ..()

