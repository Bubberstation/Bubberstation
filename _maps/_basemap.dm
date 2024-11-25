//#define LOWMEMORYMODE //uncomment this to load centcom and runtime station and thats it.

#include "map_files\generic\CentCom.dmm"

#ifndef LOWMEMORYMODE
	#ifdef ALL_MAPS
		//#include "map_files\Birdshot\birdshot.dmm" BUBBER EDIT - UNUSED
		#include "map_files\debug\multiz.dmm"
		#include "map_files\debug\runtimestation.dmm"
		#include "map_files\Deltastation\DeltaStation2.dmm"
		#include "map_files\IceBoxStation\IceBoxStation.dmm"
		#include "map_files\MetaStation\MetaStation.dmm"
		#include "map_files\Mining\Lavaland.dmm"
		//#include "map_files\NorthStar\north_star.dmm" BUBBER EDIT - UNUSED
		#include "map_files\tramstation\tramstation.dmm"
		// SKYRAT EDIT ADDITON START - Compiling our modular maps too!
		#include "map_files\VoidRaptor\VoidRaptor.dmm"
		#include "map_files\KiloStation\KiloStation.dmm"
		// SKYRAT EDIT END
		//#include "map_files\wawastation\wawastation.dmm" BUBBER EDIT - UNUSED
		// BUBBER EDIT ADDITION START
		#include "map_files\biodome\biodome.dmm"
		#include "map_files\moonstation\moonstation.dmm"
		#include "map_files\BoxStation\BoxStation.dmm"
		// BUBBER EDIT ADDITION END

		#ifdef CIBUILDING
			#include "templates.dm"
		#endif
	#endif
#endif
