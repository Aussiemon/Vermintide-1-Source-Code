local reload = true
SubtitleTimedGui = class(SubtitleTimedGui)

local function extract_lines(text)
	local lines = {}
	local text_length = #text
	local index = 1

	for i = 1, text_length, 1 do
		local char = text:sub(i, i)

		if char == " " and i - index > 50 then
			lines[#lines + 1] = text:sub(index, i)
			index = i + 1
		end
	end

	if index < text_length then
		lines[#lines + 1] = text:sub(index, text_length)
	end

	return lines
end

SubtitleTimedGui.init = function (self, subtitle_timing_name, target_widgets)
	if subtitle_timing_name ~= "" then
		subtitle_timing_name = Localize(subtitle_timing_name) or subtitle_timing_name
	end

	self.texts = extract_lines(subtitle_timing_name)
	self.text_scroll_height = 0
	self.next_text_index = 0
	self.text_speed = 20
	self.subtitle_timing_name = subtitle_timing_name
	self.target_widgets = target_widgets
	reload = false
end

SubtitleTimedGui.update = function (self, dt)
	local target_widgets = self.target_widgets

	if reload then
		reload = false
		self.texts = extract_lines(Localize(self.subtitle_timing_name))
		self.next_text_index = 0

		for i = 1, #target_widgets, 1 do
			local widget = target_widgets[i]
			widget.style.text.offset[2] = widget.style.text.start_offset_y
		end
	end

	for i = 1, #target_widgets, 1 do
		local widget = target_widgets[i]
		local offset_y = widget.style.text.offset[2]
		local offset_y_old = offset_y
		offset_y = offset_y + dt * self.text_speed

		if offset_y > 0 and offset_y_old <= 0 then
			local next_text_index = self.next_text_index + 1
			self.next_text_index = next_text_index
			local text = self.texts[next_text_index]
			widget.content.text = text or ""
		elseif offset_y > 200 then
			offset_y = offset_y - #target_widgets * 50
			widget.style.text.text_color[1] = 0
		end

		widget.style.text.offset[2] = offset_y

		if offset_y >= 0 and offset_y < 50 then
			local alpha = math.lerp(0, 255, offset_y / 50)
			widget.style.text.text_color[1] = alpha
		elseif offset_y >= 50 and offset_y < 150 then
			widget.style.text.text_color[1] = 255
		elseif offset_y >= 150 then
			local alpha = math.lerp(255, 0, (offset_y - 150) / 50)
			widget.style.text.text_color[1] = alpha
		end
	end

	local text_scroll_height = self.text_scroll_height + dt * self.text_speed

	if script_data.subtitle_debug then
	end
end

return
