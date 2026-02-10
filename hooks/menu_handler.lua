local hook_id = "BetterInfamy__MenuCallbackHandler._increase_infamous_with_prestige__pre"

Hooks:PreHook(MenuCallbackHandler, "_increase_infamous_with_prestige", hook_id, function()
	local max_rank = tweak_data.infamy.ranks
	local current_level = managers.experience:current_level()
	local current_rank = managers.experience:current_rank()

	if current_level < 100 or current_rank >= max_rank then
		return
	end

	local rank = current_rank + 1
	local offshore_cost = managers.money:get_infamous_cost(rank)

	if offshore_cost == 0 then
		local total_cost = math.min(math.floor(managers.money:total() * 0.8), 6000000)
		local offshore_cost = math.min(math.floor(managers.money:offshore() * 0.8), 24000000)

		managers.money:deduct_from_total(total_cost, TelemetryConst.economy_origin.increase_infamous)
		managers.money:deduct_from_offshore(offshore_cost)
	end
end)