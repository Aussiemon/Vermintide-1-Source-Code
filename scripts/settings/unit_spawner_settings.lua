RagdollSettings = {
	min_num_ragdolls = 7,
	max_num_ragdolls = 12
}

if Application.platform() == "xb1" then
	RagdollSettings.min_num_ragdolls = 0
	RagdollSettings.max_num_ragdolls = 0
end

return 
