return {
	template = "core/stingray_renderer/environments/outdoor.shading_environment_template",
	settings = {
		heal_medikit = {
			variables = {
				global_roughness_multiplier = 1,
				light_shaft_enabled = 1,
				dof_focal_region_start = 5,
				motion_blur_amount = 2,
				sun_shadows_enabled = 1,
				skydome_u_offset = 0,
				ambient_diffuse_fade_type = 0,
				dof_focal_region = 5,
				ao_radius = 0.2,
				color_grading_map = "",
				emissive_particle_intensity = 1,
				dof_focal_region_end = 5,
				skydome_map = "",
				dof_focal_distance = 10,
				global_diffuse_map = "",
				exposure = 0.65,
				global_specular_map = "",
				ao_enabled = 1,
				ao_quality = 2,
				skydome_intensity = 1.0959296482412,
				ssr_enabled = 0,
				bloom_enabled = 1,
				ssr_ray_bending_enabled = 0,
				ao_intensity = 0.6,
				vignette_enabled = 1,
				motion_blur_enabled = 0,
				ssm_constant_update_enabled = 0,
				custom_fog_blend_enabled = 0,
				lens_quality_enabled = 0,
				fog_enabled = 1,
				dof_enabled = 0,
				ambient_intensity = 4,
				ssm_enabled = 0,
				ssm_radius = 200,
				sun_enabled = 1,
				outline_enabled = 1,
				ssr_screen_edge_threshold = 0.05,
				dof_focal_near_scale = 1,
				eye_adaptation_enabled = 0,
				bloom_lens_dirt_amount = 1,
				secondary_sun_enabled = 0,
				skydome_cloud_map = "",
				global_lens_dirt_map = "",
				dof_focal_far_scale = 1,
				fog_type = 0,
				ssm_rotation = 0,
				ssr_dangerous_reflection_angle = {
					[1.0] = 0.01,
					[2.0] = 0.01
				},
				vignette_scale_falloff_opacity = {
					2.509,
					2.5,
					0
				},
				ssm_center = {
					0,
					0,
					0
				},
				baked_diffuse_tint = {
					4,
					4,
					4
				},
				bloom_tint = {
					1,
					1,
					1
				},
				ssr_angle_facing_camera_threshold = {
					[1.0] = 1,
					[2.0] = 1
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
					1,
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
				custom_fog_blend_direction = {
					0,
					0,
					-1
				},
				ssr_up_normal_threshold = {
					[1.0] = 0,
					[2.0] = 1
				},
				fog_color = {
					0.6,
					0.6,
					0.6
				},
				ambient_tint = {
					1,
					1,
					1
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
				reflections_tint = {
					4,
					4,
					4
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
				ambient_diffuse_fade_type = 0,
				skydome_fog_height_falloff = 0,
				custom_fog_blend = 0,
				light_shaft_enabled = 0,
				global_specular_map = 0,
				custom_fog_blend_color = 0,
				dof_focal_region_start = 0,
				sun_shadows_enabled = 0,
				secondary_sun_color = 0,
				ssm_center = 0,
				fog_color = 0,
				skydome_u_offset = 0,
				baked_diffuse_tint = 0,
				vignette_scale_falloff_opacity = 1,
				dof_focal_region = 0,
				sun_shadow_slice_depth_ranges = 0,
				color_grading_map = 0,
				ao_radius = 0,
				emissive_particle_intensity = 0,
				skydome_cloud_speed_scale = 0,
				dof_focal_region_end = 0,
				skydome_map = 0,
				vignette_color = 0,
				custom_fog_blend_direction = 0,
				motion_blur_amount = 0,
				fog_sun_blend = 0,
				secondary_sun_direction = 0,
				reflections_tint = 0,
				dof_focal_distance = 0,
				secondary_sun_blend = 0,
				ambient_diffuse_fade = 0,
				global_diffuse_map = 0,
				exposure = 1,
				ssm_near_far = 0,
				ao_enabled = 0,
				ssr_angle_facing_camera_threshold = 0,
				ao_quality = 0,
				lens_quality_properties = 0,
				skydome_intensity = 0,
				ssr_enabled = 0,
				bloom_enabled = 0,
				height_fog_offset_falloff = 0,
				sun_color = 0,
				ao_intensity = 0,
				vignette_enabled = 0,
				bloom_tint = 0,
				motion_blur_enabled = 0,
				ssr_dangerous_reflection_angle = 0,
				ssr_surface_thickness_threshold = 0,
				ssm_constant_update_enabled = 0,
				light_shaft_settings = 0,
				custom_fog_blend_enabled = 0,
				lens_quality_enabled = 0,
				fog_enabled = 0,
				dof_enabled = 0,
				ambient_intensity = 0,
				sun_direction = 0,
				ssm_enabled = 0,
				ssm_radius = 0,
				bloom_threshold_offset_falloff = 1,
				sun_enabled = 0,
				fog_depth_range = 0,
				eye_adaptation_speed_min_max = 0,
				outline_enabled = 1,
				ssr_up_normal_threshold = 0,
				skydome_tint_color = 0,
				ssr_screen_edge_threshold = 0,
				dof_focal_near_scale = 0,
				eye_adaptation_enabled = 0,
				bloom_lens_dirt_amount = 0,
				secondary_sun_enabled = 0,
				skydome_cloud_map = 0,
				global_lens_dirt_map = 0,
				dof_focal_far_scale = 0,
				fog_type = 0,
				ssm_rotation = 0
			}
		},
		default = {
			variables = {
				csm_enabled = 1,
				dof_focal_region_start = 5,
				ssao_max_disstance = 5,
				light_shaft_falloff = 1,
				cloud_intensity = 0.5,
				custom_fog_blend_enabled = 0,
				cloud_color_blend = 0.5,
				global_roughness_multiplier = 1,
				cloud_shadow_map = "",
				vignette_enabled = 1,
				ao_radius = 1,
				skydome_z_offset_multiply = 0,
				skydome_u_offset = 0,
				ssao_strength = 1,
				outline_multiplier_blue = 1,
				ssm_radius = 200,
				focal_length = 0.002,
				global_diffuse_map = "environment/textures/moods_diffuse_cubemap",
				depth_blur_amount = 0,
				ambient_diffuse_fade_type = 2,
				ambient_specular_intensity = 3,
				outline_multiplier_alpha = 1,
				sun_shadows_enabled = 1,
				emissive_material_intensity = 1,
				skydome_intensity = 1,
				outline_multiplier_green = 1,
				ao_num_samples = 5,
				focal_distance = 5,
				ambient_diffuse_intensity = 3,
				motion_blur_amount = 0.4,
				exposure = 0.2,
				dof_focal_distance = 0,
				ssr_ray_bending_enabled = 0,
				skydome_z_offset_add = 0,
				bloom_enabled = 1,
				ssm_constant_update_enabled = 0,
				skydome = "units/textures/g/generic_texture_grey",
				ambient_intensity = 3.7494360902256,
				ssm_enabled = 0,
				sun_enabled = 1,
				outline_multiplier = 1,
				skydome_fog_height = 0.97,
				environment_roughness_multiplier = 1,
				ambient_camera_falloff = 0.4,
				outline_multiplier_red = 1,
				highlight_multiplier = 1,
				eye_adaptation_enabled = 1,
				lens_dirt_map = "units/textures/g/generic_texture_grey",
				bloom_lens_dirt_amount = 1,
				dof_focal_far_scale = 0.273,
				fog_type = 1,
				light_shaft_enabled = 1,
				dof_focal_region = 24.39,
				color_grading_map = "environment/textures/color_grading_identity",
				emissive_particle_intensity = 1,
				dof_focal_region_end = 158.54,
				skydome_map = "units/textures/g/generic_texture_grey",
				global_specular_map = "environment/textures/moods_specular_cubemap",
				cube_environment_intensity_sun = 0.2,
				ao_enabled = 1,
				cube_environment_intensity_shadow = 0.2,
				ao_quality = 1,
				ssr_enabled = 0,
				ao_intensity = 0.25,
				motion_blur_enabled = 1,
				sun_ao_strength = 0.5,
				lens_quality_enabled = 0,
				fog_enabled = 1,
				dof_enabled = 0,
				dof_amount = 0.8,
				outline_enabled = 1,
				ssao_radius = 0.5,
				cube_environment_intensity = 1,
				ssr_screen_edge_threshold = 0.05,
				dof_sky_blur_factor = 0.1,
				dof_focal_near_scale = 1,
				bloom_exposure = 0.5,
				secondary_sun_enabled = 0,
				skydome_cloud_map = "units/textures/g/generic_texture_grey",
				global_lens_dirt_map = "units/textures/g/generic_texture_grey",
				ssm_rotation = 0,
				sky_color = {
					0.37801646474837,
					0.38316027489944,
					0.38712529522423
				},
				heatmap_world_extents = {
					[1.0] = 1000,
					[2.0] = 1000
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
				bloom_threshold_offset = {
					[1.0] = 1.333,
					[2.0] = 1.668
				},
				ambient_bottom_color = {
					0.0073529411764706,
					0.0065285975982088,
					0.005795847750865
				},
				custom_fog_blend_direction = {
					0.91508618606599,
					-0.40325831928332,
					0
				},
				diffusion_particles = {
					0.001,
					0,
					1.13
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
				ambient_color = {
					0.038694994291025,
					0.038694994291025,
					0.038694994291025
				},
				rim_tint = {
					1,
					1,
					1
				},
				ssr_angle_facing_camera_threshold = {
					[1.0] = 1,
					[2.0] = 1
				},
				ssr_surface_thickness_threshold = {
					[1.0] = 0.001,
					[2.0] = 5
				},
				cloud_scale = {
					[1.0] = 1,
					[2.0] = 1
				},
				ambient_tint = {
					1,
					1,
					1
				},
				lens_quality_properties = {
					0,
					0,
					0
				},
				light_shaft_settings = {
					[1.0] = 4.5665707676919,
					[2.0] = 0.635
				},
				highlight_intensity = {
					[1.0] = 0.05,
					[2.0] = 0.3
				},
				ssr_up_normal_threshold = {
					[1.0] = 0,
					[2.0] = 1
				},
				ssm_near_far = {
					[1.0] = 0,
					[2.0] = 0
				},
				bright_pass_settings = {
					[1.0] = 0.01,
					[2.0] = 1
				},
				lens_dirt_settings = {
					0.001,
					40,
					1.41
				},
				ambient_diffuse_fade = {
					0.5,
					0.488,
					8.727
				},
				outline_color = {
					1,
					1,
					0.3
				},
				vignette_scale_falloff_opacity = {
					5,
					5,
					0.5
				},
				baked_diffuse_tint = {
					0.25,
					0.25,
					0.25
				},
				skydome_tint_color = {
					0,
					0,
					0
				},
				sun_color = {
					0.125,
					0.125,
					0.125
				},
				outline_color_blue = {
					1,
					1,
					0.3
				},
				bloom_threshold_offset_falloff = {
					3,
					1.8,
					1
				},
				vignette_color = {
					0,
					0,
					0
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
				sun_direction = {
					-0.29576294600103,
					0.09858764866701,
					-0.95016038398951
				},
				fog_depth_range = {
					[1.0] = 5,
					[2.0] = 292.68
				},
				secondary_sun_direction = {
					-0.722628794866,
					0.55745649889663,
					-0.40871735547737
				},
				skydome_cloud_speed_scale = {
					[1.0] = 0.6,
					[2.0] = 0.25
				},
				outline_color_green = {
					1,
					1,
					0.3
				},
				ssr_dangerous_reflection_angle = {
					[1.0] = 0.01,
					[2.0] = 0.01
				},
				eye_adaptation_speed_min_max = {
					1,
					0.01,
					30
				},
				heatmap_world_position = {
					[1.0] = -500,
					[2.0] = -500
				},
				ambient_top_color = {
					0.041561694367701,
					0.048818160698908,
					0.051199188713835
				},
				dof_far_setting = {
					[1.0] = 25,
					[2.0] = 1000
				},
				ssm_center = {
					0,
					0,
					0
				},
				highlight_color = {
					1,
					1,
					0.3
				},
				height_fog_offset_falloff = {
					[1.0] = -375.61,
					[2.0] = 1780.5523560976
				},
				secondary_sun_blend = {
					1,
					8,
					1
				},
				skydome_fog_height_falloff = {
					[1.0] = 0.088,
					[2.0] = -2.93
				},
				custom_fog_blend = {
					1,
					8,
					1
				},
				outline_color_red = {
					1,
					1,
					0.3
				},
				dof_near_setting = {
					[1.0] = 0.3,
					[2.0] = 1
				},
				cloud_shadow_settings = {
					-5,
					-5,
					80
				},
				secondary_sun_color = {
					1,
					1,
					1
				},
				reflections_tint = {
					0.25,
					0.25,
					0.25
				},
				fog_color = {
					0.040441176470588,
					0.047707612456747,
					0.0625
				},
				outline_color_alpha = {
					1,
					1,
					0.3
				},
				depth_blur_setting = {
					[1.0] = 32,
					[2.0] = 10
				},
				fog_sun_blend = {
					0.195,
					4.15,
					0.668
				},
				luminance_adaption = {
					1,
					0.04,
					1
				},
				custom_fog_blend_color = {
					0,
					0,
					0
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
				outline_color_alpha = 0,
				exposure = 1,
				color_grading_map = 1,
				outline_multiplier_red = 0,
				luminance_adaption = 1,
				outline_color_red = 0,
				outline_multiplier_alpha = 0,
				skydome = 1,
				outline_color_blue = 0,
				outline_multiplier_blue = 0,
				outline_color_green = 0,
				highlight_multiplier = 0,
				highlight_color = 0,
				skydome_intensity = 1,
				outline_multiplier_green = 0
			}
		},
		knocked_down = {
			variables = {
				global_roughness_multiplier = 1,
				light_shaft_enabled = 1,
				dof_focal_region_start = 5,
				motion_blur_amount = 2,
				sun_shadows_enabled = 1,
				skydome_u_offset = 0,
				ambient_diffuse_fade_type = 0,
				dof_focal_region = 15,
				ao_radius = 0.2,
				color_grading_map = "environment/textures/color_grading_knocked_down",
				emissive_particle_intensity = 1,
				dof_focal_region_end = 10,
				skydome_map = "",
				dof_focal_distance = 5,
				global_diffuse_map = "",
				exposure = 1,
				global_specular_map = "",
				ao_enabled = 1,
				ao_quality = 2,
				skydome_intensity = 1,
				ssr_enabled = 0,
				bloom_enabled = 1,
				ssr_ray_bending_enabled = 0,
				ao_intensity = 0.6,
				vignette_enabled = 1,
				motion_blur_enabled = 0,
				ssm_constant_update_enabled = 0,
				custom_fog_blend_enabled = 0,
				lens_quality_enabled = 0,
				fog_enabled = 1,
				dof_enabled = 1,
				ambient_intensity = 4,
				ssm_enabled = 0,
				ssm_radius = 200,
				sun_enabled = 1,
				outline_enabled = 1,
				ssr_screen_edge_threshold = 0.05,
				dof_focal_near_scale = 0.288,
				eye_adaptation_enabled = 0,
				bloom_lens_dirt_amount = 1,
				secondary_sun_enabled = 0,
				skydome_cloud_map = "",
				global_lens_dirt_map = "",
				dof_focal_far_scale = 1,
				fog_type = 0,
				ssm_rotation = 0,
				ssr_dangerous_reflection_angle = {
					[1.0] = 0.01,
					[2.0] = 0.01
				},
				vignette_scale_falloff_opacity = {
					3.659,
					5.509,
					0.107
				},
				ssm_center = {
					0,
					0,
					0
				},
				baked_diffuse_tint = {
					4,
					4,
					4
				},
				bloom_tint = {
					1,
					1,
					1
				},
				ssr_angle_facing_camera_threshold = {
					[1.0] = 1,
					[2.0] = 1
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
				custom_fog_blend_direction = {
					0,
					0,
					-1
				},
				ssr_up_normal_threshold = {
					[1.0] = 0,
					[2.0] = 1
				},
				fog_color = {
					0.0625,
					0.041421568627451,
					0.041421568627451
				},
				ambient_tint = {
					1,
					1,
					1
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
				reflections_tint = {
					4,
					4,
					4
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
				sun_shadow_slice_depth_ranges = 0,
				global_specular_map = 0,
				skydome_fog_height_falloff = 0,
				ssm_enabled = 0,
				light_shaft_enabled = 0,
				bloom_threshold_offset_falloff = 1,
				sun_direction = 0,
				global_roughness_multiplier = 0,
				secondary_sun_direction = 0,
				skydome_cloud_speed_scale = 0,
				skydome_u_offset = 0,
				fog_color = 1,
				custom_fog_blend_enabled = 0,
				vignette_scale_falloff_opacity = 1,
				custom_fog_blend_direction = 0,
				dof_focal_region = 1,
				custom_fog_blend = 0,
				color_grading_map = 1,
				secondary_sun_color = 0,
				emissive_particle_intensity = 0,
				sun_shadows_enabled = 0,
				dof_focal_region_end = 1,
				skydome_map = 0,
				vignette_color = 0,
				custom_fog_blend_color = 0,
				dof_focal_distance = 1,
				ambient_diffuse_fade = 0,
				secondary_sun_blend = 0,
				global_diffuse_map = 0,
				exposure = 0,
				ssm_near_far = 0,
				ao_enabled = 0,
				ssr_angle_facing_camera_threshold = 0,
				ao_quality = 0,
				lens_quality_properties = 0,
				skydome_intensity = 0,
				ssr_enabled = 0,
				bloom_enabled = 0,
				height_fog_offset_falloff = 0,
				sun_color = 0,
				ao_intensity = 0,
				motion_blur_amount = 0,
				bloom_tint = 0,
				motion_blur_enabled = 0,
				ssr_dangerous_reflection_angle = 0,
				ssr_surface_thickness_threshold = 0,
				ssm_constant_update_enabled = 0,
				light_shaft_settings = 0,
				ao_radius = 0,
				lens_quality_enabled = 0,
				dof_enabled = 1,
				ambient_intensity = 0,
				ssm_center = 0,
				ambient_diffuse_fade_type = 0,
				ssm_radius = 0,
				fog_sun_blend = 0,
				sun_enabled = 0,
				fog_depth_range = 1,
				eye_adaptation_speed_min_max = 0,
				dof_focal_region_start = 1,
				ssr_up_normal_threshold = 0,
				skydome_tint_color = 0,
				ssr_screen_edge_threshold = 0,
				dof_focal_near_scale = 1,
				eye_adaptation_enabled = 0,
				bloom_lens_dirt_amount = 0,
				secondary_sun_enabled = 0,
				skydome_cloud_map = 0,
				global_lens_dirt_map = 0,
				dof_focal_far_scale = 1,
				fog_type = 0,
				ssm_rotation = 0
			}
		},
		bleeding_out = {
			variables = {
				global_roughness_multiplier = 1,
				light_shaft_enabled = 1,
				dof_focal_region_start = 5,
				motion_blur_amount = 2,
				sun_shadows_enabled = 1,
				skydome_u_offset = 0,
				ambient_diffuse_fade_type = 0,
				dof_focal_region = 5,
				ao_radius = 0.2,
				color_grading_map = "environment/textures/color_grading_bleeding_out",
				emissive_particle_intensity = 1,
				dof_focal_region_end = 5,
				skydome_map = "",
				dof_focal_distance = 10,
				global_diffuse_map = "",
				exposure = 4,
				global_specular_map = "",
				ao_enabled = 1,
				ao_quality = 2,
				skydome_intensity = 1,
				ssr_enabled = 0,
				bloom_enabled = 1,
				ssr_ray_bending_enabled = 0,
				ao_intensity = 0.6,
				vignette_enabled = 0,
				motion_blur_enabled = 0,
				ssm_constant_update_enabled = 0,
				custom_fog_blend_enabled = 0,
				lens_quality_enabled = 0,
				fog_enabled = 1,
				dof_enabled = 1,
				ambient_intensity = 1,
				ssm_enabled = 0,
				ssm_radius = 200,
				sun_enabled = 1,
				outline_enabled = 1,
				ssr_screen_edge_threshold = 0.05,
				dof_focal_near_scale = 1,
				eye_adaptation_enabled = 0,
				bloom_lens_dirt_amount = 1,
				secondary_sun_enabled = 0,
				skydome_cloud_map = "",
				global_lens_dirt_map = "",
				dof_focal_far_scale = 1,
				fog_type = 0,
				ssm_rotation = 0,
				ssr_dangerous_reflection_angle = {
					[1.0] = 0.01,
					[2.0] = 0.01
				},
				vignette_scale_falloff_opacity = {
					1.185,
					2.305,
					1
				},
				ssm_center = {
					0,
					0,
					0
				},
				baked_diffuse_tint = {
					1,
					1,
					1
				},
				bloom_tint = {
					1,
					1,
					1
				},
				ssr_angle_facing_camera_threshold = {
					[1.0] = 1,
					[2.0] = 1
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
				custom_fog_blend_direction = {
					0,
					0,
					-1
				},
				ssr_up_normal_threshold = {
					[1.0] = 0,
					[2.0] = 1
				},
				fog_color = {
					0,
					1.990717618533,
					0.70260621830576
				},
				ambient_tint = {
					1,
					1,
					1
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
				reflections_tint = {
					1,
					1,
					1
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
				ambient_diffuse_fade_type = 0,
				skydome_fog_height_falloff = 0,
				custom_fog_blend = 0,
				light_shaft_enabled = 0,
				global_specular_map = 0,
				custom_fog_blend_color = 0,
				dof_focal_region_start = 0,
				sun_shadows_enabled = 0,
				secondary_sun_color = 0,
				ssm_center = 0,
				fog_color = 0,
				skydome_u_offset = 0,
				baked_diffuse_tint = 0,
				vignette_scale_falloff_opacity = 0,
				dof_focal_region = 0,
				sun_shadow_slice_depth_ranges = 0,
				color_grading_map = 1,
				ao_radius = 0,
				emissive_particle_intensity = 0,
				skydome_cloud_speed_scale = 0,
				dof_focal_region_end = 0,
				skydome_map = 0,
				vignette_color = 1,
				custom_fog_blend_direction = 0,
				motion_blur_amount = 0,
				fog_sun_blend = 0,
				secondary_sun_direction = 0,
				reflections_tint = 0,
				dof_focal_distance = 0,
				secondary_sun_blend = 0,
				ambient_diffuse_fade = 0,
				global_diffuse_map = 0,
				exposure = 0,
				ssm_near_far = 0,
				ao_enabled = 0,
				ssr_angle_facing_camera_threshold = 0,
				ao_quality = 0,
				lens_quality_properties = 0,
				skydome_intensity = 0,
				ssr_enabled = 0,
				bloom_enabled = 0,
				height_fog_offset_falloff = 0,
				sun_color = 0,
				ao_intensity = 0,
				vignette_enabled = 0,
				bloom_tint = 0,
				motion_blur_enabled = 0,
				ssr_dangerous_reflection_angle = 0,
				ssr_surface_thickness_threshold = 0,
				ssm_constant_update_enabled = 0,
				light_shaft_settings = 0,
				custom_fog_blend_enabled = 0,
				lens_quality_enabled = 0,
				fog_enabled = 0,
				dof_enabled = 0,
				ambient_intensity = 0,
				sun_direction = 0,
				ssm_enabled = 0,
				ssm_radius = 0,
				bloom_threshold_offset_falloff = 0,
				sun_enabled = 0,
				fog_depth_range = 0,
				eye_adaptation_speed_min_max = 0,
				outline_enabled = 1,
				ssr_up_normal_threshold = 0,
				skydome_tint_color = 0,
				ssr_screen_edge_threshold = 0,
				dof_focal_near_scale = 0,
				eye_adaptation_enabled = 0,
				bloom_lens_dirt_amount = 0,
				secondary_sun_enabled = 0,
				skydome_cloud_map = 0,
				global_lens_dirt_map = 0,
				dof_focal_far_scale = 0,
				fog_type = 0,
				ssm_rotation = 0
			}
		},
		menu = {
			variables = {
				global_roughness_multiplier = 1,
				light_shaft_enabled = 1,
				dof_focal_region_start = 3,
				motion_blur_amount = 2,
				sun_shadows_enabled = 1,
				skydome_u_offset = 0,
				ambient_diffuse_fade_type = 0,
				dof_focal_region = 3,
				ao_radius = 0.2,
				color_grading_map = "environment/textures/color_grading_ingame_menu",
				emissive_particle_intensity = 1,
				dof_focal_region_end = 3,
				skydome_map = "",
				dof_focal_distance = 5,
				global_diffuse_map = "",
				exposure = 2.246052631579,
				global_specular_map = "",
				ao_enabled = 1,
				ao_quality = 2,
				skydome_intensity = 1,
				ssr_enabled = 0,
				bloom_enabled = 1,
				ssr_ray_bending_enabled = 0,
				ao_intensity = 0.6,
				vignette_enabled = 1,
				motion_blur_enabled = 0,
				ssm_constant_update_enabled = 0,
				custom_fog_blend_enabled = 0,
				lens_quality_enabled = 0,
				fog_enabled = 1,
				dof_enabled = 1,
				ambient_intensity = 1.6647443609023,
				ssm_enabled = 1,
				ssm_radius = 200,
				sun_enabled = 1,
				outline_enabled = 1,
				ssr_screen_edge_threshold = 0.05,
				dof_focal_near_scale = 1,
				eye_adaptation_enabled = 0,
				bloom_lens_dirt_amount = 1,
				secondary_sun_enabled = 0,
				skydome_cloud_map = "",
				global_lens_dirt_map = "",
				dof_focal_far_scale = 1,
				fog_type = 0,
				ssm_rotation = 0,
				ssr_dangerous_reflection_angle = {
					[1.0] = 0.01,
					[2.0] = 0.01
				},
				vignette_scale_falloff_opacity = {
					3.512,
					4.688,
					0.615
				},
				ssm_center = {
					0,
					0,
					0
				},
				baked_diffuse_tint = {
					1.6647443609023,
					1.6647443609023,
					1.6647443609023
				},
				bloom_tint = {
					1,
					1,
					1
				},
				ssr_angle_facing_camera_threshold = {
					[1.0] = 1,
					[2.0] = 1
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
				custom_fog_blend_direction = {
					0,
					0,
					-1
				},
				ssr_up_normal_threshold = {
					[1.0] = 0,
					[2.0] = 1
				},
				fog_color = {
					0.6,
					0.6,
					0.6
				},
				ambient_tint = {
					1,
					1,
					1
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
				reflections_tint = {
					1.6647443609023,
					1.6647443609023,
					1.6647443609023
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
				sun_shadow_slice_depth_ranges = 0,
				global_specular_map = 0,
				skydome_fog_height_falloff = 0,
				ssm_enabled = 0,
				light_shaft_enabled = 0,
				bloom_threshold_offset_falloff = 1,
				sun_direction = 0,
				global_roughness_multiplier = 0,
				secondary_sun_direction = 0,
				skydome_cloud_speed_scale = 0,
				skydome_u_offset = 0,
				fog_color = 0,
				custom_fog_blend_enabled = 0,
				vignette_scale_falloff_opacity = 1,
				custom_fog_blend_direction = 0,
				dof_focal_region = 1,
				custom_fog_blend = 0,
				color_grading_map = 1,
				secondary_sun_color = 0,
				emissive_particle_intensity = 0,
				sun_shadows_enabled = 0,
				dof_focal_region_end = 1,
				skydome_map = 0,
				vignette_color = 0,
				custom_fog_blend_color = 0,
				dof_focal_distance = 1,
				ambient_diffuse_fade = 0,
				secondary_sun_blend = 0,
				global_diffuse_map = 0,
				exposure = 0,
				ssm_near_far = 0,
				ao_enabled = 0,
				ssr_angle_facing_camera_threshold = 0,
				ao_quality = 0,
				lens_quality_properties = 0,
				skydome_intensity = 0,
				ssr_enabled = 0,
				bloom_enabled = 0,
				height_fog_offset_falloff = 0,
				sun_color = 0,
				ao_intensity = 0,
				motion_blur_amount = 0,
				bloom_tint = 0,
				motion_blur_enabled = 0,
				ssr_dangerous_reflection_angle = 0,
				ssr_surface_thickness_threshold = 0,
				ssm_constant_update_enabled = 0,
				light_shaft_settings = 0,
				ao_radius = 0,
				lens_quality_enabled = 0,
				dof_enabled = 1,
				ambient_intensity = 0,
				ssm_center = 0,
				ambient_diffuse_fade_type = 0,
				ssm_radius = 0,
				fog_sun_blend = 0,
				sun_enabled = 0,
				fog_depth_range = 0,
				eye_adaptation_speed_min_max = 0,
				dof_focal_region_start = 1,
				ssr_up_normal_threshold = 0,
				skydome_tint_color = 0,
				ssr_screen_edge_threshold = 0,
				dof_focal_near_scale = 1,
				eye_adaptation_enabled = 0,
				bloom_lens_dirt_amount = 0,
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
				global_roughness_multiplier = 1,
				light_shaft_enabled = 1,
				dof_focal_region_start = 5,
				motion_blur_amount = 2,
				sun_shadows_enabled = 1,
				skydome_u_offset = 0,
				ambient_diffuse_fade_type = 0,
				dof_focal_region = 5,
				ao_radius = 0.2,
				color_grading_map = "",
				emissive_particle_intensity = 1,
				dof_focal_region_end = 5,
				skydome_map = "",
				dof_focal_distance = 10,
				global_diffuse_map = "",
				exposure = 0.65,
				global_specular_map = "",
				ao_enabled = 1,
				ao_quality = 2,
				skydome_intensity = 1.0959296482412,
				ssr_enabled = 0,
				bloom_enabled = 1,
				ssr_ray_bending_enabled = 0,
				ao_intensity = 0.6,
				vignette_enabled = 1,
				motion_blur_enabled = 0,
				ssm_constant_update_enabled = 0,
				custom_fog_blend_enabled = 0,
				lens_quality_enabled = 0,
				fog_enabled = 1,
				dof_enabled = 0,
				ambient_intensity = 4,
				ssm_enabled = 0,
				ssm_radius = 200,
				sun_enabled = 1,
				outline_enabled = 1,
				ssr_screen_edge_threshold = 0.05,
				dof_focal_near_scale = 1,
				eye_adaptation_enabled = 0,
				bloom_lens_dirt_amount = 1,
				secondary_sun_enabled = 0,
				skydome_cloud_map = "",
				global_lens_dirt_map = "",
				dof_focal_far_scale = 1,
				fog_type = 0,
				ssm_rotation = 0,
				ssr_dangerous_reflection_angle = {
					[1.0] = 0.01,
					[2.0] = 0.01
				},
				vignette_scale_falloff_opacity = {
					2.509,
					2.5,
					0
				},
				ssm_center = {
					0,
					0,
					0
				},
				baked_diffuse_tint = {
					4,
					4,
					4
				},
				bloom_tint = {
					1,
					1,
					1
				},
				ssr_angle_facing_camera_threshold = {
					[1.0] = 1,
					[2.0] = 1
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
					1,
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
				custom_fog_blend_direction = {
					0,
					0,
					-1
				},
				ssr_up_normal_threshold = {
					[1.0] = 0,
					[2.0] = 1
				},
				fog_color = {
					0.6,
					0.6,
					0.6
				},
				ambient_tint = {
					1,
					1,
					1
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
				reflections_tint = {
					4,
					4,
					4
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
				ambient_diffuse_fade_type = 0,
				skydome_fog_height_falloff = 0,
				custom_fog_blend = 0,
				light_shaft_enabled = 0,
				global_specular_map = 0,
				custom_fog_blend_color = 0,
				dof_focal_region_start = 0,
				sun_shadows_enabled = 0,
				secondary_sun_color = 0,
				ssm_center = 0,
				fog_color = 0,
				skydome_u_offset = 0,
				baked_diffuse_tint = 0,
				vignette_scale_falloff_opacity = 1,
				dof_focal_region = 0,
				sun_shadow_slice_depth_ranges = 0,
				color_grading_map = 0,
				ao_radius = 0,
				emissive_particle_intensity = 0,
				skydome_cloud_speed_scale = 0,
				dof_focal_region_end = 0,
				skydome_map = 0,
				vignette_color = 0,
				custom_fog_blend_direction = 0,
				motion_blur_amount = 0,
				fog_sun_blend = 0,
				secondary_sun_direction = 0,
				reflections_tint = 0,
				dof_focal_distance = 0,
				secondary_sun_blend = 0,
				ambient_diffuse_fade = 0,
				global_diffuse_map = 0,
				exposure = 1,
				ssm_near_far = 0,
				ao_enabled = 0,
				ssr_angle_facing_camera_threshold = 0,
				ao_quality = 0,
				lens_quality_properties = 0,
				skydome_intensity = 0,
				ssr_enabled = 0,
				bloom_enabled = 0,
				height_fog_offset_falloff = 0,
				sun_color = 0,
				ao_intensity = 0,
				vignette_enabled = 0,
				bloom_tint = 0,
				motion_blur_enabled = 0,
				ssr_dangerous_reflection_angle = 0,
				ssr_surface_thickness_threshold = 0,
				ssm_constant_update_enabled = 0,
				light_shaft_settings = 0,
				custom_fog_blend_enabled = 0,
				lens_quality_enabled = 0,
				fog_enabled = 0,
				dof_enabled = 0,
				ambient_intensity = 0,
				sun_direction = 0,
				ssm_enabled = 0,
				ssm_radius = 0,
				bloom_threshold_offset_falloff = 1,
				sun_enabled = 0,
				fog_depth_range = 0,
				eye_adaptation_speed_min_max = 0,
				outline_enabled = 1,
				ssr_up_normal_threshold = 0,
				skydome_tint_color = 0,
				ssr_screen_edge_threshold = 0,
				dof_focal_near_scale = 0,
				eye_adaptation_enabled = 0,
				bloom_lens_dirt_amount = 0,
				secondary_sun_enabled = 0,
				skydome_cloud_map = 0,
				global_lens_dirt_map = 0,
				dof_focal_far_scale = 0,
				fog_type = 0,
				ssm_rotation = 0
			}
		},
		wounded = {
			variables = {
				global_roughness_multiplier = 1,
				light_shaft_enabled = 1,
				dof_focal_region_start = 5,
				motion_blur_amount = 2,
				sun_shadows_enabled = 1,
				skydome_u_offset = 0,
				ambient_diffuse_fade_type = 0,
				dof_focal_region = 5,
				ao_radius = 0.2,
				color_grading_map = "environment/textures/color_grading_wounded",
				emissive_particle_intensity = 1,
				dof_focal_region_end = 5,
				skydome_map = "",
				dof_focal_distance = 10,
				global_diffuse_map = "",
				exposure = 4,
				global_specular_map = "",
				ao_enabled = 1,
				ao_quality = 2,
				skydome_intensity = 1,
				ssr_enabled = 0,
				bloom_enabled = 1,
				ssr_ray_bending_enabled = 0,
				ao_intensity = 0.6,
				vignette_enabled = 1,
				motion_blur_enabled = 0,
				ssm_constant_update_enabled = 0,
				custom_fog_blend_enabled = 0,
				lens_quality_enabled = 0,
				fog_enabled = 1,
				dof_enabled = 0,
				ambient_intensity = 1,
				ssm_enabled = 0,
				ssm_radius = 200,
				sun_enabled = 1,
				outline_enabled = 1,
				ssr_screen_edge_threshold = 0.05,
				dof_focal_near_scale = 1,
				eye_adaptation_enabled = 0,
				bloom_lens_dirt_amount = 1,
				secondary_sun_enabled = 0,
				skydome_cloud_map = "",
				global_lens_dirt_map = "",
				dof_focal_far_scale = 1,
				fog_type = 0,
				ssm_rotation = 0,
				ssr_dangerous_reflection_angle = {
					[1.0] = 0.01,
					[2.0] = 0.01
				},
				vignette_scale_falloff_opacity = {
					1.185,
					2.305,
					1
				},
				ssm_center = {
					0,
					0,
					0
				},
				baked_diffuse_tint = {
					1,
					1,
					1
				},
				bloom_tint = {
					1,
					1,
					1
				},
				ssr_angle_facing_camera_threshold = {
					[1.0] = 1,
					[2.0] = 1
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
				custom_fog_blend_direction = {
					0,
					0,
					-1
				},
				ssr_up_normal_threshold = {
					[1.0] = 0,
					[2.0] = 1
				},
				fog_color = {
					0.6,
					0.6,
					0.6
				},
				ambient_tint = {
					1,
					1,
					1
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
				reflections_tint = {
					1,
					1,
					1
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
				fog_color = 0,
				global_roughness_multiplier = 0,
				skydome_fog_height_falloff = 0,
				sun_shadow_slice_depth_ranges = 0,
				light_shaft_enabled = 0,
				global_specular_map = 0,
				custom_fog_blend_color = 0,
				secondary_sun_color = 0,
				sun_shadows_enabled = 0,
				custom_fog_blend_enabled = 0,
				vignette_scale_falloff_opacity = 1,
				skydome_cloud_speed_scale = 0,
				ssm_enabled = 0,
				skydome_u_offset = 0,
				custom_fog_blend = 0,
				dof_focal_region = 0,
				skydome_tint_color = 0,
				color_grading_map = 1,
				ssm_center = 0,
				emissive_particle_intensity = 0,
				fog_sun_blend = 0,
				dof_focal_region_end = 0,
				skydome_map = 0,
				vignette_color = 1,
				custom_fog_blend_direction = 0,
				secondary_sun_direction = 0,
				reflections_tint = 0,
				dof_focal_distance = 0,
				ambient_diffuse_fade = 0,
				secondary_sun_blend = 0,
				global_diffuse_map = 0,
				exposure = 0,
				ssm_near_far = 0,
				ao_enabled = 0,
				ssr_angle_facing_camera_threshold = 0,
				ao_quality = 0,
				lens_quality_properties = 0,
				skydome_intensity = 0,
				ssr_enabled = 0,
				bloom_enabled = 0,
				height_fog_offset_falloff = 0,
				sun_color = 0,
				ao_intensity = 0,
				motion_blur_amount = 0,
				bloom_tint = 0,
				motion_blur_enabled = 0,
				ssr_dangerous_reflection_angle = 0,
				ssr_surface_thickness_threshold = 0,
				ssm_constant_update_enabled = 0,
				light_shaft_settings = 0,
				ao_radius = 0,
				lens_quality_enabled = 0,
				fog_enabled = 0,
				dof_enabled = 0,
				ambient_intensity = 0,
				sun_direction = 0,
				ambient_diffuse_fade_type = 0,
				ssm_radius = 0,
				bloom_threshold_offset_falloff = 0,
				sun_enabled = 0,
				fog_depth_range = 0,
				eye_adaptation_speed_min_max = 0,
				dof_focal_region_start = 0,
				ssr_up_normal_threshold = 0,
				baked_diffuse_tint = 0,
				ssr_screen_edge_threshold = 0,
				dof_focal_near_scale = 0,
				eye_adaptation_enabled = 0,
				bloom_lens_dirt_amount = 0,
				secondary_sun_enabled = 0,
				skydome_cloud_map = 0,
				global_lens_dirt_map = 0,
				dof_focal_far_scale = 0,
				fog_type = 0,
				ssm_rotation = 0
			}
		}
	}
}
