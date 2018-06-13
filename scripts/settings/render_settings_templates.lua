ApexClothQuality = {
	off = {
		disable_apex_cloth = true
	},
	low = {
		disable_apex_cloth = false,
		apex_lod_resource_budget = 0.5
	},
	medium = {
		disable_apex_cloth = false,
		apex_lod_resource_budget = 1.5
	},
	high = {
		disable_apex_cloth = false,
		apex_lod_resource_budget = 3
	},
	extreme = {
		disable_apex_cloth = false,
		apex_lod_resource_budget = 5
	}
}
ParticlesQuality = {
	low = {
		particles_tessellation = false,
		particles_receive_shadows = false,
		particles_local_lighting = false
	},
	medium = {
		particles_tessellation = false,
		particles_receive_shadows = false,
		particles_local_lighting = true
	},
	high = {
		particles_tessellation = true,
		particles_receive_shadows = false,
		particles_local_lighting = true
	},
	extreme = {
		particles_tessellation = true,
		particles_receive_shadows = true,
		particles_local_lighting = true
	}
}
SunShadowQuality = {
	low = {
		sun_shadow_map_filter_quality = "low",
		sun_shadow_map_size = {
			256,
			256
		}
	},
	medium = {
		sun_shadow_map_filter_quality = "medium",
		sun_shadow_map_size = {
			512,
			512
		}
	},
	high = {
		sun_shadow_map_filter_quality = "high",
		sun_shadow_map_size = {
			1024,
			1024
		}
	},
	extreme = {
		sun_shadow_map_filter_quality = "high",
		sun_shadow_map_size = {
			2048,
			2048
		}
	}
}
LocalLightShadowQuality = {
	low = {
		local_lights_shadow_map_filter_quality = "low",
		local_lights_shadow_atlas_size = {
			2048,
			2048
		}
	},
	medium = {
		local_lights_shadow_map_filter_quality = "medium",
		local_lights_shadow_atlas_size = {
			2048,
			2048
		}
	},
	high = {
		local_lights_shadow_map_filter_quality = "high",
		local_lights_shadow_atlas_size = {
			2048,
			2048
		}
	},
	extreme = {
		local_lights_shadow_map_filter_quality = "high",
		local_lights_shadow_atlas_size = {
			2048,
			2048
		}
	}
}
TextureQuality = {
	default_characters = script_data.settings.default_characters_texture_quality or "high",
	default_environment = script_data.settings.default_environment_texture_quality or "high",
	characters = {
		low = {
			{
				mip_level = 3,
				texture_setting = "texture_categories/character_df"
			},
			{
				mip_level = 3,
				texture_setting = "texture_categories/character_dfa"
			},
			{
				mip_level = 3,
				texture_setting = "texture_categories/character_ma"
			},
			{
				mip_level = 3,
				texture_setting = "texture_categories/character_nm"
			},
			{
				mip_level = 2,
				texture_setting = "texture_categories/character_df_1p"
			},
			{
				mip_level = 2,
				texture_setting = "texture_categories/character_ma_1p"
			},
			{
				mip_level = 2,
				texture_setting = "texture_categories/character_nm_1p"
			},
			{
				mip_level = 3,
				texture_setting = "texture_categories/weapon_df_3p"
			},
			{
				mip_level = 3,
				texture_setting = "texture_categories/weapon_ma_3p"
			},
			{
				mip_level = 3,
				texture_setting = "texture_categories/weapon_nm_3p"
			},
			{
				mip_level = 2,
				texture_setting = "texture_categories/weapon_df"
			},
			{
				mip_level = 2,
				texture_setting = "texture_categories/weapon_ma"
			},
			{
				mip_level = 2,
				texture_setting = "texture_categories/weapon_nm"
			},
			{
				mip_level = 2,
				texture_setting = "texture_categories/weapon_dfa"
			}
		},
		medium = {
			{
				mip_level = 2,
				texture_setting = "texture_categories/character_df"
			},
			{
				mip_level = 2,
				texture_setting = "texture_categories/character_dfa"
			},
			{
				mip_level = 2,
				texture_setting = "texture_categories/character_ma"
			},
			{
				mip_level = 2,
				texture_setting = "texture_categories/character_nm"
			},
			{
				mip_level = 1,
				texture_setting = "texture_categories/character_df_1p"
			},
			{
				mip_level = 1,
				texture_setting = "texture_categories/character_ma_1p"
			},
			{
				mip_level = 1,
				texture_setting = "texture_categories/character_nm_1p"
			},
			{
				mip_level = 2,
				texture_setting = "texture_categories/weapon_df_3p"
			},
			{
				mip_level = 2,
				texture_setting = "texture_categories/weapon_ma_3p"
			},
			{
				mip_level = 2,
				texture_setting = "texture_categories/weapon_nm_3p"
			},
			{
				mip_level = 1,
				texture_setting = "texture_categories/weapon_df"
			},
			{
				mip_level = 1,
				texture_setting = "texture_categories/weapon_ma"
			},
			{
				mip_level = 1,
				texture_setting = "texture_categories/weapon_nm"
			},
			{
				mip_level = 1,
				texture_setting = "texture_categories/weapon_dfa"
			}
		},
		high = {
			{
				mip_level = 1,
				texture_setting = "texture_categories/character_df"
			},
			{
				mip_level = 1,
				texture_setting = "texture_categories/character_dfa"
			},
			{
				mip_level = 1,
				texture_setting = "texture_categories/character_ma"
			},
			{
				mip_level = 1,
				texture_setting = "texture_categories/character_nm"
			},
			{
				mip_level = 0,
				texture_setting = "texture_categories/character_df_1p"
			},
			{
				mip_level = 0,
				texture_setting = "texture_categories/character_ma_1p"
			},
			{
				mip_level = 0,
				texture_setting = "texture_categories/character_nm_1p"
			},
			{
				mip_level = 1,
				texture_setting = "texture_categories/weapon_df_3p"
			},
			{
				mip_level = 1,
				texture_setting = "texture_categories/weapon_ma_3p"
			},
			{
				mip_level = 1,
				texture_setting = "texture_categories/weapon_nm_3p"
			},
			{
				mip_level = 0,
				texture_setting = "texture_categories/weapon_df"
			},
			{
				mip_level = 0,
				texture_setting = "texture_categories/weapon_ma"
			},
			{
				mip_level = 0,
				texture_setting = "texture_categories/weapon_nm"
			},
			{
				mip_level = 0,
				texture_setting = "texture_categories/weapon_dfa"
			}
		},
		extreme = {
			{
				mip_level = 0,
				texture_setting = "texture_categories/character_df"
			},
			{
				mip_level = 0,
				texture_setting = "texture_categories/character_dfa"
			},
			{
				mip_level = 0,
				texture_setting = "texture_categories/character_ma"
			},
			{
				mip_level = 0,
				texture_setting = "texture_categories/character_nm"
			},
			{
				mip_level = 0,
				texture_setting = "texture_categories/character_df_1p"
			},
			{
				mip_level = 0,
				texture_setting = "texture_categories/character_ma_1p"
			},
			{
				mip_level = 0,
				texture_setting = "texture_categories/character_nm_1p"
			},
			{
				mip_level = 0,
				texture_setting = "texture_categories/weapon_df_3p"
			},
			{
				mip_level = 0,
				texture_setting = "texture_categories/weapon_ma_3p"
			},
			{
				mip_level = 0,
				texture_setting = "texture_categories/weapon_nm_3p"
			},
			{
				mip_level = 0,
				texture_setting = "texture_categories/weapon_df"
			},
			{
				mip_level = 0,
				texture_setting = "texture_categories/weapon_ma"
			},
			{
				mip_level = 0,
				texture_setting = "texture_categories/weapon_nm"
			},
			{
				mip_level = 0,
				texture_setting = "texture_categories/weapon_dfa"
			}
		}
	},
	environment = {
		low = {
			{
				mip_level = 2,
				texture_setting = "texture_categories/environment_df"
			},
			{
				mip_level = 2,
				texture_setting = "texture_categories/environment_dfa"
			},
			{
				mip_level = 2,
				texture_setting = "texture_categories/environment_dfa1"
			},
			{
				mip_level = 2,
				texture_setting = "texture_categories/environment_gsm"
			},
			{
				mip_level = 2,
				texture_setting = "texture_categories/environment_nm"
			},
			{
				mip_level = 2,
				texture_setting = "texture_categories/environment_hm"
			},
			{
				mip_level = 2,
				texture_setting = "texture_categories/environment_hma"
			}
		},
		medium = {
			{
				mip_level = 1,
				texture_setting = "texture_categories/environment_df"
			},
			{
				mip_level = 1,
				texture_setting = "texture_categories/environment_dfa"
			},
			{
				mip_level = 1,
				texture_setting = "texture_categories/environment_dfa1"
			},
			{
				mip_level = 1,
				texture_setting = "texture_categories/environment_gsm"
			},
			{
				mip_level = 1,
				texture_setting = "texture_categories/environment_nm"
			},
			{
				mip_level = 1,
				texture_setting = "texture_categories/environment_hm"
			},
			{
				mip_level = 1,
				texture_setting = "texture_categories/environment_hma"
			}
		},
		high = {
			{
				mip_level = 0,
				texture_setting = "texture_categories/environment_df"
			},
			{
				mip_level = 0,
				texture_setting = "texture_categories/environment_dfa"
			},
			{
				mip_level = 0,
				texture_setting = "texture_categories/environment_dfa1"
			},
			{
				mip_level = 0,
				texture_setting = "texture_categories/environment_gsm"
			},
			{
				mip_level = 0,
				texture_setting = "texture_categories/environment_nm"
			},
			{
				mip_level = 0,
				texture_setting = "texture_categories/environment_hm"
			},
			{
				mip_level = 0,
				texture_setting = "texture_categories/environment_hma"
			}
		}
	}
}
GraphicsQuality = {
	lowest = {
		user_settings = {
			particles_quality = "low",
			use_physic_debris = false,
			use_high_quality_fur = false,
			local_light_shadow_quality = "low",
			num_blood_decals = 0,
			animation_lod_distance_multiplier = 0,
			char_texture_quality = "low",
			sun_shadow_quality = "low",
			env_texture_quality = "low"
		},
		render_settings = {
			ao_enabled = false,
			deferred_local_lights_cast_shadows = false,
			taa_enabled = false,
			fxaa_enabled = false,
			light_shaft_enabled = false,
			skin_material_enabled = false,
			sun_shadows = false,
			forward_local_lights_cast_shadows = false,
			max_shadow_casting_lights = 1,
			low_res_transparency = true,
			lod_scatter_density = 0,
			dof_enabled = false,
			motion_blur_enabled = false,
			ssr_enabled = false,
			bloom_enabled = false
		}
	},
	low = {
		user_settings = {
			particles_quality = "low",
			use_physic_debris = false,
			use_high_quality_fur = false,
			local_light_shadow_quality = "low",
			num_blood_decals = 10,
			animation_lod_distance_multiplier = 0,
			char_texture_quality = "low",
			sun_shadow_quality = "low",
			env_texture_quality = "low"
		},
		render_settings = {
			ao_enabled = false,
			deferred_local_lights_cast_shadows = false,
			taa_enabled = false,
			fxaa_enabled = false,
			light_shaft_enabled = true,
			skin_material_enabled = false,
			sun_shadows = true,
			forward_local_lights_cast_shadows = false,
			max_shadow_casting_lights = 1,
			low_res_transparency = true,
			lod_scatter_density = 0.25,
			dof_enabled = false,
			motion_blur_enabled = false,
			ssr_enabled = false,
			bloom_enabled = true
		}
	},
	medium = {
		user_settings = {
			particles_quality = "low",
			use_physic_debris = true,
			use_high_quality_fur = false,
			local_light_shadow_quality = "medium",
			num_blood_decals = 25,
			animation_lod_distance_multiplier = 0.5,
			char_texture_quality = "medium",
			sun_shadow_quality = "medium",
			env_texture_quality = "medium"
		},
		render_settings = {
			ao_enabled = true,
			deferred_local_lights_cast_shadows = false,
			taa_enabled = false,
			fxaa_enabled = true,
			light_shaft_enabled = true,
			skin_material_enabled = false,
			sun_shadows = true,
			forward_local_lights_cast_shadows = false,
			max_shadow_casting_lights = 1,
			low_res_transparency = true,
			lod_scatter_density = 0.5,
			dof_enabled = false,
			motion_blur_enabled = true,
			ssr_enabled = false,
			bloom_enabled = true
		}
	},
	high = {
		user_settings = {
			particles_quality = "medium",
			use_physic_debris = true,
			use_high_quality_fur = true,
			local_light_shadow_quality = "high",
			num_blood_decals = 50,
			animation_lod_distance_multiplier = 1,
			char_texture_quality = "high",
			sun_shadow_quality = "high",
			env_texture_quality = "high"
		},
		render_settings = {
			ao_enabled = true,
			deferred_local_lights_cast_shadows = true,
			taa_enabled = true,
			fxaa_enabled = false,
			light_shaft_enabled = true,
			skin_material_enabled = true,
			sun_shadows = true,
			forward_local_lights_cast_shadows = true,
			max_shadow_casting_lights = 2,
			low_res_transparency = true,
			lod_scatter_density = 1,
			dof_enabled = true,
			motion_blur_enabled = true,
			ssr_enabled = true,
			bloom_enabled = true
		}
	},
	extreme = {
		user_settings = {
			particles_quality = "high",
			use_physic_debris = true,
			use_high_quality_fur = true,
			local_light_shadow_quality = "extreme",
			num_blood_decals = 100,
			animation_lod_distance_multiplier = 1,
			char_texture_quality = "extreme",
			sun_shadow_quality = "extreme",
			env_texture_quality = "high"
		},
		render_settings = {
			ao_enabled = true,
			deferred_local_lights_cast_shadows = true,
			taa_enabled = true,
			fxaa_enabled = false,
			light_shaft_enabled = true,
			skin_material_enabled = true,
			sun_shadows = true,
			forward_local_lights_cast_shadows = true,
			max_shadow_casting_lights = 6,
			low_res_transparency = true,
			lod_scatter_density = 1,
			dof_enabled = true,
			motion_blur_enabled = true,
			ssr_enabled = true,
			bloom_enabled = true
		}
	},
	custom = {
		user_settings = {},
		render_settings = {}
	}
}

return
