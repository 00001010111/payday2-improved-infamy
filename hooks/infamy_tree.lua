local hook_id = "InfamyRebalance__InfamyTreeGui._setup__post"

Hooks:PostHook(InfamyTreeGui, "_setup", hook_id, function(self)
	local FONT_SIZE = tweak_data.menu.pd2_small_font_size

	local infamous_panel = self.infamous_panel
	local go_infamous_buttons = infamous_panel:child("infamy_panel_bottom"):child("go_infamous_button")
	local go_infamous_text = go_infamous_buttons:children()[1]
	local go_infamous_with_rep = go_infamous_buttons:child("go_infamous_rep_panel")
	local go_infamous_with_prestige = go_infamous_buttons:child("go_infamous_prestige_panel")

	local error_text_rep = infamous_panel:child("infamy_panel_bottom"):children()[2]
	local error_text_prestige = infamous_panel:child("infamy_panel_bottom"):children()[3]

	local current_rank = managers.experience:current_rank()
	local max_rank = tweak_data.infamy.ranks

	if current_rank > 0 then
		self._can_go_infamous = false

		go_infamous_with_prestige:set_y(FONT_SIZE * 2)
		go_infamous_with_rep:set_y(FONT_SIZE * 5)
		go_infamous_with_rep:hide()

		error_text_prestige:set_righttop(go_infamous_buttons:w() - 5, go_infamous_with_prestige:bottom())
		error_text_rep:set_righttop(go_infamous_buttons:w() - 5, go_infamous_with_rep:bottom())
		error_text_rep:hide()

		if current_rank >= max_rank then
			self._can_go_infamous_prestige = false

			go_infamous_text:hide()
			go_infamous_with_prestige:hide()

			error_text_prestige:hide()
		end
	else
		go_infamous_with_prestige:hide()
		error_text_prestige:hide()
	end
end)