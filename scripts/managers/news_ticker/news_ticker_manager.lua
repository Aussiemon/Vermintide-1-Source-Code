require("scripts/managers/news_ticker/news_ticker_token")

NewsTickerManager = class(NewsTickerManager)
NewsTickerManager.init = function (self)
	self._loading_screen_url = Development.parameter("news_ticker_url") or "http://patch.fatshark.se/vermintide_news_ticker.txt"
	self._ingame_url = Development.parameter("news_ticker_ingame_url") or "http://patch.fatshark.se/vermintide_news_ticker_ingame.txt"
	self._loading_screen_text = nil
	self._ingame_text = nil

	return 
end

local function lines(str)
	local t = {}

	local function helper(line)
		table.insert(t, line)

		return ""
	end

	helper(str.gsub(str, "(.-)\r?\n", helper))

	return t
end

NewsTickerManager.update = function (self, dt)
	return 
end
NewsTickerManager.destroy = function (self)
	return 
end
NewsTickerManager._load = function (self, url, callback)
	local token = Curl.add_request(url)
	local curl_token = CurlToken:new(token)

	Managers.token:register_token(curl_token, callback)

	return 
end
NewsTickerManager.refresh_loading_screen_message = function (self)
	self._loading_screen_text = nil
	self._refreshing_loading_screen_message = true

	if not rawget(_G, "Curl") then
		self.cb_loading_screen_loaded(self, {
			done = true,
			data = "This executable is built without Curl\nNews ticker will be unavailable."
		})

		return 
	end

	self._load(self, self._loading_screen_url, callback(self, "cb_loading_screen_loaded"))

	return 
end
NewsTickerManager.cb_loading_screen_loaded = function (self, info)
	if self._refreshing_loading_screen_message and info.done then
		local str = info.data

		if str and str ~= "" then
			self._loading_screen_text = str
		else
			self._loading_screen_text = nil
		end

		self._refreshing_loading_screen_message = nil
	end

	return 
end
NewsTickerManager.loading_screen_text = function (self)
	return self._loading_screen_text
end
NewsTickerManager.refresh_ingame_message = function (self)
	self._ingame_text = nil
	self._refreshing_ingame_message = true

	if not rawget(_G, "Curl") then
		self.cb_ingame_loaded(self, {
			done = true,
			data = "This executable is built without Curl\nNews ticker will be unavailable."
		})

		return 
	end

	self._load(self, self._ingame_url, callback(self, "cb_ingame_loaded"))

	return 
end
NewsTickerManager.refreshing_ingame_message = function (self)
	return self._refreshing_ingame_message
end
NewsTickerManager.cb_ingame_loaded = function (self, info)
	if self._refreshing_ingame_message and info.done then
		local str = info.data

		if str and str ~= "" then
			self._ingame_text = str
		else
			self._ingame_text = nil
		end

		self._refreshing_ingame_message = nil
	end

	return 
end
NewsTickerManager.ingame_text = function (self)
	return self._ingame_text
end

return 