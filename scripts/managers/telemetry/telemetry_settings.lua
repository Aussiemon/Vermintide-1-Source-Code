TelemetrySettings = {
	auth_type = 0,
	compress = true,
	ftp_address = "ftp.fatshark.se/pub/bulldozer/telemetry/",
	version = 3,
	title_id = ((BUILD == "debug" or BUILD == "dev") and Development.parameter("telemetry-title-id")) or GameSettingsDevelopment.backend_settings.title_id,
	blacklist = {
		"ai_spawn",
		"ai_despawn",
		"ai_death",
		"vo_play_event",
		"player_damage",
		"player_jump",
		"fatigue_gain"
	},
	collect_memory = (BUILD == "debug" or BUILD == "dev") and Development.parameter("telemetry-collect-memory"),
	send = (BUILD ~= "debug" and BUILD ~= "dev") or Development.parameter("telemetry-force-send"),
	use_session_survey = Development.parameter("use-session-survey")
}

return
