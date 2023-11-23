#define ADD_WADDLE(target, source) if(!HAS_TRAIT(target, TRAIT_WADDLING)) target.AddElement(/datum/element/waddling);ADD_TRAIT(target, TRAIT_WADDLING, source)
#define REMOVE_WADDLE(target, source) REMOVE_TRAIT(target, TRAIT_WADDLING, source); if(!HAS_TRAIT(target, TRAIT_WADDLING)) target.RemoveElement(/datum/element/waddling)

#define TRAIT_WADDLING "trait_waddling"
#define WADDLE_SOURCE_TESHARI "teshari"
