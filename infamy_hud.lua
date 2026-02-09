if RequiredScript == "lib/managers/menu/playerinventorygui" then

	local _old_create = PlayerInventoryGui.create_box

	function PlayerInventoryGui:create_box(data)
		if data and data.name and data.name:find("infamy") then
			data.alpha = 1
			data.clbks = data.clbks or {}
			data.clbks.left  = callback(self, self, "open_infamy_menu")
			data.clbks.right = false
			data.clbks.up    = false
			data.clbks.down  = false
		end

		return _old_create(self, data)
	end


	local _old_update = PlayerInventoryGui._update_info_infamy

	function PlayerInventoryGui:_update_info_infamy(id)
		_old_update(self, id)

		local rank = managers.experience:current_rank()
		local boost = (managers.player:get_infamy_exp_multiplier() - 1) * 100

		local text = managers.localization:to_upper_text("menu_infamy_rank", {
			rank = tostring(rank)
		})

		text = text
			.. "\n\n"
			.. managers.localization:to_upper_text("menu_infamy_total_xp", {
				xpboost = string.format("%.1f", boost)
			})
			.. "\n\n"
			.. managers.localization:text("menu_infamy_help")

		self:set_info_text(text)
	end

elseif RequiredScript == "lib/managers/menu_handler" then

	local function update_lobby_infamy()
		local net = managers.network
		if not net then return end

		local session = net:session()
		if not session then return end

		session:send_to_peers_loaded(
			"lobby_info",
			managers.experience:current_level(),
			managers.experience:current_rank()
		)
	end

	Hooks:PostHook(
		MenuCallbackHandler,
		"_increase_infamous",
		"lobby_infamy_sync_inc",
		update_lobby_infamy
	)

	Hooks:PostHook(
		MenuCallbackHandler,
		"_increase_infamous_with_prestige",
		"lobby_infamy_sync_prestige",
		update_lobby_infamy
	)
end
