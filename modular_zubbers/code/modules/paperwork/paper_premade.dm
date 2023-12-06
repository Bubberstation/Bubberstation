/obj/item/paper/fluff/merge_my_fucking_pr
	default_raw_text = "UH OH"

/obj/item/paper/fluff/merge_my_fucking_pr/Initialize(mapload)


	//I love madlibs.
	var/author = "[pick(GLOB.first_names)] [pick(GLOB.last_names)]"
	var/thing_to_remove = lowertext(pick_list(ION_FILE, "ionobjects"))
	var/conversation = pick_list(HALLUCINATION_FILE, "conversation")
	var/redpill = pick_list(REDPILL_FILE, "redpill_questions")
	var/job = replacetextEx(pick_list(HALLUCINATION_FILE, "people") ,"\%TARGETNAME","in dorms")
	var/traitor = replacetextEx(pick_list(HALLUCINATION_FILE, "accusations") ,"\%TARGETNAME","in dorms")
	var/location = replacetextEx(pick_list(HALLUCINATION_FILE, "location") ,"\%TARGETNAME","dorms")


	default_raw_text = {"
	<h1>About The Pull Request</h1>
	<hr>
	<p>Removes [thing_to_remove].</p>
	<br>
	<h1>Why It's Good For The Game</h1>
	<hr>
	<p>[redpill]</p>
	<br>
	<p>
	We need to remove [thing_to_remove] from the Station. You might be thinking "[conversation]", so let me explain.<br>
	One time that damn griefer george melons was [job] as [traitor] and he killed me in [location] with [thing_to_remove]. This should not have happened so I petitioning for it to be removed.
	</p>
	<br>
	<h1>Changelog</h1>
	<hr>
	CL [author]<br>
	remove: Removes [thing_to_remove]<br>
	/CL
	"}

	name = "[initial(name)] - pull request #[text2num("\ref[src]",16)]"

	return ..()