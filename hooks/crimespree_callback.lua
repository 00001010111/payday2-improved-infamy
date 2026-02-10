function MenuCallbackHandler:claim_crime_spree_rewards(item, node)
	if managers.crime_spree:reward_level() > 0 then
		local penultimate_rank = tweak_data.infamy.ranks - 1
		local current_level = managers.experience:current_level()
		local current_rank = managers.experience:current_rank()
		local claim_rewards_text = ""

		if current_level < 100 or current_rank < 1 or current_rank >= penultimate_rank then
			claim_rewards_text = managers.localization:text("dialog_cs_claim_rewards_text")
		else
			claim_rewards_text = managers.localization:text("dialog_cs_claim_rewards_text") .. managers.localization:text("BetterInfamy__dialog_cs_claim_rewards_text_addition")
		end

		local dialog_data = {
			title = managers.localization:text("dialog_cs_claim_rewards"),
			text = claim_rewards_text,
			id = "crime_spree_rewards"
		}
		local yes_button = {
			text = managers.localization:text("dialog_yes"),
			callback_func = callback(self, self, "_dialog_crime_spree_claim_rewards_yes")
		}
		local no_button = {
			text = managers.localization:text("dialog_no"),
			callback_func = callback(self, self, "_dialog_crime_spree_claim_rewards_no"),
			cancel_button = true
		}
		dialog_data.button_list = {
			yes_button,
			no_button
		}

		managers.system_menu:show(dialog_data)
	else
		local dialog_data = {
			title = managers.localization:text("dialog_cs_claim_rewards"),
			text = managers.localization:text("dialog_cs_cant_claim_rewards_text"),
			id = "crime_spree_rewards"
		}
		local no_button = {
			text = managers.localization:text("dialog_ok"),
			callback_func = callback(self, self, "_dialog_crime_spree_claim_rewards_no"),
			cancel_button = true
		}
		dialog_data.button_list = {
			no_button
		}

		managers.system_menu:show(dialog_data)
	end
end