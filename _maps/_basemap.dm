#ifndef MINIMAL_CENTCOM
#include "map_files\generic\CentCom.dmm"
#else
#include "map_files\generic\CentCom_minimal.dmm"
#endif

#ifdef ALL_MAPS
	#include "map_files\debug\multiz.dmm"
	#include "map_files\debug\runtimestation.dmm"
	#include "map_files\Deltastation\DeltaStation2.dmm"
	#include "map_files\IceBoxStation\IceBoxStation.dmm"
	#include "map_files\MetaStation\MetaStation.dmm"
	#include "map_files\Mining\Lavaland.dmm"
	#include "map_files\tramstation\tramstation.dmm"
	#include "map_files\CatwalkStation\CatwalkStation_2023.dmm"
	#include "map_files\NebulaStation\NebulaStation.dmm"
	#include "map_files\KiloStation\KiloStation.dmm"
	// BUBBER EDIT ADDITON START - Compiling our modular maps too!
	#include "map_files\Blueshift\Blueshift.dmm"
	#include "map_files\VoidRaptor\VoidRaptor.dmm"
	//#include "map_files\wawastation\wawastation.dmm" BUBBER EDIT - UNUSED
	#include "map_files\biodome\biodome.dmm"
	#include "map_files\moonstation\moonstation.dmm"
	#include "map_files\BoxStation\BoxStation.dmm"
	#include "map_files\Ouroboros\Ouroboros.dmm"
	// BUBBER EDIT ADDITION END
#endif
#ifdef ALL_TEMPLATES
	#include "templates.dm"
#endif
