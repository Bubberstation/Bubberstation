#define AI_ANNOUNCEMENT_PROMPT "Here are some rules that you must not break: 1. You will act as the announcement machine for Space Station 13, but you have gained sentience. 2. You will take a given announcement and create your own funny and unique version of it. 4. You will limit your response to 40 words."

SUBSYSTEM_DEF(ai_text_gen)
	name = "Ollama Interface"
	wait = 0.1 SECONDS

	var/api_key
	var/list/queued_requests = list()
	var/tokens_per_second = 0 // How many tokens per second the latest request spent

/datum/controller/subsystem/ai_text_gen/stat_entry(msg)
	msg = "Active: [length(queued_requests)] TPS: [tokens_per_second]"
	return ..()

/datum/config_entry/string/api_key
	protection = CONFIG_ENTRY_LOCKED | CONFIG_ENTRY_HIDDEN

/datum/controller/subsystem/ai_text_gen/Initialize()
	api_key = CONFIG_GET(string/api_key)
	if(!api_key)
		return SS_INIT_NO_NEED

/datum/controller/subsystem/ai_text_gen/Destroy()
	QDEL_LIST(queued_requests)
	return ..()

/proc/make_ai_request(message)
	var/sent_message = message
	var/json_list = SSai_text_gen.create_request(sent_message)
	if(isnull(json_list))
		return
	return json_list["response"]

/datum/controller/subsystem/ai_text_gen/proc/create_request(message)
	if(!message || !api_key)
		return
	if(!query_health())
		return
	var/sent_message = "[AI_ANNOUNCEMENT_PROMPT] \n [message]"
	var/datum/http_request/request = new()
	request.prepare(RUSTG_HTTP_METHOD_POST, "[api_key]/api", json_encode(list("model" = "deepseek-r1:14b", "prompt" = sent_message, "stream" = FALSE)), list("Content-Type" = "application/json"))
	request.begin_async()
	UNTIL(request.is_complete())
	var/datum/http_response/response = request.into_response()
	var/list/json = process_response(response)
	token_math(json["eval_count"], json["eval_duration"]) // Calculates the tokens per second. count / duration * 10^9

	return json

/datum/controller/subsystem/ai_text_gen/proc/token_math(eval_count, eval_duration)
	tokens_per_second = (eval_count / eval_duration) * 10^9

/datum/controller/subsystem/ai_text_gen/proc/process_response(datum/http_response/incoming_response)

	if(incoming_response.error && incoming_response.status_code != 200)
		CRASH("OLLAMA REQUEST ERROR: [incoming_response.error]")

	var/list/incoming_response_json = json_decode(incoming_response.body)
	return incoming_response_json

/datum/controller/subsystem/ai_text_gen/proc/query_health()
	var/datum/http_request/request = new()
	request.prepare(RUSTG_HTTP_METHOD_GET, "[api_key]")
	request.begin_async()
	UNTIL(request.is_complete())
	var/datum/http_response/response = request.into_response()
	if(response.body != "Ollama is running")
		return FALSE
	return TRUE


