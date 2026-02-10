local hook_id = "BetterInfamy__CrimeSpreeManager.award_rewards__post"

Hooks:PostHook(CrimeSpreeManager, "award_rewards", hook_id, function(self, rewards_table)
	local xp_reward = rewards_table and rewards_table.experience

	if not xp_reward then
		return
	end

	local max_rank = tweak_data.infamy.ranks
	local current_level = managers.experience:current_level()
	local current_rank = managers.experience:current_rank()

	if current_level < 100 or current_rank < 1 or current_rank >= max_rank then
		return
	end

	local max_prestige_xp = managers.experience:get_max_prestige_xp()
	local current_prestige_xp = managers.experience:get_current_prestige_xp()

	if current_prestige_xp > max_prestige_xp then
		current_prestige_xp = max_prestige_xp
	end

	local xp_to_next_rank = max_prestige_xp - current_prestige_xp
	local xp_after_filling = xp_reward - xp_to_next_rank

	if xp_after_filling <= 0 then
		return
	end

	local ranks_increase = 1
	ranks_increase = ranks_increase + math.floor(xp_after_filling / max_prestige_xp)

	if ranks_increase <= 1 then
		return
	end

	local target_rank = current_rank + ranks_increase
	target_rank = math.min(target_rank, max_rank)
	ranks_increase = target_rank - current_rank

	require("lib/managers/hud/HudChallengeNotification")

	local title = managers.localization:to_upper_text("BetterInfamy__popup_title")
	local text = managers.localization:to_upper_text("BetterInfamy__popup_text") .. target_rank

	HudChallengeNotification.queue(title, text)

	managers.experience:set_current_rank(target_rank)
	managers.experience:set_current_prestige_xp(0)

	for i = 1, ranks_increase do
		local total_cost = math.min(math.floor(managers.money:total() * 0.8), 6000000)
		local offshore_cost = math.min(math.floor(managers.money:offshore() * 0.8), 24000000)

		managers.money:deduct_from_total(total_cost, TelemetryConst.economy_origin.increase_infamous)
		managers.money:deduct_from_offshore(offshore_cost)
	end

	if SystemInfo:distribution() == Idstring("STEAM") then
		managers.statistics:publish_level_to_steam()
	end
end)