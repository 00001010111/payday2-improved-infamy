local hook_id = "BetterInfamy__InfamyTweakData.init__post"

Hooks:PostHook(InfamyTweakData, "init", hook_id, function(self)
	local function digest(value)
		return Application:digest_value(value, true)
	end

	local cost_old = digest(0)
	local cost_new = digest(0)

	self.offshore_cost = {
		cost_old,
		cost_new,
		cost_new,
		cost_new,
		cost_new,
		cost_new
	}
end)