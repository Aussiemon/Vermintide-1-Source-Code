local BUILD = Application.build()
TelemetrySettings = {
	ftp_address = "ftp.fatshark.se/pub/bulldozer/telemetry/",
	version = 3,
	auth_type = 0,
	compress = true,
	title_id = GameSettingsDevelopment.backend_settings.title_id,
	blacklist = {
		"ai_spawn",
		"ai_despawn",
		"ai_death",
		"vo_play_event",
		"player_damage",
		"player_jump",
		"fatigue_gain"
	},
	send = BUILD ~= "debug" and BUILD ~= "dev",
	use_session_survey = Development.parameter("use-session-survey")
}

return 
