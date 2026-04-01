@echo off
setlocal

set PY_SCRIPT=fix_template_noop_in_maps.py

REM Example: search the SpaceRuins folder relative to git root
python "%PY_SCRIPT%" "_maps\RandomRuins\SpaceRuins"
REM BUBBER EDIT: Below are our custom spaceruins. See: tools\maplint\source\lint.py for specific maps to skip
python "%PY_SCRIPT%" "_maps\RandomRuins\SpaceRuins\skyrat"
python "%PY_SCRIPT%" "_maps\RandomRuins\SpaceRuins\bubberstation"
endlocal
