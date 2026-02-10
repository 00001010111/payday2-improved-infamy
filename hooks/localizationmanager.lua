local mod_path = ModPath
local hook_id = "BetterInfamy__LocalizationManagerPostInit"

Hooks:Add("LocalizationManagerPostInit", hook_id, function(localization_manager)
	for _, filename in pairs(file.GetFiles(mod_path .. "localization/")) do
		local strings = filename:match('^(.*).json$')

		if strings and Idstring(strings) and Idstring(strings):key() == SystemInfo:language():key() then
			localization_manager:load_localization_file(mod_path .. "localization/" .. filename)
			break
		end
	end

	localization_manager:load_localization_file(mod_path .. "localization/english.json", false)
end)