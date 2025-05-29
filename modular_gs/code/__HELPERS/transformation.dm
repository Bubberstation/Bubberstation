/client/proc/breadify(atom/movable/target)
	var/obj/item/reagent_containers/food/snacks/store/bread/plain/funnyBread = new(get_turf(target))
	target.forceMove(funnyBread)

GLOBAL_LIST_EMPTY(transformation_animation_objects)
/*
 * Creates animation that turns current icon into result appearance from top down.
 *
 * result_appearance - End result appearance/atom/image
 * time - Animation duration
 * transform_overlay - Appearance/atom/image of effect that moves along the animation - should be horizonatally centered
 * reset_after - If FALSE, filters won't be reset and helper vis_objects will not be removed after animation duration expires. Cleanup must be handled by the caller!
 */
/atom/movable/proc/transformation_animation(result_appearance,time = 3 SECONDS,transform_overlay,reset_after=TRUE)
	var/list/transformation_objects = GLOB.transformation_animation_objects[src] || list()
	//Disappearing part
	var/top_part_filter = filter(type="alpha",icon=icon('icons/effects/alphacolors.dmi',"white"),y=0)
	filters += top_part_filter
	var/filter_index = length(filters)
	animate(filters[filter_index],y=-32,time=time)
	//Appearing part
	var/obj/effect/overlay/appearing_part = new
	appearing_part.appearance = result_appearance
	appearing_part.appearance_flags |= KEEP_TOGETHER | KEEP_APART
	appearing_part.vis_flags = VIS_INHERIT_ID
	appearing_part.filters = filter(type="alpha",icon=icon('icons/effects/alphacolors.dmi',"white"),y=0,flags=MASK_INVERSE)
	animate(appearing_part.filters[1],y=-32,time=time)
	transformation_objects += appearing_part
	//Transform effect thing - todo make appearance passed in
	if(transform_overlay)
		var/obj/transform_effect = new
		transform_effect.appearance = transform_overlay
		transform_effect.vis_flags = VIS_INHERIT_ID
		transform_effect.pixel_y = 16
		transform_effect.alpha = 255
		transformation_objects += transform_effect
		animate(transform_effect,pixel_y=-16,time=time)
		animate(alpha=0)
	GLOB.transformation_animation_objects[src] = transformation_objects
	for(var/A in transformation_objects)
		vis_contents += A
	if(reset_after)
		addtimer(CALLBACK(src,.proc/_reset_transformation_animation,filter_index),time)
/*
 * Resets filters and removes transformation animations helper objects from vis contents.
*/
/atom/movable/proc/_reset_transformation_animation(filter_index)
	var/list/transformation_objects = GLOB.transformation_animation_objects[src]
	for(var/A in transformation_objects)
		vis_contents -= A
		qdel(A)
	transformation_objects.Cut()
	GLOB.transformation_animation_objects -= src
	if(filters && length(filters) >= filter_index)
		filters -= filters[filter_index]
	//else
	//	filters = null
