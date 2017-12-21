return {
	template = "core/stingray_renderer/environments/outdoor.shading_environment_template",
	settings = {
		heal_medikit = {
			variables = {
				ssr_enabled = 0,
				dof_focal_region_start = 5,
				light_shaft_enabled = 1,
				global_roughness_multiplier = 1,
				dof_enabled = 0,
				sun_shadows_enabled = 1,
				custom_fog_blend_enabled = 0,
				motion_blur_amount = 2,
				dof_focal_region = 5,
				color_grading_map = "environment/textures/color_grading_identity",
				vignette_enabled = 1,
				emissive_particle_intensity = 1,
				ambient_diffuse_fade_type = 0,
				dof_focal_region_end = 5,
				skydome_map = "",
				temporal_effects_enabled = 1,
				global_diffuse_map = "",
				exposure = 0.25,
				global_specular_map = "",
				dof_focal_distance = 10,
				ao_enabled = 1,
				ao_quality = 2,
				skydome_intensity = 1.0959296482412,
				bloom_enabled = 1,
				ssr_ray_bending_enabled = 0,
				ao_intensity = 0.6,
				eye_intensity = 1,
				motion_blur_enabled = 0,
				light_shaft_weigth = 0.01,
				ssm_constant_update_enabled = 0,
				ao_radius = 0.2,
				lens_quality_enabled = 0,
				fog_enabled = 1,
				ssm_enabled = 0,
				ssm_radius = 200,
				sun_enabled = 1,
				outline_enabled = 1,
				skydome_u_offset = 0,
				ssr_screen_edge_threshold = 0.05,
				offscreen_target_projection = 0,
				dof_focal_near_scale = 1,
				eye_adaptation_enabled = 0,
				bloom_lens_dirt_amount = 1,
				secondary_sun_enabled = 0,
				skydome_cloud_map = "environment/textures/cloud_noclouds",
				global_lens_dirt_map = "environment/textures/lensdirt",
				dof_focal_far_scale = 1,
				fog_type = 0,
				ssm_rotation = 0,
				outline_thickness = {
					1,
					1,
					1,
					1
				},
				vignette_scale_falloff_opacity = {
					2.509,
					2.5,
					0
				},
				custom_fog_blend_direction = {
					0,
					0,
					-1
				},
				sun_shadow_map_bias = {
					0.0001,
					0.001,
					50
				},
				bloom_tint = {
					1,
					1,
					1
				},
				sun_shadow_slice_depth_ranges = {
					0,
					8.2590977538167,
					8.2590977538167,
					17.637056274848,
					17.637056274848,
					32.965447423407,
					32.965447423407,
					79.94
				},
				ssr_surface_thickness_threshold = {
					[1.0] = 0.001,
					[2.0] = 5
				},
				skydome_tint_color = {
					1,
					1,
					1
				},
				skydome_fog_height_falloff = {
					[1.0] = 0,
					[2.0] = -50
				},
				bloom_threshold_offset_falloff = {
					1,
					1.6,
					1
				},
				secondary_sun_color = {
					1,
					1,
					1
				},
				vignette_color = {
					0,
					0,
					0
				},
				fog_depth_range = {
					[1.0] = 10,
					[2.0] = 100
				},
				skydome_cloud_speed_scale = {
					[1.0] = 0,
					[2.0] = 1
				},
				lens_quality_properties = {
					0,
					0,
					0
				},
				light_shaft_settings = {
					[1.0] = 1,
					[2.0] = 1
				},
				custom_fog_blend_color = {
					1,
					1,
					1
				},
				wind_amount = {
					0,
					0,
					0
				},
				local_shadow_map_bias = {
					0.0001,
					0.015,
					50
				},
				ambient_tint = {
					1,
					1,
					1
				},
				sun_direction = {
					0,
					0,
					-1
				},
				sun_color = {
					1,
					1,
					1
				},
				custom_fog_blend = {
					1,
					8,
					1
				},
				ssm_shadow_map_bias = {
					0.0005,
					0.0001,
					20
				},
				ssm_center = {
					0,
					0,
					0
				},
				ssm_near_far = {
					[1.0] = 0,
					[2.0] = 0
				},
				height_fog_offset_falloff = {
					[1.0] = 0,
					[2.0] = 500
				},
				fog_sun_blend = {
					1,
					8,
					1
				},
				secondary_sun_direction = {
					0,
					0,
					-1
				},
				fog_color = {
					0.6,
					0.6,
					0.6
				},
				eye_adaptation_speed_min_max = {
					1,
					0.01,
					30
				},
				secondary_sun_blend = {
					1,
					8,
					1
				},
				ambient_diffuse_fade = {
					0,
					0,
					10
				}
			},
			editor_variables = {
				sun_shadow_slice_depth_ranges = {
					0,
					80,
					0.4
				}
			},
			variable_weights = {
				dof_focal_far_scale = 0,
				custom_fog_blend = 0,
				skydome_fog_height_falloff = 0,
				motion_blur_amount = 0,
				light_shaft_enabled = 0,
				secondary_sun_color = 0,
				dof_enabled = 0,
				sun_shadows_enabled = 0,
				secondary_sun_direction = 0,
				custom_fog_blend_enabled = 0,
				vignette_scale_falloff_opacity = 1,
				skydome_cloud_speed_scale = 0,
				dof_focal_region_start = 0,
				skydome_u_offset = 0,
				sun_shadow_map_bias = 0,
				dof_focal_region = 0,
				ssm_enabled = 0,
				color_grading_map = 0,
				custom_fog_blend_direction = 0,
				emissive_particle_intensity = 0,
				vignette_enabled = 0,
				dof_focal_region_end = 0,
				skydome_map = 0,
				vignette_color = 0,
				custom_fog_blend_color = 0,
				temporal_effects_enabled = 0,
				ssm_center = 0,
				ssm_near_far = 0,
				height_fog_offset_falloff = 0,
				fog_sun_blend = 0,
				secondary_sun_blend = 0,
				fog_color = 0,
				global_diffuse_map = 0,
				exposure = 1,
				global_specular_map = 0,
				dof_focal_distance = 0,
				ambient_diffuse_fade = 0,
				ao_enabled = 0,
				ao_quality = 0,
				lens_quality_properties = 0,
				skydome_intensity = 0,
				ssr_enabled = 0,
				bloom_enabled = 0,
				ssr_ray_bending_enabled = 0,
				sun_color = 0,
				ao_intensity = 0,
				eye_intensity = 0,
				bloom_tint = 0,
				motion_blur_enabled = 0,
				ssr_surface_thickness_threshold = 0,
				ssm_constant_update_enabled = 0,
				light_shaft_settings = 0,
				ao_radius = 0,
				lens_quality_enabled = 0,
				fog_enabled = 0,
				wind_amount = 0,
				ambient_tint = 0,
				sun_direction = 0,
				ambient_diffuse_fade_type = 0,
				ssm_radius = 0,
				bloom_threshold_offset_falloff = 1,
				sun_enabled = 0,
				fog_depth_range = 0,
				eye_adaptation_speed_min_max = 0,
				outline_enabled = 0,
				outline_thickness = 0,
				sun_shadow_slice_depth_ranges = 0,
				skydome_tint_color = 0,
				ssr_screen_edge_threshold = 0,
				dof_focal_near_scale = 0,
				eye_adaptation_enabled = 0,
				bloom_lens_dirt_amount = 0,
				secondary_sun_enabled = 0,
				skydome_cloud_map = 0,
				global_lens_dirt_map = 0,
				global_roughness_multiplier = 0,
				fog_type = 0,
				local_shadow_map_bias = 0,
				ssm_rotation = 0
			}
		},
		default = {
			variables = {
				dof_focal_far_scale = 0.273,
				ambient_diffuse_fade_type = 2,
				light_shaft_enabled = 1,
				light_shaft_falloff = 1,
				sun_shadows_enabled = 1,
				dof_enabled = 0,
				ao_radius = 1,
				dof_focal_region_start = 5,
				motion_blur_amount = 0.4,
				dof_focal_region = 24.39,
				ssr_enabled = 0,
				color_grading_map = "environment/textures/color_grading_identity",
				emissive_particle_intensity = 1,
				ssm_constant_update_enabled = 0,
				dof_focal_region_end = 158.54,
				skydome_map = "units/textures/g/generic_texture_grey",
				temporal_effects_enabled = 1,
				skydome_u_offset = 0,
				vignette_enabled = 1,
				global_diffuse_map = "environment/textures/moods_diffuse_cubemap",
				exposure = 0.2,
				global_specular_map = "environment/textures/moods_specular_cubemap",
				dof_focal_distance = 0,
				ao_enabled = 1,
				ao_quality = 1,
				skydome_intensity = 1,
				bloom_enabled = 1,
				ssr_ray_bending_enabled = 0,
				ao_intensity = 0.25,
				eye_intensity = 1,
				motion_blur_enabled = 1,
				light_shaft_weigth = 0.01,
				custom_fog_blend_enabled = 0,
				lens_quality_enabled = 0,
				fog_enabled = 1,
				ssm_enabled = 0,
				ssm_radius = 200,
				sun_enabled = 1,
				outline_enabled = 1,
				ssr_screen_edge_threshold = 0.05,
				offscreen_target_projection = 0,
				dof_focal_near_scale = 1,
				eye_adaptation_enabled = 1,
				lens_dirt_map = "units/textures/g/generic_texture_grey",
				bloom_lens_dirt_amount = 1,
				secondary_sun_enabled = 0,
				skydome_cloud_map = "units/textures/g/generic_texture_grey",
				global_lens_dirt_map = "units/textures/g/generic_texture_grey",
				global_roughness_multiplier = 1,
				fog_type = 1,
				ssm_rotation = 0,
				outline_thickness = {
					1,
					1,
					1,
					1
				},
				sun_ = {
					0,
					7.8873025160209,
					7.8873025160209,
					16.928896390218,
					16.928896390218,
					32.109353258482,
					32.109353258482,
					79.9381
				},
				vignette_scale_falloff_opacity = {
					5,
					5,
					0.5
				},
				custom_fog_blend_direction = {
					0.91508618606599,
					-0.40325831928332,
					0
				},
				sun_shadow_map_bias = {
					0.0001,
					0.001,
					50
				},
				skydome_fog_falloff = {
					[1.0] = 0,
					[2.0] = -50
				},
				bloom_tint = {
					1,
					1,
					1
				},
				sun_shadow_slice_depth_ranges = {
					0,
					0.93268792631474,
					0.93268792631474,
					2.5215378772032,
					2.5215378772032,
					6.5779527672696,
					6.5779527672696,
					19.9139
				},
				ssr_surface_thickness_threshold = {
					[1.0] = 0.001,
					[2.0] = 5
				},
				skydome_tint_color = {
					0,
					0,
					0
				},
				skydome_fog_height_falloff = {
					[1.0] = 0.088,
					[2.0] = -2.93
				},
				bloom_threshold_offset_falloff = {
					3,
					1.8,
					1
				},
				secondary_sun_color = {
					1,
					1,
					1
				},
				vignette_color = {
					0,
					0,
					0
				},
				fog_depth_range = {
					[1.0] = 5,
					[2.0] = 292.68
				},
				skydome_cloud_speed_scale = {
					[1.0] = 0.6,
					[2.0] = 0.25
				},
				lens_quality_properties = {
					0,
					0,
					0
				},
				wind_amount = {
					0,
					0,
					0
				},
				light_shaft_settings = {
					[1.0] = 4.5665707676919,
					[2.0] = 0.635
				},
				custom_fog_blend_color = {
					0,
					0,
					0
				},
				local_shadow_map_bias = {
					0.0001,
					0.015,
					50
				},
				sun_direction = {
					-0.29576294600103,
					0.09858764866701,
					-0.95016038398951
				},
				sun_color = {
					0.125,
					0.125,
					0.125
				},
				custom_fog_blend = {
					1,
					8,
					1
				},
				ssm_shadow_map_bias = {
					0.0005,
					0.0001,
					20
				},
				ambient_tint = {
					1,
					1,
					1
				},
				ssm_center = {
					0,
					0,
					0
				},
				ssm_near_far = {
					[1.0] = 0,
					[2.0] = 0
				},
				height_fog_offset_falloff = {
					[1.0] = -375.61,
					[2.0] = 1780.5523560976
				},
				fog_sun_blend = {
					0.195,
					4.15,
					0.668
				},
				secondary_sun_direction = {
					-0.722628794866,
					0.55745649889663,
					-0.40871735547737
				},
				fog_color = {
					0.040441176470588,
					0.047707612456747,
					0.0625
				},
				eye_adaptation_speed_min_max = {
					1,
					0.01,
					30
				},
				secondary_sun_blend = {
					1,
					8,
					1
				},
				ambient_diffuse_fade = {
					0.5,
					0.488,
					8.727
				}
			},
			editor_variables = {
				sun_shadow_slice_depth_ranges = {
					0,
					20,
					0.139
				}
			},
			variable_weights = {
				color_grading_map = 1,
				skydome_intensity = 1,
				exposure = 1
			}
		},
		knocked_down = {
			variables = {
				ssr_enabled = 0,
				dof_focal_region_start = 5,
				light_shaft_enabled = 1,
				global_roughness_multiplier = 1,
				dof_enabled = 1,
				sun_shadows_enabled = 1,
				custom_fog_blend_enabled = 0,
				motion_blur_amount = 2,
				dof_focal_region = 15,
				color_grading_map = "environment/textures/color_grading_knocked_down",
				vignette_enabled = 1,
				emissive_particle_intensity = 1,
				ambient_diffuse_fade_type = 0,
				dof_focal_region_end = 10,
				skydome_map = "",
				temporal_effects_enabled = 1,
				global_diffuse_map = "",
				exposure = 1,
				global_specular_map = "",
				dof_focal_distance = 5,
				ao_enabled = 1,
				ao_quality = 2,
				skydome_intensity = 1,
				bloom_enabled = 1,
				ssr_ray_bending_enabled = 0,
				ao_intensity = 0.6,
				eye_intensity = 1,
				motion_blur_enabled = 0,
				light_shaft_weigth = 0.01,
				ssm_constant_update_enabled = 0,
				ao_radius = 0.2,
				lens_quality_enabled = 0,
				fog_enabled = 1,
				ssm_enabled = 0,
				ssm_radius = 200,
				sun_enabled = 1,
				outline_enabled = 1,
				skydome_u_offset = 0,
				ssr_screen_edge_threshold = 0.05,
				offscreen_target_projection = 0,
				dof_focal_near_scale = 0.288,
				eye_adaptation_enabled = 0,
				bloom_lens_dirt_amount = 1,
				secondary_sun_enabled = 0,
				skydome_cloud_map = "environment/textures/cloud_noclouds",
				global_lens_dirt_map = "environment/textures/lensdirt",
				dof_focal_far_scale = 1,
				fog_type = 0,
				ssm_rotation = 0,
				outline_thickness = {
					1,
					1,
					1,
					1
				},
				vignette_scale_falloff_opacity = {
					3.659,
					5.509,
					0.107
				},
				custom_fog_blend_direction = {
					0,
					0,
					-1
				},
				sun_shadow_map_bias = {
					0.0001,
					0.001,
					50
				},
				bloom_tint = {
					1,
					1,
					1
				},
				sun_shadow_slice_depth_ranges = {
					0,
					8.2590977538167,
					8.2590977538167,
					17.637056274848,
					17.637056274848,
					32.965447423407,
					32.965447423407,
					79.94
				},
				ssr_surface_thickness_threshold = {
					[1.0] = 0.001,
					[2.0] = 5
				},
				skydome_tint_color = {
					1,
					0,
					0
				},
				skydome_fog_height_falloff = {
					[1.0] = 0.199,
					[2.0] = -0.75
				},
				bloom_threshold_offset_falloff = {
					0.01,
					1.525,
					1
				},
				secondary_sun_color = {
					1,
					1,
					1
				},
				vignette_color = {
					1,
					0,
					0
				},
				fog_depth_range = {
					[1.0] = 1,
					[2.0] = 50
				},
				skydome_cloud_speed_scale = {
					[1.0] = 0,
					[2.0] = 1
				},
				lens_quality_properties = {
					0,
					0,
					0
				},
				light_shaft_settings = {
					[1.0] = 1,
					[2.0] = 1
				},
				custom_fog_blend_color = {
					1,
					1,
					1
				},
				wind_amount = {
					0,
					0,
					0
				},
				local_shadow_map_bias = {
					0.0001,
					0.015,
					50
				},
				ambient_tint = {
					1,
					1,
					1
				},
				sun_direction = {
					0,
					0,
					-1
				},
				sun_color = {
					1,
					1,
					1
				},
				custom_fog_blend = {
					1,
					8,
					1
				},
				ssm_shadow_map_bias = {
					0.0005,
					0.0001,
					20
				},
				ssm_center = {
					0,
					0,
					0
				},
				ssm_near_far = {
					[1.0] = 0,
					[2.0] = 0
				},
				height_fog_offset_falloff = {
					[1.0] = 0,
					[2.0] = 500
				},
				fog_sun_blend = {
					1,
					8,
					1
				},
				secondary_sun_direction = {
					0,
					0,
					-1
				},
				fog_color = {
					0.0625,
					0.041421568627451,
					0.041421568627451
				},
				eye_adaptation_speed_min_max = {
					1,
					0.01,
					30
				},
				secondary_sun_blend = {
					1,
					8,
					1
				},
				ambient_diffuse_fade = {
					0,
					0,
					10
				}
			},
			editor_variables = {
				sun_shadow_slice_depth_ranges = {
					0,
					80,
					0.4
				}
			},
			variable_weights = {
				ssr_ray_bending_enabled = 0,
				ssr_enabled = 0,
				skydome_fog_height_falloff = 0,
				skydome_tint_color = 0,
				light_shaft_enabled = 0,
				outline_enabled = 0,
				secondary_sun_color = 0,
				ambient_diffuse_fade_type = 0,
				secondary_sun_direction = 0,
				dof_enabled = 1,
				sun_shadows_enabled = 0,
				skydome_cloud_speed_scale = 0,
				custom_fog_blend_enabled = 0,
				global_roughness_multiplier = 0,
				sun_shadow_map_bias = 0,
				dof_focal_region = 1,
				motion_blur_amount = 0,
				color_grading_map = 1,
				custom_fog_blend_direction = 0,
				emissive_particle_intensity = 0,
				ssm_near_far = 0,
				dof_focal_region_end = 1,
				skydome_map = 0,
				vignette_color = 0,
				custom_fog_blend_color = 0,
				temporal_effects_enabled = 0,
				ssm_center = 0,
				ssm_constant_update_enabled = 0,
				fog_sun_blend = 0,
				fog_color = 1,
				secondary_sun_blend = 0,
				dof_focal_distance = 1,
				global_diffuse_map = 0,
				exposure = 0,
				global_specular_map = 0,
				ambient_diffuse_fade = 0,
				ao_enabled = 0,
				ao_quality = 0,
				lens_quality_properties = 0,
				skydome_intensity = 0,
				custom_fog_blend = 0,
				bloom_enabled = 0,
				height_fog_offset_falloff = 0,
				sun_color = 0,
				ao_intensity = 0,
				eye_intensity = 0,
				bloom_tint = 0,
				motion_blur_enabled = 0,
				light_shaft_weigth = 0,
				ssr_surface_thickness_threshold = 0,
				ssm_shadow_map_bias = 0,
				vignette_scale_falloff_opacity = 1,
				light_shaft_settings = 0,
				ao_radius = 0,
				lens_quality_enabled = 0,
				wind_amount = 0,
				sun_direction = 0,
				ssm_enabled = 0,
				ssm_radius = 0,
				bloom_threshold_offset_falloff = 1,
				sun_enabled = 0,
				fog_depth_range = 1,
				eye_adaptation_speed_min_max = 0,
				dof_focal_region_start = 1,
				outline_thickness = 0,
				sun_shadow_slice_depth_ranges = 0,
				skydome_u_offset = 0,
				ssr_screen_edge_threshold = 0,
				offscreen_target_projection = 0,
				dof_focal_near_scale = 1,
				eye_adaptation_enabled = 0,
				bloom_lens_dirt_amount = 0,
				secondary_sun_enabled = 0,
				skydome_cloud_map = 0,
				global_lens_dirt_map = 0,
				dof_focal_far_scale = 1,
				fog_type = 0,
				local_shadow_map_bias = 0,
				ssm_rotation = 0
			}
		},
		bleeding_out = {
			variables = {
				ssr_enabled = 0,
				dof_focal_region_start = 5,
				light_shaft_enabled = 1,
				global_roughness_multiplier = 1,
				dof_enabled = 1,
				sun_shadows_enabled = 1,
				custom_fog_blend_enabled = 0,
				motion_blur_amount = 2,
				dof_focal_region = 5,
				color_grading_map = "environment/textures/color_grading_bleeding_out",
				vignette_enabled = 0,
				emissive_particle_intensity = 1.5,
				ambient_diffuse_fade_type = 0,
				dof_focal_region_end = 5,
				skydome_map = "",
				temporal_effects_enabled = 1,
				global_diffuse_map = "",
				exposure = 4,
				global_specular_map = "",
				dof_focal_distance = 10,
				ao_enabled = 1,
				ao_quality = 2,
				skydome_intensity = 1,
				bloom_enabled = 1,
				ssr_ray_bending_enabled = 0,
				ao_intensity = 0.6,
				eye_intensity = 1,
				motion_blur_enabled = 0,
				light_shaft_weigth = 0.01,
				ssm_constant_update_enabled = 0,
				ao_radius = 0.2,
				lens_quality_enabled = 0,
				fog_enabled = 1,
				ssm_enabled = 0,
				ssm_radius = 200,
				sun_enabled = 1,
				outline_enabled = 1,
				skydome_u_offset = 0,
				ssr_screen_edge_threshold = 0.05,
				offscreen_target_projection = 0,
				dof_focal_near_scale = 1,
				eye_adaptation_enabled = 0,
				bloom_lens_dirt_amount = 1,
				secondary_sun_enabled = 0,
				skydome_cloud_map = "environment/textures/cloud_noclouds",
				global_lens_dirt_map = "environment/textures/lensdirt",
				dof_focal_far_scale = 1,
				fog_type = 0,
				ssm_rotation = 0,
				outline_thickness = {
					1,
					1,
					1,
					1
				},
				vignette_scale_falloff_opacity = {
					1.185,
					2.305,
					1
				},
				custom_fog_blend_direction = {
					0,
					0,
					-1
				},
				sun_shadow_map_bias = {
					0.0001,
					0.001,
					50
				},
				bloom_tint = {
					1,
					1,
					1
				},
				sun_shadow_slice_depth_ranges = {
					0,
					8.2590977538167,
					8.2590977538167,
					17.637056274848,
					17.637056274848,
					32.965447423407,
					32.965447423407,
					79.94
				},
				ssr_surface_thickness_threshold = {
					[1.0] = 0.001,
					[2.0] = 5
				},
				skydome_tint_color = {
					1,
					1,
					1
				},
				skydome_fog_height_falloff = {
					[1.0] = 0,
					[2.0] = -50
				},
				bloom_threshold_offset_falloff = {
					0.01,
					1.8,
					1
				},
				secondary_sun_color = {
					1,
					1,
					1
				},
				vignette_color = {
					1,
					0,
					0
				},
				fog_depth_range = {
					[1.0] = 10,
					[2.0] = 100
				},
				skydome_cloud_speed_scale = {
					[1.0] = 0,
					[2.0] = 1
				},
				lens_quality_properties = {
					0,
					0,
					0
				},
				light_shaft_settings = {
					[1.0] = 1,
					[2.0] = 1
				},
				custom_fog_blend_color = {
					1,
					1,
					1
				},
				wind_amount = {
					0,
					0,
					0
				},
				local_shadow_map_bias = {
					0.0001,
					0.015,
					50
				},
				ambient_tint = {
					1,
					1,
					1
				},
				sun_direction = {
					0,
					0,
					-1
				},
				sun_color = {
					1,
					1,
					1
				},
				custom_fog_blend = {
					1,
					8,
					1
				},
				ssm_shadow_map_bias = {
					0.0005,
					0.0001,
					20
				},
				ssm_center = {
					0,
					0,
					0
				},
				ssm_near_far = {
					[1.0] = 0,
					[2.0] = 0
				},
				height_fog_offset_falloff = {
					[1.0] = 0,
					[2.0] = 500
				},
				fog_sun_blend = {
					1,
					8,
					1
				},
				secondary_sun_direction = {
					0,
					0,
					-1
				},
				fog_color = {
					0,
					1.990717618533,
					0.70260621830576
				},
				eye_adaptation_speed_min_max = {
					1,
					0.01,
					30
				},
				secondary_sun_blend = {
					1,
					8,
					1
				},
				ambient_diffuse_fade = {
					0,
					0,
					10
				}
			},
			editor_variables = {
				sun_shadow_slice_depth_ranges = {
					0,
					80,
					0.4
				}
			},
			variable_weights = {
				global_roughness_multiplier = 0,
				ssr_enabled = 0,
				skydome_fog_height_falloff = 0,
				motion_blur_amount = 0,
				light_shaft_enabled = 0,
				secondary_sun_color = 0,
				ambient_diffuse_fade_type = 0,
				ssm_center = 0,
				sun_shadows_enabled = 0,
				dof_enabled = 0,
				custom_fog_blend_enabled = 0,
				skydome_cloud_speed_scale = 0,
				vignette_scale_falloff_opacity = 0,
				dof_focal_region_start = 0,
				sun_shadow_map_bias = 0,
				dof_focal_region = 0,
				skydome_tint_color = 0,
				color_grading_map = 1,
				custom_fog_blend_direction = 0,
				emissive_particle_intensity = 1,
				vignette_enabled = 0,
				dof_focal_region_end = 0,
				skydome_map = 0,
				vignette_color = 1,
				custom_fog_blend_color = 0,
				temporal_effects_enabled = 0,
				ssm_near_far = 0,
				height_fog_offset_falloff = 0,
				fog_sun_blend = 0,
				secondary_sun_direction = 0,
				secondary_sun_blend = 0,
				fog_color = 0,
				global_diffuse_map = 0,
				exposure = 0,
				global_specular_map = 0,
				dof_focal_distance = 0,
				ambient_diffuse_fade = 0,
				ao_enabled = 0,
				ao_quality = 0,
				lens_quality_properties = 0,
				skydome_intensity = 0,
				custom_fog_blend = 0,
				bloom_enabled = 0,
				ssr_ray_bending_enabled = 0,
				sun_color = 0,
				ao_intensity = 0,
				eye_intensity = 0,
				bloom_tint = 0,
				motion_blur_enabled = 0,
				light_shaft_weigth = 0,
				ssr_surface_thickness_threshold = 0,
				ssm_shadow_map_bias = 0,
				ssm_constant_update_enabled = 0,
				light_shaft_settings = 0,
				ao_radius = 0,
				lens_quality_enabled = 0,
				fog_enabled = 0,
				wind_amount = 0,
				sun_direction = 0,
				ssm_enabled = 0,
				ssm_radius = 0,
				bloom_threshold_offset_falloff = 0,
				sun_enabled = 0,
				fog_depth_range = 0,
				eye_adaptation_speed_min_max = 0,
				outline_enabled = 0,
				outline_thickness = 0,
				sun_shadow_slice_depth_ranges = 0,
				skydome_u_offset = 0,
				ssr_screen_edge_threshold = 0,
				offscreen_target_projection = 0,
				dof_focal_near_scale = 0,
				eye_adaptation_enabled = 0,
				bloom_lens_dirt_amount = 0,
				secondary_sun_enabled = 0,
				skydome_cloud_map = 0,
				global_lens_dirt_map = 0,
				dof_focal_far_scale = 0,
				fog_type = 0,
				local_shadow_map_bias = 0,
				ssm_rotation = 0
			}
		},
		menu = {
			variables = {
				ssr_enabled = 0,
				dof_focal_region_start = 3,
				light_shaft_enabled = 1,
				global_roughness_multiplier = 1,
				dof_enabled = 1,
				sun_shadows_enabled = 1,
				custom_fog_blend_enabled = 0,
				motion_blur_amount = 2,
				dof_focal_region = 3,
				color_grading_map = "environment/textures/color_grading_ingame_menu",
				vignette_enabled = 1,
				emissive_particle_intensity = 1,
				ambient_diffuse_fade_type = 0,
				dof_focal_region_end = 3,
				skydome_map = "",
				temporal_effects_enabled = 1,
				global_diffuse_map = "",
				exposure = 2.246052631579,
				global_specular_map = "",
				dof_focal_distance = 5,
				ao_enabled = 1,
				ao_quality = 2,
				skydome_intensity = 1,
				bloom_enabled = 1,
				ssr_ray_bending_enabled = 0,
				ao_intensity = 0.6,
				eye_intensity = 1,
				motion_blur_enabled = 0,
				light_shaft_weigth = 0.01,
				ssm_constant_update_enabled = 0,
				ao_radius = 0.2,
				lens_quality_enabled = 0,
				fog_enabled = 1,
				ssm_enabled = 1,
				ssm_radius = 200,
				sun_enabled = 1,
				outline_enabled = 1,
				skydome_u_offset = 0,
				ssr_screen_edge_threshold = 0.05,
				offscreen_target_projection = 0,
				dof_focal_near_scale = 1,
				eye_adaptation_enabled = 0,
				bloom_lens_dirt_amount = 1,
				secondary_sun_enabled = 0,
				skydome_cloud_map = "environment/textures/cloud_noclouds",
				global_lens_dirt_map = "environment/textures/lensdirt",
				dof_focal_far_scale = 1,
				fog_type = 0,
				ssm_rotation = 0,
				outline_thickness = {
					1,
					1,
					1,
					1
				},
				vignette_scale_falloff_opacity = {
					3.512,
					4.688,
					0.615
				},
				custom_fog_blend_direction = {
					0,
					0,
					-1
				},
				sun_shadow_map_bias = {
					0.0001,
					0.001,
					50
				},
				bloom_tint = {
					1,
					1,
					1
				},
				sun_shadow_slice_depth_ranges = {
					0,
					8.2590977538167,
					8.2590977538167,
					17.637056274848,
					17.637056274848,
					32.965447423407,
					32.965447423407,
					79.94
				},
				ssr_surface_thickness_threshold = {
					[1.0] = 0.001,
					[2.0] = 5
				},
				skydome_tint_color = {
					1,
					1,
					1
				},
				skydome_fog_height_falloff = {
					[1.0] = 0,
					[2.0] = -50
				},
				bloom_threshold_offset_falloff = {
					0.01,
					1.9,
					1
				},
				secondary_sun_color = {
					1,
					1,
					1
				},
				vignette_color = {
					0,
					0,
					0
				},
				fog_depth_range = {
					[1.0] = 10,
					[2.0] = 100
				},
				skydome_cloud_speed_scale = {
					[1.0] = 0,
					[2.0] = 1
				},
				lens_quality_properties = {
					0,
					0,
					0
				},
				light_shaft_settings = {
					[1.0] = 1,
					[2.0] = 1
				},
				custom_fog_blend_color = {
					1,
					1,
					1
				},
				wind_amount = {
					0,
					0,
					0
				},
				local_shadow_map_bias = {
					0.0001,
					0.015,
					50
				},
				ambient_tint = {
					1,
					1,
					1
				},
				sun_direction = {
					0,
					0,
					-1
				},
				sun_color = {
					1,
					1,
					1
				},
				custom_fog_blend = {
					1,
					8,
					1
				},
				ssm_shadow_map_bias = {
					0.0005,
					0.0001,
					20
				},
				ssm_center = {
					0,
					0,
					0
				},
				ssm_near_far = {
					[1.0] = 0,
					[2.0] = 0
				},
				height_fog_offset_falloff = {
					[1.0] = 0,
					[2.0] = 500
				},
				fog_sun_blend = {
					1,
					8,
					1
				},
				secondary_sun_direction = {
					0,
					0,
					-1
				},
				fog_color = {
					0.6,
					0.6,
					0.6
				},
				eye_adaptation_speed_min_max = {
					1,
					0.01,
					30
				},
				secondary_sun_blend = {
					1,
					8,
					1
				},
				ambient_diffuse_fade = {
					0,
					0,
					10
				}
			},
			editor_variables = {
				sun_shadow_slice_depth_ranges = {
					0,
					80,
					0.4
				}
			},
			variable_weights = {
				motion_blur_amount = 0,
				height_fog_offset_falloff = 0,
				skydome_fog_height_falloff = 0,
				global_specular_map = 0,
				light_shaft_enabled = 0,
				secondary_sun_color = 0,
				global_roughness_multiplier = 0,
				ambient_diffuse_fade_type = 0,
				secondary_sun_direction = 0,
				dof_enabled = 1,
				custom_fog_blend_enabled = 0,
				skydome_cloud_speed_scale = 0,
				vignette_scale_falloff_opacity = 1,
				dof_focal_region_start = 1,
				skydome_u_offset = 0,
				dof_focal_region = 1,
				custom_fog_blend = 0,
				color_grading_map = 1,
				sun_shadows_enabled = 0,
				emissive_particle_intensity = 0,
				custom_fog_blend_direction = 0,
				dof_focal_region_end = 1,
				skydome_map = 0,
				vignette_color = 0,
				custom_fog_blend_color = 0,
				temporal_effects_enabled = 0,
				ssm_center = 0,
				fog_sun_blend = 0,
				fog_color = 0,
				dof_focal_distance = 1,
				secondary_sun_blend = 0,
				ambient_diffuse_fade = 0,
				global_diffuse_map = 0,
				exposure = 0,
				ssm_near_far = 0,
				ao_enabled = 0,
				ao_quality = 0,
				lens_quality_properties = 0,
				skydome_intensity = 0,
				ssr_enabled = 0,
				bloom_enabled = 0,
				ssr_ray_bending_enabled = 0,
				sun_color = 0,
				ao_intensity = 0,
				eye_intensity = 0,
				bloom_tint = 0,
				motion_blur_enabled = 0,
				light_shaft_weigth = 0,
				ssr_surface_thickness_threshold = 0,
				ssm_constant_update_enabled = 0,
				light_shaft_settings = 0,
				ao_radius = 0,
				lens_quality_enabled = 0,
				wind_amount = 0,
				sun_direction = 0,
				ssm_enabled = 0,
				ssm_radius = 0,
				bloom_threshold_offset_falloff = 1,
				sun_enabled = 0,
				fog_depth_range = 0,
				eye_adaptation_speed_min_max = 0,
				outline_enabled = 0,
				outline_thickness = 0,
				sun_shadow_slice_depth_ranges = 0,
				skydome_tint_color = 0,
				ssr_screen_edge_threshold = 0,
				offscreen_target_projection = 0,
				dof_focal_near_scale = 1,
				eye_adaptation_enabled = 0,
				bloom_lens_dirt_amount = 1,
				secondary_sun_enabled = 0,
				skydome_cloud_map = 0,
				global_lens_dirt_map = 0,
				dof_focal_far_scale = 1,
				fog_type = 0,
				ssm_rotation = 0
			}
		},
		heal_trait = {
			variables = {
				ssr_enabled = 0,
				dof_focal_region_start = 5,
				light_shaft_enabled = 1,
				global_roughness_multiplier = 1,
				dof_enabled = 0,
				sun_shadows_enabled = 1,
				custom_fog_blend_enabled = 0,
				motion_blur_amount = 2,
				dof_focal_region = 5,
				color_grading_map = "environment/textures/color_grading_identity",
				vignette_enabled = 1,
				emissive_particle_intensity = 1,
				ambient_diffuse_fade_type = 0,
				dof_focal_region_end = 5,
				skydome_map = "",
				temporal_effects_enabled = 1,
				global_diffuse_map = "",
				exposure = 0.25,
				global_specular_map = "",
				dof_focal_distance = 10,
				ao_enabled = 1,
				ao_quality = 2,
				skydome_intensity = 1.0959296482412,
				bloom_enabled = 1,
				ssr_ray_bending_enabled = 0,
				ao_intensity = 0.6,
				eye_intensity = 1,
				motion_blur_enabled = 0,
				light_shaft_weigth = 0.01,
				ssm_constant_update_enabled = 0,
				ao_radius = 0.2,
				lens_quality_enabled = 0,
				fog_enabled = 1,
				ssm_enabled = 0,
				ssm_radius = 200,
				sun_enabled = 1,
				outline_enabled = 1,
				skydome_u_offset = 0,
				ssr_screen_edge_threshold = 0.05,
				offscreen_target_projection = 0,
				dof_focal_near_scale = 1,
				eye_adaptation_enabled = 0,
				bloom_lens_dirt_amount = 1,
				secondary_sun_enabled = 0,
				skydome_cloud_map = "environment/textures/cloud_noclouds",
				global_lens_dirt_map = "environment/textures/lensdirt",
				dof_focal_far_scale = 1,
				fog_type = 0,
				ssm_rotation = 0,
				outline_thickness = {
					1,
					1,
					1,
					1
				},
				vignette_scale_falloff_opacity = {
					2.509,
					2.5,
					0
				},
				custom_fog_blend_direction = {
					0,
					0,
					-1
				},
				sun_shadow_map_bias = {
					0.0001,
					0.001,
					50
				},
				bloom_tint = {
					1,
					1,
					1
				},
				sun_shadow_slice_depth_ranges = {
					0,
					8.2590977538167,
					8.2590977538167,
					17.637056274848,
					17.637056274848,
					32.965447423407,
					32.965447423407,
					79.94
				},
				ssr_surface_thickness_threshold = {
					[1.0] = 0.001,
					[2.0] = 5
				},
				skydome_tint_color = {
					1,
					1,
					1
				},
				skydome_fog_height_falloff = {
					[1.0] = 0,
					[2.0] = -50
				},
				bloom_threshold_offset_falloff = {
					2,
					1.5,
					0.801
				},
				secondary_sun_color = {
					1,
					1,
					1
				},
				vignette_color = {
					0,
					0,
					0
				},
				fog_depth_range = {
					[1.0] = 10,
					[2.0] = 100
				},
				skydome_cloud_speed_scale = {
					[1.0] = 0,
					[2.0] = 1
				},
				lens_quality_properties = {
					0,
					0,
					0
				},
				light_shaft_settings = {
					[1.0] = 1,
					[2.0] = 1
				},
				custom_fog_blend_color = {
					1,
					1,
					1
				},
				wind_amount = {
					0,
					0,
					0
				},
				local_shadow_map_bias = {
					0.0001,
					0.015,
					50
				},
				ambient_tint = {
					1,
					1,
					1
				},
				sun_direction = {
					0,
					0,
					-1
				},
				sun_color = {
					1,
					1,
					1
				},
				custom_fog_blend = {
					1,
					8,
					1
				},
				ssm_shadow_map_bias = {
					0.0005,
					0.0001,
					20
				},
				ssm_center = {
					0,
					0,
					0
				},
				ssm_near_far = {
					[1.0] = 0,
					[2.0] = 0
				},
				height_fog_offset_falloff = {
					[1.0] = 0,
					[2.0] = 500
				},
				fog_sun_blend = {
					1,
					8,
					1
				},
				secondary_sun_direction = {
					0,
					0,
					-1
				},
				fog_color = {
					0.6,
					0.6,
					0.6
				},
				eye_adaptation_speed_min_max = {
					1,
					0.01,
					30
				},
				secondary_sun_blend = {
					1,
					8,
					1
				},
				ambient_diffuse_fade = {
					0,
					0,
					10
				}
			},
			editor_variables = {
				sun_shadow_slice_depth_ranges = {
					0,
					80,
					0.4
				}
			},
			variable_weights = {
				global_roughness_multiplier = 0,
				ssr_enabled = 0,
				skydome_fog_height_falloff = 0,
				motion_blur_amount = 0,
				light_shaft_enabled = 0,
				secondary_sun_color = 0,
				ambient_diffuse_fade_type = 0,
				ssm_center = 0,
				sun_shadows_enabled = 0,
				dof_enabled = 0,
				custom_fog_blend_enabled = 0,
				skydome_cloud_speed_scale = 0,
				vignette_scale_falloff_opacity = 1,
				dof_focal_region_start = 0,
				sun_shadow_map_bias = 0,
				dof_focal_region = 0,
				skydome_tint_color = 0,
				color_grading_map = 0,
				custom_fog_blend_direction = 0,
				emissive_particle_intensity = 0,
				vignette_enabled = 0,
				dof_focal_region_end = 0,
				skydome_map = 0,
				vignette_color = 0,
				custom_fog_blend_color = 0,
				temporal_effects_enabled = 0,
				ssm_near_far = 0,
				height_fog_offset_falloff = 0,
				fog_sun_blend = 0,
				secondary_sun_direction = 0,
				secondary_sun_blend = 0,
				fog_color = 0,
				global_diffuse_map = 0,
				exposure = 1,
				global_specular_map = 0,
				dof_focal_distance = 0,
				ambient_diffuse_fade = 0,
				ao_enabled = 0,
				ao_quality = 0,
				lens_quality_properties = 0,
				skydome_intensity = 0,
				custom_fog_blend = 0,
				bloom_enabled = 0,
				ssr_ray_bending_enabled = 0,
				sun_color = 0,
				ao_intensity = 0,
				eye_intensity = 0,
				bloom_tint = 0,
				motion_blur_enabled = 0,
				light_shaft_weigth = 0,
				ssr_surface_thickness_threshold = 0,
				ssm_shadow_map_bias = 0,
				ssm_constant_update_enabled = 0,
				light_shaft_settings = 0,
				ao_radius = 0,
				lens_quality_enabled = 0,
				fog_enabled = 0,
				wind_amount = 0,
				sun_direction = 0,
				ssm_enabled = 0,
				ssm_radius = 0,
				bloom_threshold_offset_falloff = 1,
				sun_enabled = 0,
				fog_depth_range = 0,
				eye_adaptation_speed_min_max = 0,
				outline_enabled = 0,
				outline_thickness = 0,
				sun_shadow_slice_depth_ranges = 0,
				skydome_u_offset = 0,
				ssr_screen_edge_threshold = 0,
				offscreen_target_projection = 0,
				dof_focal_near_scale = 0,
				eye_adaptation_enabled = 0,
				bloom_lens_dirt_amount = 0,
				secondary_sun_enabled = 0,
				skydome_cloud_map = 0,
				global_lens_dirt_map = 0,
				dof_focal_far_scale = 0,
				fog_type = 0,
				local_shadow_map_bias = 0,
				ssm_rotation = 0
			}
		},
		wounded = {
			variables = {
				ssr_enabled = 0,
				dof_focal_region_start = 5,
				light_shaft_enabled = 1,
				global_roughness_multiplier = 1,
				dof_enabled = 0,
				sun_shadows_enabled = 1,
				custom_fog_blend_enabled = 0,
				motion_blur_amount = 2,
				dof_focal_region = 5,
				color_grading_map = "environment/textures/color_grading_wounded",
				vignette_enabled = 1,
				emissive_particle_intensity = 1,
				ambient_diffuse_fade_type = 0,
				dof_focal_region_end = 5,
				skydome_map = "",
				temporal_effects_enabled = 1,
				global_diffuse_map = "",
				exposure = 4,
				global_specular_map = "",
				dof_focal_distance = 10,
				ao_enabled = 1,
				ao_quality = 2,
				skydome_intensity = 1,
				bloom_enabled = 1,
				ssr_ray_bending_enabled = 0,
				ao_intensity = 0.6,
				eye_intensity = 1,
				motion_blur_enabled = 0,
				light_shaft_weigth = 0.01,
				ssm_constant_update_enabled = 0,
				ao_radius = 0.2,
				lens_quality_enabled = 0,
				fog_enabled = 1,
				ssm_enabled = 0,
				ssm_radius = 200,
				sun_enabled = 1,
				outline_enabled = 1,
				skydome_u_offset = 0,
				ssr_screen_edge_threshold = 0.05,
				offscreen_target_projection = 0,
				dof_focal_near_scale = 1,
				eye_adaptation_enabled = 0,
				bloom_lens_dirt_amount = 1,
				secondary_sun_enabled = 0,
				skydome_cloud_map = "environment/textures/cloud_noclouds",
				global_lens_dirt_map = "environment/textures/lensdirt",
				dof_focal_far_scale = 1,
				fog_type = 0,
				ssm_rotation = 0,
				outline_thickness = {
					1,
					1,
					1,
					1
				},
				vignette_scale_falloff_opacity = {
					1.185,
					2.305,
					1
				},
				custom_fog_blend_direction = {
					0,
					0,
					-1
				},
				sun_shadow_map_bias = {
					0.0001,
					0.001,
					50
				},
				bloom_tint = {
					1,
					1,
					1
				},
				sun_shadow_slice_depth_ranges = {
					0,
					8.2590977538167,
					8.2590977538167,
					17.637056274848,
					17.637056274848,
					32.965447423407,
					32.965447423407,
					79.94
				},
				ssr_surface_thickness_threshold = {
					[1.0] = 0.001,
					[2.0] = 5
				},
				skydome_tint_color = {
					1,
					1,
					1
				},
				skydome_fog_height_falloff = {
					[1.0] = 0,
					[2.0] = -50
				},
				bloom_threshold_offset_falloff = {
					0.01,
					1.8,
					1
				},
				secondary_sun_color = {
					1,
					1,
					1
				},
				vignette_color = {
					1,
					0,
					0
				},
				fog_depth_range = {
					[1.0] = 10,
					[2.0] = 100
				},
				skydome_cloud_speed_scale = {
					[1.0] = 0,
					[2.0] = 1
				},
				lens_quality_properties = {
					0,
					0,
					0
				},
				light_shaft_settings = {
					[1.0] = 1,
					[2.0] = 1
				},
				custom_fog_blend_color = {
					1,
					1,
					1
				},
				wind_amount = {
					0,
					0,
					0
				},
				local_shadow_map_bias = {
					0.0001,
					0.015,
					50
				},
				ambient_tint = {
					1,
					1,
					1
				},
				sun_direction = {
					0,
					0,
					-1
				},
				sun_color = {
					1,
					1,
					1
				},
				custom_fog_blend = {
					1,
					8,
					1
				},
				ssm_shadow_map_bias = {
					0.0005,
					0.0001,
					20
				},
				ssm_center = {
					0,
					0,
					0
				},
				ssm_near_far = {
					[1.0] = 0,
					[2.0] = 0
				},
				height_fog_offset_falloff = {
					[1.0] = 0,
					[2.0] = 500
				},
				fog_sun_blend = {
					1,
					8,
					1
				},
				secondary_sun_direction = {
					0,
					0,
					-1
				},
				fog_color = {
					0.6,
					0.6,
					0.6
				},
				eye_adaptation_speed_min_max = {
					1,
					0.01,
					30
				},
				secondary_sun_blend = {
					1,
					8,
					1
				},
				ambient_diffuse_fade = {
					0,
					0,
					10
				}
			},
			editor_variables = {
				sun_shadow_slice_depth_ranges = {
					0,
					80,
					0.4
				}
			},
			variable_weights = {
				global_roughness_multiplier = 0,
				ssr_enabled = 0,
				skydome_fog_height_falloff = 0,
				motion_blur_amount = 0,
				light_shaft_enabled = 0,
				secondary_sun_color = 0,
				ambient_diffuse_fade_type = 0,
				ssm_center = 0,
				sun_shadows_enabled = 0,
				dof_enabled = 0,
				custom_fog_blend_enabled = 0,
				skydome_cloud_speed_scale = 0,
				vignette_scale_falloff_opacity = 1,
				dof_focal_region_start = 0,
				sun_shadow_map_bias = 0,
				dof_focal_region = 0,
				skydome_tint_color = 0,
				color_grading_map = 1,
				custom_fog_blend_direction = 0,
				emissive_particle_intensity = 0,
				vignette_enabled = 0,
				dof_focal_region_end = 0,
				skydome_map = 0,
				vignette_color = 0,
				custom_fog_blend_color = 0,
				temporal_effects_enabled = 0,
				ssm_near_far = 0,
				height_fog_offset_falloff = 0,
				fog_sun_blend = 0,
				secondary_sun_direction = 0,
				secondary_sun_blend = 0,
				fog_color = 0,
				global_diffuse_map = 0,
				exposure = 0,
				global_specular_map = 0,
				dof_focal_distance = 0,
				ambient_diffuse_fade = 0,
				ao_enabled = 0,
				ao_quality = 0,
				lens_quality_properties = 0,
				skydome_intensity = 0,
				custom_fog_blend = 0,
				bloom_enabled = 0,
				ssr_ray_bending_enabled = 0,
				sun_color = 0,
				ao_intensity = 0,
				eye_intensity = 0,
				bloom_tint = 0,
				motion_blur_enabled = 0,
				light_shaft_weigth = 0,
				ssr_surface_thickness_threshold = 0,
				ssm_shadow_map_bias = 0,
				ssm_constant_update_enabled = 0,
				light_shaft_settings = 0,
				ao_radius = 0,
				lens_quality_enabled = 0,
				fog_enabled = 0,
				wind_amount = 0,
				sun_direction = 0,
				ssm_enabled = 0,
				ssm_radius = 0,
				bloom_threshold_offset_falloff = 0,
				sun_enabled = 0,
				fog_depth_range = 0,
				eye_adaptation_speed_min_max = 0,
				outline_enabled = 0,
				outline_thickness = 0,
				sun_shadow_slice_depth_ranges = 0,
				skydome_u_offset = 0,
				ssr_screen_edge_threshold = 0,
				offscreen_target_projection = 0,
				dof_focal_near_scale = 0,
				eye_adaptation_enabled = 0,
				bloom_lens_dirt_amount = 0,
				secondary_sun_enabled = 0,
				skydome_cloud_map = 0,
				global_lens_dirt_map = 0,
				dof_focal_far_scale = 0,
				fog_type = 0,
				local_shadow_map_bias = 0,
				ssm_rotation = 0
			}
		}
	}
}
