/obj/item/organ/internal/cyberimp/bci
	///Camera installed into the BCI
	var/obj/machinery/camera/bci/shell_camera

/obj/item/organ/internal/cyberimp/bci/Destroy()
	if(shell_camera)
		QDEL_NULL(shell_camera)
	. = ..()
