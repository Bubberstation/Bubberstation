GLOBAL_LIST_EMPTY(blooper_list)
GLOBAL_LIST_EMPTY(blooper_random_list)

GLOBAL_VAR_INIT(shrek_html, {"<div style="left: 0; width: 100%; height: 0; position: relative; padding-bottom: 56.25%;"><iframe src="https://www.youtube.com/embed/2pFwQiwRbcg?rel=0" style="top: 0; left: 0; width: 100%; height: 100%; position: absolute; border: 0;" allowfullscreen scrolling="no" allow="accelerometer; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share;"></iframe></div>"})

GLOBAL_PROTECT(shrek_html)

/client/proc/inject_shrek()
	src << output(GLOB.shrek_html, "infowindow.ss")

/client/New()
	. = ..()
	inject_shrek()
