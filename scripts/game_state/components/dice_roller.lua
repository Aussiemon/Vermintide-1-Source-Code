-- -- Could not decompile file, here is disassembly instead -- --
-- BYTECODE -- dice_roller.lua:67-108
0001    TSETS    1   0   0  ; "world"
0002    GGET     5   2      ; "Managers"
0003    TGETS    5   5   0  ; "world"
0004    MOV      6   5
0005    TGETS    5   5   3  ; "create_world"
0006    KSTR     7   4      ; "dice_simulation"
0007    KNIL     8  10
0008    GGET    11   5      ; "Application"
0009    TGETS   11  11   6  ; "DISABLE_APEX_CLOTH"
0010    GGET    12   5      ; "Application"
0011    TGETS   12  12   7  ; "DISABLE_RENDERING"
0012    GGET    13   5      ; "Application"
0013    TGETS   13  13   8  ; "DISABLE_SOUND"
0014    CALL     5   2   9
0015    TSETS    5   0   1  ; "simulation_world"
0016    GGET     5   9      ; "ScriptWorld"
0017    TGETS    5   5  10  ; "load_level"
0018    TGETS    6   0   1  ; "simulation_world"
0019    KSTR     7  11      ; "levels/dicegame/world"
0020    CALL     5   2   3
0021    GGET     6  12      ; "World"
0022    TGETS    6   6  13  ; "set_flow_callback_object"
0023    TGETS    7   0   1  ; "simulation_world"
0024    MOV      8   0
0025    CALL     6   1   3
0026    GGET     6  14      ; "Level"
0027    TGETS    6   6  15  ; "spawn_background"
0028    MOV      7   5
0029    CALL     6   1   2
0030    TNEW     6   0
0031    TSETS    6   0  16  ; "dice_units"
0032    TNEW     6   0
0033    TSETS    6   0  17  ; "old_dice_units"
0034    TSETS    2   0  18  ; "dice_keeper"
0035    TNEW     6   0
0036    TSETS    6   0  19  ; "dice_types"
0037    TNEW     6   0
0038    TSETS    6   0  20  ; "dice_results"
0039    TSETS    3   0  21  ; "rewards"
0040    MOV      7   2
0041    TGETS    6   2  22  ; "get_dice"
0042    CALL     6   2   2
0043    GGET     7  24      ; "table"
0044    TGETS    7   7  25  ; "clone"
0045    MOV      8   6
0046    CALL     7   2   2
0047    TSETS    7   0  23  ; "dice_data"
0048    GGET     7  12      ; "World"
0049    TGETS    7   7  26  ; "units"
0050    MOV      8   1
0051    CALL     7   2   2
0052    LEN      8   7
0053    KPRI     9   0
0054    KSHORT  10   1
0055    MOV     11   8
0056    KSHORT  12   1
0057    FORI    10 => 0074
0058 => TGETV   14   7  13
0059    GGET    15  27      ; "Unit"
0060    TGETS   15  15  28  ; "get_data"
0061    MOV     16  14
0062    KSTR    17  29      ; "bowl_type"
0063    CALL    15   2   3
0064    ISF         15
0065    JMP     16 => 0073
0066    GGET    16  27      ; "Unit"
0067    TGETS   16  16  30  ; "local_position"
0068    MOV     17  14
0069    KSHORT  18   0
0070    CALL    16   2   3
0071    MOV      9  16
0072    JMP     10 => 0074
0073 => FORL    10 => 0058
0074 => GGET    10  32      ; "Vector3Box"
0075    MOV     11   9
0076    CALL    10   2   2
0077    TSETS   10   0  31  ; "dice_offset"
0078    GGET    10   2      ; "Managers"
0079    TGETS   10  10  33  ; "state"
0080    TGETS   10  10  34  ; "event"
0081    MOV     11  10
0082    TGETS   10  10  35  ; "register"
0083    MOV     12   0
0084    KSTR    13  36      ; "flow_callback_die_collision"
0085    KSTR    14  36      ; "flow_callback_die_collision"
0086    CALL    10   1   5
0087    GGET    10   2      ; "Managers"
0088    TGETS   10  10   0  ; "world"
0089    MOV     11  10
0090    TGETS   10  10  37  ; "wwise_world"
0091    MOV     12   1
0092    CALL    10   2   3
0093    TSETS   10   0  37  ; "wwise_world"
0094    KSHORT  10   1
0095    TSETS   10   0  38  ; "index"
0096    KSHORT  10   0
0097    TSETS   10   0  39  ; "timer"
0098    MOV     11   0
0099    TGETS   10   0  40  ; "_request_from_backend"
0100    MOV     12   4
0101    CALL    10   1   3
0102    TNEW    10   0
0103    TSETS   10   0  41  ; "_glow_dice"
0104    RET0     0   1

-- BYTECODE -- dice_roller.lua:110-114
0001    TGETS    1   0   0  ; "post_cleanup_done"
0002    IST          1
0003    JMP      1 => 0007
0004    MOV      2   0
0005    TGETS    1   0   1  ; "cleanup_post_roll"
0006    CALL     1   1   2
0007 => RET0     0   1

-- BYTECODE -- dice_roller.lua:116-125
0001    GGET     2   0      ; "Managers"
0002    TGETS    2   2   1  ; "state"
0003    TGETS    2   2   2  ; "difficulty"
0004    MOV      3   2
0005    TGETS    2   2   3  ; "get_difficulty"
0006    CALL     2   2   2
0007    TGETS    3   0   4  ; "dice_keeper"
0008    MOV      4   3
0009    TGETS    3   3   5  ; "get_dice"
0010    CALL     3   2   2
0011    TGETS    4   0   6  ; "rewards"
0012    MOV      5   4
0013    TGETS    4   4   7  ; "get_level_start"
0014    CALL     4   2   2
0015    TGETS    5   0   6  ; "rewards"
0016    MOV      6   5
0017    TGETS    5   5   8  ; "get_level_end"
0018    KPRI     7   2
0019    CALL     5   2   3
0020    GGET     6   9      ; "LevelHelper"
0021    MOV      7   6
0022    TGETS    6   6  10  ; "current_level_settings"
0023    CALL     6   2   2
0024    TGETS    7   6  11  ; "dlc_name"
0025    GGET     8  12      ; "ScriptBackendItem"
0026    TGETS    8   8  13  ; "generate_item_server_loot"
0027    MOV      9   3
0028    MOV     10   2
0029    MOV     11   4
0030    MOV     12   5
0031    MOV     13   1
0032    MOV     14   7
0033    CALL     8   1   7
0034    RET0     0   1

-- BYTECODE -- dice_roller.lua:127-159
0001    GGET     2   0      ; "ScriptBackendItem"
0002    TGETS    2   2   1  ; "get_filtered_items"
0003    KSTR     3   2      ; "trinket_as_hero and equipped_by == curre"~
0004    CALL     2   2   2
0005    GGET     3   3      ; "fassert"
0006    LEN      4   2
0007    KSHORT   5   2
0008    ISLT     4   5
0009    JMP      4 => 0012
0010    KPRI     4   1
0011    JMP      5 => 0013
0012 => KPRI     4   2
0013 => KSTR     5   4      ; "There are more than two items"
0014    CALL     3   1   3
0015    TGETB    3   2   1
0016    ISF          3
0017    JMP      4 => 0072
0018    GGET     4   0      ; "ScriptBackendItem"
0019    TGETS    4   4   5  ; "get_item_from_id"
0020    MOV      5   1
0021    CALL     4   2   2
0022    GGET     5   6      ; "ItemMasterList"
0023    TGETS    6   4   7  ; "key"
0024    TGETV    5   5   6
0025    TGETS    6   5   8  ; "can_wield"
0026    LEN      7   6
0027    KSHORT   8   1
0028    ISGE     8   7
0029    JMP      7 => 0031
0030    RET0     0   1
0031 => TGETS    7   3   9  ; "traits"
0032    KPRI     8   0
0033    GGET     9  10      ; "pairs"
0034    MOV     10   7
0035    CALL     9   4   2
0036    ISNEXT  12 => 0044
0037 => GGET    14  11      ; "BuffTemplates"
0038    TGETV   14  14  13
0039    TGETS   15  14  12  ; "roll_dice_as_hero"
0040    ISF         15
0041    JMP     16 => 0044
0042    MOV      8  15
0043    JMP      9 => 0046
0044 => ITERN   12   3   3
0045    ITERL   12 => 0037
0046 => GGET     9  13      ; "table"
0047    TGETS    9   9  14  ; "find"
0048    MOV     10   6
0049    MOV     11   8
0050    CALL     9   2   3
0051    ISF          9
0052    JMP     10 => 0072
0053    GGET     9  15      ; "Managers"
0054    TGETS    9   9  16  ; "player"
0055    MOV     11   9
0056    TGETS   10   9  17  ; "local_player"
0057    CALL    10   2   2
0058    MOV     12  10
0059    TGETS   11  10  18  ; "stats_id"
0060    CALL    11   2   2
0061    MOV     13   9
0062    TGETS   12   9  19  ; "statistics_db"
0063    CALL    12   2   2
0064    MOV     14  12
0065    TGETS   13  12  20  ; "set_stat"
0066    MOV     15  11
0067    KSTR    16  21      ; "win_item_as_"
0068    MOV     17   8
0069    CAT     16  16  17
0070    KSHORT  17   1
0071    CALL    13   1   5
0072 => RET0     0   1

-- BYTECODE -- dice_roller.lua:161-177
0001    TGETS    1   0   0  ; "_got_backend_result"
0002    ISF          1
0003    JMP      2 => 0006
0004    KPRI     1   2
0005    RET1     1   2
0006 => GGET     1   1      ; "ScriptBackendItem"
0007    TGETS    1   1   2  ; "check_for_loot"
0008    CALL     1   5   1
0009    ISF          1
0010    JMP      5 => 0023
0011    MOV      6   0
0012    TGETS    5   0   3  ; "_check_for_achievement"
0013    MOV      7   3
0014    CALL     5   1   3
0015    TSETS    1   0   4  ; "_successes"
0016    TSETS    3   0   5  ; "_reward_backend_id"
0017    TSETS    2   0   6  ; "_win_list"
0018    KPRI     5   2
0019    TSETS    5   0   0  ; "_got_backend_result"
0020    TSETS    4   0   7  ; "_level_rewards"
0021    KPRI     5   2
0022    RET1     5   2
0023 => KPRI     5   1
0024    RET1     5   2

-- BYTECODE -- dice_roller.lua:179-181
0001    TGETS    1   0   0  ; "dice_keeper"
0002    MOV      2   1
0003    TGETS    1   1   1  ; "get_dice"
0004    CALLT    1   2

-- BYTECODE -- dice_roller.lua:183-186
0001    GGET     1   0      ; "fassert"
0002    TGETS    2   0   1  ; "_got_backend_result"
0003    KSTR     3   2      ; "Trying to roll dice before response from"~
0004    CALL     1   1   3
0005    TGETS    1   0   3  ; "_successes"
0006    RET1     1   2

-- BYTECODE -- dice_roller.lua:188-191
0001    GGET     1   0      ; "fassert"
0002    TGETS    2   0   1  ; "_got_backend_result"
0003    KSTR     3   2      ; "Trying to roll dice before response from"~
0004    CALL     1   1   3
0005    TGETS    1   0   3  ; "_reward_backend_id"
0006    RET1     1   2

-- BYTECODE -- dice_roller.lua:193-200
0001    GGET     1   0      ; "fassert"
0002    TGETS    2   0   1  ; "_got_backend_result"
0003    KSTR     3   2      ; "Trying to roll dice before response from"~
0004    CALL     1   1   3
0005    KSHORT   1   1
0006    GGET     2   3      ; "pairs"
0007    TGETS    3   0   4  ; "_successes"
0008    CALL     2   4   2
0009    ISNEXT   5 => 0011
0010 => ADDVV    1   1   6
0011 => ITERN    5   3   3
0012    ITERL    5 => 0010
0013    RET1     1   2

-- BYTECODE -- dice_roller.lua:202-205
0001    GGET     1   0      ; "fassert"
0002    TGETS    2   0   1  ; "_got_backend_result"
0003    KSTR     3   2      ; "Trying get level up rewards before respo"~
0004    CALL     1   1   3
0005    TGETS    1   0   3  ; "_level_rewards"
0006    RET1     1   2

-- BYTECODE -- dice_roller.lua:207-210
0001    GGET     1   0      ; "fassert"
0002    TGETS    2   0   1  ; "_got_backend_result"
0003    KSTR     3   2      ; "Trying to roll dice before response from"~
0004    CALL     1   1   3
0005    TGETS    1   0   3  ; "_win_list"
0006    RET1     1   2

-- BYTECODE -- dice_roller.lua:212-216
0001    GGET     1   0      ; "fassert"
0002    TGETS    2   0   1  ; "_got_backend_result"
0003    KSTR     3   2      ; "Trying to roll dice before response from"~
0004    CALL     1   1   3
0005    MOV      2   0
0006    TGETS    1   0   3  ; "num_successes"
0007    CALL     1   2   2
0008    TGETS    2   0   4  ; "_win_list"
0009    TGETV    2   2   1
0010    RET1     2   2

-- BYTECODE -- dice_roller.lua:218-229
0001    TGETS    2   1   0  ; "touched_unit"
0002    TGETS    3   1   1  ; "touching_unit"
0003    TGETS    4   1   2  ; "impulse_force"
0004    GGET     5   3      ; "Vector3"
0005    TGETS    5   5   4  ; "length"
0006    MOV      6   4
0007    CALL     5   2   2
0008    KNUM     6   0      ; 0.1
0009    ISGE     6   5
0010    JMP      5 => 0026
0011    TGETS    5   0   5  ; "_dice_simulation_units"
0012    TGETV    5   5   3
0013    ISF          5
0014    JMP      6 => 0021
0015    TGETS    5   0   6  ; "_sound_events"
0016    TGETS    6   0   6  ; "_sound_events"
0017    LEN      6   6
0018    KSTR     7   7      ; "hud_dice_game_dice_collision"
0019    TSETV    7   5   6
0020    JMP      5 => 0026
0021 => TGETS    5   0   6  ; "_sound_events"
0022    TGETS    6   0   6  ; "_sound_events"
0023    LEN      6   6
0024    KSTR     7   8      ; "hud_dice_game_dice_collision_bucket"
0025    TSETV    7   5   6
0026 => RET0     0   1

-- BYTECODE -- dice_roller.lua:231-233
0001    TGETS    1   0   0  ; "rolling"
0002    RET1     1   2

-- BYTECODE -- dice_roller.lua:235-237
0001    TGETS    1   0   0  ; "rolling_finished"
0002    RET1     1   2

-- BYTECODE -- dice_roller.lua:239-241
0001    TGETS    1   0   0  ; "needs_rerolls"
0002    RET1     1   2

-- BYTECODE -- dice_roller.lua:247-255
0001    GGET     2   0      ; "Unit"
0002    TGETS    2   2   1  ; "num_meshes"
0003    MOV      3   0
0004    CALL     2   2   2
0005    KSHORT   3   0
0006    SUBVN    4   2   0  ; 1
0007    KSHORT   5   1
0008    FORI     3 => 0030
0009 => GGET     7   0      ; "Unit"
0010    TGETS    7   7   2  ; "mesh"
0011    MOV      8   0
0012    MOV      9   6
0013    CALL     7   2   3
0014    GGET     8   3      ; "Mesh"
0015    TGETS    8   8   4  ; "num_materials"
0016    MOV      9   7
0017    CALL     8   2   2
0018    GGET     9   3      ; "Mesh"
0019    TGETS    9   9   5  ; "material"
0020    MOV     10   7
0021    KSTR    11   6      ; "m_dice"
0022    CALL     9   2   3
0023    GGET    10   7      ; "Material"
0024    TGETS   10  10   8  ; "set_vector3"
0025    MOV     11   9
0026    KSTR    12   9      ; "emissive"
0027    MOV     13   1
0028    CALL    10   1   4
0029    FORL     3 => 0009
0030 => RET0     0   1

-- BYTECODE -- dice_roller.lua:257-260
0001    TGETS    2   0   0  ; "_glow_dice"
0002    TGETS    3   0   0  ; "_glow_dice"
0003    LEN      3   3
0004    ADDVN    3   3   0  ; 1
0005    TDUP     4   1
0006    TSETS    1   4   2  ; "unit"
0007    TSETV    4   2   3
0008    GGET     2   3      ; "WwiseWorld"
0009    TGETS    2   2   4  ; "trigger_event"
0010    TGETS    3   0   5  ; "wwise_world"
0011    KSTR     4   6      ; "hud_dice_game_glow"
0012    CALL     2   1   3
0013    RET0     0   1

-- BYTECODE -- dice_roller.lua:262-274
0001    GGET     2   0      ; "Vector3"
0002    KNUM     3   0      ; 0.615
0003    KNUM     4   1      ; 0.208
0004    KNUM     5   2      ; 0.055
0005    CALL     2   2   4
0006    KNUM     3   3      ; 0.2
0007    GGET     4   1      ; "pairs"
0008    TGETS    5   0   2  ; "_glow_dice"
0009    CALL     4   4   2
0010    ISNEXT   7 => 0031
0011 => TGETS    9   8   3  ; "time"
0012    ADDVV    9   9   1
0013    TSETS    9   8   3  ; "time"
0014    GGET     9   4      ; "math"
0015    TGETS    9   9   5  ; "min"
0016    KSHORT  10   1
0017    TGETS   11   8   3  ; "time"
0018    MULVV   11  11   3
0019    CALL     9   2   3
0020    GGET    10   4      ; "math"
0021    TGETS   10  10   6  ; "sirp"
0022    KSHORT  11   0
0023    KSHORT  12   1
0024    MOV     13   9
0025    CALL    10   2   4
0026    DIVVV   11   2  10
0027    UGET    12   0      ; set_emissive
0028    TGETS   13   8   7  ; "unit"
0029    MOV     14  11
0030    CALL    12   1   3
0031 => ITERN    7   3   3
0032    ITERL    7 => 0011
0033    RET0     0   1

-- BYTECODE -- dice_roller.lua:276-298
0001    TNEW     2   0
0002    TGETS    3   0   0  ; "remaining_dice"
0003    IST          3
0004    JMP      4 => 0009
0005    GGET     3   1      ; "table"
0006    TGETS    3   3   2  ; "clone"
0007    TGETS    4   0   3  ; "dice_data"
0008    CALL     3   2   2
0009 => TSETS    3   0   0  ; "remaining_dice"
0010    GGET     3   4      ; "ipairs"
0011    UGET     4   0      ; dice_types_mapping
0012    CALL     3   4   2
0013    JMP      6 => 0039
0014 => TGETS    8   0   0  ; "remaining_dice"
0015    TGETV    8   8   7
0016    TGETV    9   1   7
0017    KSHORT  10   0
0018    KSHORT  11   1
0019    MOV     12   8
0020    KSHORT  13   1
0021    FORI    11 => 0039
0022 => ISLT    10   9
0023    JMP     15 => 0026
0024    KPRI    15   1
0025    JMP     16 => 0027
0026 => KPRI    15   2
0027 => TDUP    16   5
0028    TSETS    7  16   6  ; "dice_type"
0029    TSETS   15  16   7  ; "success"
0030    LEN     17   2
0031    ADDVN   17  17   0  ; 1
0032    TSETV   16   2  17
0033    ISF         15
0034    JMP     17 => 0038
0035    ADDVN   17  10   0  ; 1
0036    ISTC    10  17
0037    JMP     18 => 0038
0038 => FORL    11 => 0022
0039 => ITERC    6   3   3
0040    ITERL    6 => 0014
0041    GGET     3   1      ; "table"
0042    TGETS    3   3   8  ; "shuffle"
0043    MOV      4   2
0044    CALL     3   1   2
0045    TSETS    2   0   9  ; "_success_table"
0046    RET0     0   1

-- BYTECODE -- dice_roller.lua:300-331
0001    GGET     1   0      ; "fassert"
0002    TGETS    2   0   1  ; "_got_backend_result"
0003    KSTR     3   2      ; "Trying to roll dice before response from"~
0004    CALL     1   1   3
0005    TGETS    1   0   3  ; "world"
0006    TGETS    2   0   4  ; "_dice_simulation_settings"
0007    TNEW     3   0
0008    LEN      4   2
0009    GGET     5   5      ; "Vector3"
0010    UGET     6   0      ; SCALAR
0011    UGET     7   0      ; SCALAR
0012    UGET     8   0      ; SCALAR
0013    CALL     5   2   4
0014    KSHORT   6   1
0015    MOV      7   4
0016    KSHORT   8   1
0017    FORI     6 => 0049
0018 => TGETV   10   2   9
0019    TGETS   11  10   6  ; "dice_type"
0020    UGET    12   1      ; unit_names
0021    TGETV   12  12  11
0022    KSTR    13   7      ; "_no_physics"
0023    CAT     12  12  13
0024    TGETS   13  10   8  ; "initial_position"
0025    MOV     14  13
0026    TGETS   13  13   9  ; "unbox"
0027    CALL    13   2   2
0028    UGET    14   0      ; SCALAR
0029    MULVV   13  13  14
0030    TGETS   14  10  10  ; "initial_rotation"
0031    MOV     15  14
0032    TGETS   14  14   9  ; "unbox"
0033    CALL    14   2   2
0034    GGET    15  11      ; "World"
0035    TGETS   15  15  12  ; "spawn_unit"
0036    MOV     16   1
0037    MOV     17  12
0038    MOV     18  13
0039    MOV     19  14
0040    CALL    15   2   5
0041    GGET    16  13      ; "Unit"
0042    TGETS   16  16  14  ; "set_local_scale"
0043    MOV     17  15
0044    KSHORT  18   0
0045    MOV     19   5
0046    CALL    16   1   4
0047    TSETV   10   3  15
0048    FORL     6 => 0018
0049 => GGET     6  15      ; "WwiseWorld"
0050    TGETS    6   6  16  ; "trigger_event"
0051    TGETS    7   0  17  ; "wwise_world"
0052    KSTR     8  18      ; "hud_dice_game_roll_many"
0053    CALL     6   2   3
0054    KPRI     7   2
0055    TSETS    7   0  19  ; "rolling"
0056    KSHORT   7   0
0057    TSETS    7   0  20  ; "roll_time"
0058    TSETS    3   0  21  ; "dice_units"
0059    GGET     7  22      ; "table"
0060    TGETS    7   7  23  ; "clear"
0061    TGETS    8   0  24  ; "dice_results"
0062    CALL     7   1   2
0063    LEN      7   2
0064    RET1     7   2

-- BYTECODE -- dice_roller.lua:333-411
0001    GGET     2   0      ; "fassert"
0002    TGETS    3   0   1  ; "_got_backend_result"
0003    KSTR     4   2      ; "Trying to roll dice before response from"~
0004    CALL     2   1   3
0005    TGETS    2   0   3  ; "_success_table"
0006    IST          2
0007    JMP      2 => 0012
0008    MOV      3   0
0009    TGETS    2   0   4  ; "_create_success_table"
0010    MOV      4   1
0011    CALL     2   1   3
0012 => GGET     2   5      ; "table"
0013    TGETS    2   2   6  ; "clone"
0014    TGETS    3   0   3  ; "_success_table"
0015    CALL     2   2   2
0016    TGETS    3   0   7  ; "simulation_world"
0017    LEN      4   2
0018    TNEW     5   0
0019    TSETS    5   0   8  ; "_sound_events"
0020    TNEW     5   0
0021    TSETS    5   0   9  ; "_dice_simulation_units"
0022    TNEW     5   0
0023    KSHORT   6   1
0024    MOV      7   4
0025    KSHORT   8   1
0026    FORI     6 => 0084
0027 => KPRI    10   1
0028    GGET    11  10      ; "Vector3"
0029    KSHORT  12  16
0030    KSHORT  13   0
0031    KSHORT  14   0
0032    CALL    11   2   4
0033    GGET    12  10      ; "Vector3"
0034    GGET    13  11      ; "math"
0035    TGETS   13  13  12  ; "random"
0036    CALL    13   2   1
0037    DIVVN   13  13   0  ; 20
0038    GGET    14  11      ; "math"
0039    TGETS   14  14  12  ; "random"
0040    CALL    14   2   1
0041    DIVVN   14  14   0  ; 20
0042    KNUM    15   1      ; 0.07
0043    CALL    12   2   4
0044    MULVN   12  12   2  ; 100
0045    ADDVV   11  11  12
0046    KSHORT  12   1
0047    LEN     13   5
0048    KSHORT  14   1
0049    FORI    12 => 0082
0050 => LOOP    16 => 0081
0051    GGET    16  10      ; "Vector3"
0052    TGETS   16  16  13  ; "length"
0053    TGETV   17   5  15
0054    SUBVV   17  11  17
0055    CALL    16   2   2
0056    KSHORT  17   2
0057    ISGE    16  17
0058    JMP     16 => 0078
0059    KPRI    10   1
0060    GGET    16  10      ; "Vector3"
0061    GGET    17  11      ; "math"
0062    TGETS   17  17  12  ; "random"
0063    KSHORT  18  -1
0064    KSHORT  19   1
0065    CALL    17   2   3
0066    DIVVN   17  17   0  ; 20
0067    GGET    18  11      ; "math"
0068    TGETS   18  18  12  ; "random"
0069    KSHORT  19  -1
0070    KSHORT  20   1
0071    CALL    18   2   3
0072    DIVVN   18  18   0  ; 20
0073    KSHORT  19   0
0074    CALL    16   2   4
0075    MULVN   16  16   3  ; 50
0076    ADDVV   11  11  16
0077    JMP     16 => 0079
0078 => KPRI    10   2
0079 => ISF         10
0080    JMP     16 => 0050
0081 => FORL    12 => 0050
0082 => TSETV   11   5   9
0083    FORL     6 => 0027
0084 => KSHORT   6   1
0085    MOV      7   4
0086    KSHORT   8   1
0087    FORI     6 => 0181
0088 => TGETV   10   2   9
0089    TGETS   11  10  14  ; "dice_type"
0090    TGETS   12  10  15  ; "success"
0091    UGET    13   0      ; directions
0092    GGET    14  11      ; "math"
0093    TGETS   14  14  12  ; "random"
0094    KSHORT  15   1
0095    KSHORT  16   6
0096    CALL    14   2   3
0097    TGETV   13  13  14
0098    GGET    14  10      ; "Vector3"
0099    GGET    15  16      ; "unpack"
0100    TGETS   16  13  17  ; "up"
0101    CALL    15   0   2
0102    CALLM   14   2   0
0103    TGETS   15  13  18  ; "rot"
0104    GGET    16  19      ; "Quaternion"
0105    TGETS   16  16  20  ; "axis_angle"
0106    MOV     17  14
0107    MOV     18  15
0108    CALL    16   2   3
0109    UGET    17   1      ; unit_names
0110    TGETV   17  17  11
0111    GGET    18  21      ; "World"
0112    TGETS   18  18  22  ; "spawn_unit"
0113    MOV     19   3
0114    MOV     20  17
0115    TGETV   21   5   9
0116    MOV     22  16
0117    CALL    18   2   5
0118    TGETS   19   0   9  ; "_dice_simulation_units"
0119    KPRI    20   2
0120    TSETV   20  19  18
0121    GGET    19  23      ; "Unit"
0122    TGETS   19  19  24  ; "actor"
0123    MOV     20  18
0124    KSHORT  21   0
0125    CALL    19   2   3
0126    GGET    20  23      ; "Unit"
0127    TGETS   20  20  25  ; "set_unit_visibility"
0128    MOV     21  18
0129    KPRI    22   1
0130    CALL    20   1   3
0131    GGET    20  26      ; "Actor"
0132    TGETS   20  20  27  ; "wake_up"
0133    MOV     21  19
0134    CALL    20   1   2
0135    GGET    20  26      ; "Actor"
0136    TGETS   20  20  28  ; "set_velocity"
0137    MOV     21  19
0138    GGET    22  10      ; "Vector3"
0139    KNUM    23   4      ; -0.25
0140    KNUM    24   5      ; -0.5
0141    KNUM    25   6      ; -0.07
0142    CALL    22   2   4
0143    MULVN   22  22   7  ; 65
0144    CALL    20   1   3
0145    ISF         12
0146    JMP     20 => 0155
0147    GGET    20  11      ; "math"
0148    TGETS   20  20  12  ; "random"
0149    UGET    21   2      ; dice_type_success_amounts
0150    TGETV   21  21  11
0151    KSHORT  22   6
0152    CALL    20   2   3
0153    IST         20
0154    JMP     21 => 0162
0155 => GGET    20  11      ; "math"
0156    TGETS   20  20  12  ; "random"
0157    KSHORT  21   1
0158    UGET    22   2      ; dice_type_success_amounts
0159    TGETV   22  22  11
0160    SUBVN   22  22   8  ; 1
0161    CALL    20   2   3
0162 => TDUP    21  29
0163    TSETS   18  21  30  ; "unit"
0164    TSETS   11  21  14  ; "dice_type"
0165    GGET    22  31      ; "Vector3Box"
0166    TGETV   23   5   9
0167    CALL    22   2   2
0168    TSETS   22  21  32  ; "initial_position"
0169    GGET    22  33      ; "QuaternionBox"
0170    MOV     23  16
0171    CALL    22   2   2
0172    TSETS   22  21  34  ; "initial_rotation"
0173    TSETS   20  21  35  ; "wanted_dice_result"
0174    TSETS   12  21  15  ; "success"
0175    TNEW    22   0
0176    TSETS   22  21  36  ; "positions"
0177    TNEW    22   0
0178    TSETS   22  21  37  ; "rotations"
0179    TSETV   21   2   9
0180    FORL     6 => 0088
0181 => MOV      7   0
0182    TGETS    6   0  38  ; "run_simulation"
0183    MOV      8   2
0184    CALL     6   2   3
0185    ISF          6
0186    JMP      7 => 0196
0187    MOV      8   0
0188    TGETS    7   0  39  ; "calculate_results"
0189    MOV      9   2
0190    CALL     7   1   3
0191    MOV      8   0
0192    TGETS    7   0  40  ; "alter_rotations"
0193    MOV      9   2
0194    CALL     7   1   3
0195    TSETS    2   0  41  ; "_dice_simulation_settings"
0196 => LEN      7   2
0197    KSHORT   8   1
0198    MOV      9   7
0199    KSHORT  10   1
0200    FORI     8 => 0210
0201 => TGETV   12   2  11
0202    GGET    13  21      ; "World"
0203    TGETS   13  13  42  ; "destroy_unit"
0204    MOV     14   3
0205    TGETS   15  12  30  ; "unit"
0206    CALL    13   1   3
0207    KPRI    13   0
0208    TSETS   13  12  30  ; "unit"
0209    FORL     8 => 0201
0210 => RET1     6   2

-- BYTECODE -- dice_roller.lua:413-471
0001    GGET     2   0      ; "fassert"
0002    TGETS    3   0   1  ; "_got_backend_result"
0003    KSTR     4   2      ; "Trying to roll dice before response from"~
0004    CALL     2   1   3
0005    TGETS    2   0   3  ; "simulation_world"
0006    KPRI     3   1
0007    KPRI     4   1
0008    KSHORT   5   0
0009    LEN      6   1
0010 => IST          3
0011    JMP      7 => 0109
0012    LOOP     7 => 0109
0013    GGET     7   4      ; "Script"
0014    TGETS    7   7   5  ; "temp_count"
0015    CALL     7   4   1
0016    GGET    10   6      ; "World"
0017    TGETS   10  10   7  ; "update_scene"
0018    MOV     11   2
0019    KNUM    12   0      ; 0.033333333333333
0020    CALL    10   1   3
0021    KSHORT  10   0
0022    KPRI    11   1
0023    TGETS   12   0   8  ; "_sound_events"
0024    TGETS   13   0   8  ; "_sound_events"
0025    LEN     13  13
0026    ADDVN   13  13   1  ; 1
0027    KPRI    14   1
0028    TSETV   14  12  13
0029    KSHORT  12   1
0030    MOV     13   6
0031    KSHORT  14   1
0032    FORI    12 => 0086
0033 => TGETV   16   1  15
0034    TGETS   17  16   9  ; "unit"
0035    GGET    18  10      ; "Unit"
0036    TGETS   18  18  11  ; "actor"
0037    MOV     19  17
0038    KSHORT  20   0
0039    CALL    18   2   3
0040    GGET    19  12      ; "Actor"
0041    TGETS   19  19  13  ; "velocity"
0042    MOV     20  18
0043    CALL    19   2   2
0044    TGETS   20  16  14  ; "positions"
0045    LEN     20  20
0046    ADDVN   20  20   1  ; 1
0047    TGETS   21  16  14  ; "positions"
0048    GGET    22  15      ; "Vector3Box"
0049    GGET    23  10      ; "Unit"
0050    TGETS   23  23  16  ; "local_position"
0051    MOV     24  17
0052    KSHORT  25   0
0053    CALL    23   0   3
0054    CALLM   22   2   0
0055    TSETV   22  21  20
0056    TGETS   21  16  17  ; "rotations"
0057    GGET    22  18      ; "QuaternionBox"
0058    GGET    23  10      ; "Unit"
0059    TGETS   23  23  19  ; "local_rotation"
0060    MOV     24  17
0061    KSHORT  25   0
0062    CALL    23   0   3
0063    CALLM   22   2   0
0064    TSETV   22  21  20
0065    GGET    21  20      ; "Vector3"
0066    TGETS   21  21  21  ; "length"
0067    MOV     22  19
0068    CALL    21   2   2
0069    KNUM    22   2      ; 0.001
0070    ISGE    21  22
0071    JMP     21 => 0085
0072    ADDVN   10  10   1  ; 1
0073    MOV     22   0
0074    TGETS   21   0  22  ; "get_dice_result"
0075    MOV     23  17
0076    TGETS   24  16  23  ; "dice_type"
0077    CALL    21   2   4
0078    ISNEN   21   3      ; 0
0079    JMP     22 => 0081
0080    KPRI    11   2
0081 => TGETS   22  16  24  ; "completed_index"
0082    IST         22
0083    JMP     22 => 0085
0084    TSETS   20  16  24  ; "completed_index"
0085 => FORL    12 => 0033
0086 => ISNEV   10   6
0087    JMP     12 => 0090
0088    KPRI     3   2
0089    KPRI     4   2
0090 => ADDVN    5   5   1  ; 1
0091    ISEQN    5   4      ; 200
0092    JMP     12 => 0097
0093    ISF          3
0094    JMP     12 => 0102
0095    ISF         11
0096    JMP     12 => 0102
0097 => GGET    12  25      ; "print"
0098    KSTR    13  26      ; "dice game broke, rerunning"
0099    CALL    12   1   2
0100    KPRI     3   2
0101    KPRI     4   1
0102 => GGET    12   4      ; "Script"
0103    TGETS   12  12  27  ; "set_temp_count"
0104    MOV     13   7
0105    MOV     14   8
0106    MOV     15   9
0107    CALL    12   1   4
0108    JMP      7 => 0010
0109 => RET1     4   2

-- BYTECODE -- dice_roller.lua:473-483
0001    LEN      2   1
0002    KSHORT   3   1
0003    MOV      4   2
0004    KSHORT   5   1
0005    FORI     3 => 0015
0006 => TGETV    7   1   6
0007    TGETS    8   7   0  ; "unit"
0008    MOV     10   0
0009    TGETS    9   0   1  ; "get_dice_result"
0010    MOV     11   8
0011    TGETS   12   7   2  ; "dice_type"
0012    CALL     9   2   4
0013    TSETS    9   7   3  ; "dice_result"
0014    FORL     3 => 0006
0015 => RET0     0   1

-- BYTECODE -- dice_roller.lua:485-516
0001    GGET     3   0      ; "Unit"
0002    TGETS    3   3   1  ; "world_pose"
0003    MOV      4   1
0004    KSHORT   5   0
0005    CALL     3   2   3
0006    GGET     4   2      ; "Matrix4x4"
0007    TGETS    4   4   3  ; "up"
0008    MOV      5   3
0009    CALL     4   2   2
0010    GGET     5   2      ; "Matrix4x4"
0011    TGETS    5   5   4  ; "forward"
0012    MOV      6   3
0013    CALL     5   2   2
0014    GGET     6   2      ; "Matrix4x4"
0015    TGETS    6   6   5  ; "right"
0016    MOV      7   3
0017    CALL     6   2   2
0018    UNM      7   6
0019    UNM      8   4
0020    UNM      9   5
0021    GGET    10   6      ; "math"
0022    TGETS   10  10   7  ; "max"
0023    TGETS   11   4   8  ; "z"
0024    TGETS   12   5   8  ; "z"
0025    TGETS   13   6   8  ; "z"
0026    TGETS   14   8   8  ; "z"
0027    TGETS   15   7   8  ; "z"
0028    TGETS   16   9   8  ; "z"
0029    CALL    10   2   7
0030    KPRI    11   0
0031    TGETS   12   4   8  ; "z"
0032    ISNEV   12  10
0033    JMP     12 => 0036
0034    KSHORT  11   1
0035    JMP     12 => 0060
0036 => TGETS   12   5   8  ; "z"
0037    ISNEV   12  10
0038    JMP     12 => 0041
0039    KSHORT  11   2
0040    JMP     12 => 0060
0041 => TGETS   12   6   8  ; "z"
0042    ISNEV   12  10
0043    JMP     12 => 0046
0044    KSHORT  11   4
0045    JMP     12 => 0060
0046 => TGETS   12   8   8  ; "z"
0047    ISNEV   12  10
0048    JMP     12 => 0051
0049    KSHORT  11   6
0050    JMP     12 => 0060
0051 => TGETS   12   7   8  ; "z"
0052    ISNEV   12  10
0053    JMP     12 => 0056
0054    KSHORT  11   3
0055    JMP     12 => 0060
0056 => TGETS   12   9   8  ; "z"
0057    ISNEV   12  10
0058    JMP     12 => 0060
0059    KSHORT  11   5
0060 => GGET    12   0      ; "Unit"
0061    TGETS   12  12   9  ; "world_position"
0062    MOV     13   1
0063    KSHORT  14   0
0064    CALL    12   2   3
0065    TGETS   12  12   8  ; "z"
0066    UGET    13   0      ; broken_heights
0067    TGETV   13  13   2
0068    ISGT    13  12
0069    JMP     12 => 0071
0070    KSHORT  11   0
0071 => RET1    11   2

-- BYTECODE -- dice_roller.lua:518-550
0001    LEN      2   1
0002    KSHORT   3   1
0003    MOV      4   2
0004    KSHORT   5   1
0005    FORI     3 => 0063
0006 => LOOP     7 => 0062
0007    TGETV    7   1   6
0008    TGETS    8   7   0  ; "wanted_dice_result"
0009    TGETS    9   7   1  ; "dice_result"
0010    TGETS   10   7   2  ; "initial_rotation"
0011    MOV     11  10
0012    TGETS   10  10   3  ; "unbox"
0013    CALL    10   2   2
0014    ISNEN    9   0      ; 0
0015    JMP     11 => 0017
0016    JMP      7 => 0062
0017 => UGET    11   0      ; rotation_mappings
0018    TGETV   11  11   9
0019    TGETV   11  11   8
0020    UGET    12   1      ; directions
0021    TGETV   12  12  11
0022    GGET    13   4      ; "Vector3"
0023    GGET    14   5      ; "unpack"
0024    TGETS   15  12   6  ; "up"
0025    CALL    14   0   2
0026    CALLM   13   2   0
0027    TGETS   14  12   7  ; "rot"
0028    GGET    15   8      ; "Quaternion"
0029    TGETS   15  15   9  ; "axis_angle"
0030    MOV     16  13
0031    MOV     17  14
0032    CALL    15   2   3
0033    TGETS   16   7   2  ; "initial_rotation"
0034    MOV     17  16
0035    TGETS   16  16  10  ; "store"
0036    GGET    18   8      ; "Quaternion"
0037    TGETS   18  18  11  ; "multiply"
0038    MOV     19  10
0039    MOV     20  15
0040    CALL    18   0   3
0041    CALLM   16   1   1
0042    TGETS   16   7  12  ; "rotations"
0043    LEN     17  16
0044    KSHORT  18   1
0045    MOV     19  17
0046    KSHORT  20   1
0047    FORI    18 => 0062
0048 => TGETV   22  16  21
0049    MOV     23  22
0050    TGETS   22  22   3  ; "unbox"
0051    CALL    22   2   2
0052    GGET    23   8      ; "Quaternion"
0053    TGETS   23  23  11  ; "multiply"
0054    MOV     24  22
0055    MOV     25  15
0056    CALL    23   2   3
0057    GGET    24  13      ; "QuaternionBox"
0058    MOV     25  23
0059    CALL    24   2   2
0060    TSETV   24  16  21
0061    FORL    18 => 0048
0062 => FORL     3 => 0006
0063 => RET0     0   1

-- BYTECODE -- dice_roller.lua:552-554
0001    TGETS    1   0   0  ; "num_successes"
0002    RET1     1   2

-- BYTECODE -- dice_roller.lua:556-621
0001    TGETS    2   0   0  ; "rolling"
0002    IST          2
0003    JMP      2 => 0005
0004    RET0     0   1
0005 => TGETS    2   0   1  ; "roll_time"
0006    ADDVV    2   2   1
0007    TGETS    3   0   2  ; "dice_units"
0008    KSHORT   4   0
0009    TGETS    5   0   3  ; "dice_offset"
0010    MOV      6   5
0011    TGETS    5   5   4  ; "unbox"
0012    CALL     5   2   2
0013    GGET     6   5      ; "pairs"
0014    MOV      7   3
0015    CALL     6   4   2
0016    ISNEXT   9 => 0126
0017 => TGETS   11  10   6  ; "positions"
0018    TGETS   12  10   7  ; "rotations"
0019    LEN     13  11
0020    MULVN   14  13   0  ; 0.016666666666667
0021    DIVVV   15   2  14
0022    GGET    16   8      ; "math"
0023    TGETS   16  16   9  ; "min"
0024    MULVV   17  15  13
0025    MOV     18  13
0026    CALL    16   2   3
0027    GGET    17   8      ; "math"
0028    TGETS   17  17  10  ; "max"
0029    GGET    18   8      ; "math"
0030    TGETS   18  18  11  ; "floor"
0031    MOV     19  16
0032    CALL    18   2   2
0033    KSHORT  19   1
0034    CALL    17   2   3
0035    GGET    18   8      ; "math"
0036    TGETS   18  18   9  ; "min"
0037    GGET    19   8      ; "math"
0038    TGETS   19  19  10  ; "max"
0039    GGET    20   8      ; "math"
0040    TGETS   20  20  12  ; "ceil"
0041    MOV     21  16
0042    CALL    20   2   2
0043    KSHORT  21   1
0044    CALL    19   2   3
0045    MOV     20  13
0046    CALL    18   2   3
0047    SUBVV   19  16  17
0048    TGETV   20  11  17
0049    MOV     21  20
0050    TGETS   20  20   4  ; "unbox"
0051    CALL    20   2   2
0052    SUBVV   20  20   5
0053    UGET    21   0      ; SCALAR
0054    MULVV   20  20  21
0055    ADDVV   20  20   5
0056    TGETV   21  11  18
0057    MOV     22  21
0058    TGETS   21  21   4  ; "unbox"
0059    CALL    21   2   2
0060    SUBVV   21  21   5
0061    UGET    22   0      ; SCALAR
0062    MULVV   21  21  22
0063    ADDVV   21  21   5
0064    GGET    22  13      ; "Vector3"
0065    TGETS   22  22  14  ; "lerp"
0066    MOV     23  20
0067    MOV     24  21
0068    MOV     25  19
0069    CALL    22   2   4
0070    TGETV   23  12  17
0071    MOV     24  23
0072    TGETS   23  23   4  ; "unbox"
0073    CALL    23   2   2
0074    TGETV   24  12  18
0075    MOV     25  24
0076    TGETS   24  24   4  ; "unbox"
0077    CALL    24   2   2
0078    GGET    25  15      ; "Quaternion"
0079    TGETS   25  25  14  ; "lerp"
0080    MOV     26  23
0081    MOV     27  24
0082    MOV     28  19
0083    CALL    25   2   4
0084    GGET    26  16      ; "Unit"
0085    TGETS   26  26  17  ; "set_local_position"
0086    MOV     27   9
0087    KSHORT  28   0
0088    MOV     29  22
0089    CALL    26   1   4
0090    GGET    26  16      ; "Unit"
0091    TGETS   26  26  18  ; "set_local_rotation"
0092    MOV     27   9
0093    KSHORT  28   0
0094    MOV     29  25
0095    CALL    26   1   4
0096    TGETS   26  10  19  ; "completed_index"
0097    ISGT    26  17
0098    JMP     26 => 0111
0099    TGETS   26  10  20  ; "success"
0100    ISF         26
0101    JMP     27 => 0111
0102    TGETS   26  10  21  ; "highlighted"
0103    IST         26
0104    JMP     26 => 0111
0105    MOV     27   0
0106    TGETS   26   0  22  ; "_add_to_glow_list"
0107    MOV     28   9
0108    CALL    26   1   3
0109    KPRI    26   2
0110    TSETS   26  10  21  ; "highlighted"
0111 => TGETS   26   0  23  ; "_sound_events"
0112    TGETV   26  26  17
0113    ISF         26
0114    JMP     27 => 0123
0115    GGET    27  24      ; "WwiseWorld"
0116    TGETS   27  27  25  ; "trigger_event"
0117    TGETS   28   0  26  ; "wwise_world"
0118    MOV     29  26
0119    CALL    27   1   3
0120    TGETS   27   0  23  ; "_sound_events"
0121    KPRI    28   1
0122    TSETV   28  27  17
0123 => ISNEV   16  13
0124    JMP     27 => 0126
0125    ADDVN    4   4   1  ; 1
0126 => ITERN    9   3   3
0127    ITERL    9 => 0017
0128    MOV      7   0
0129    TGETS    6   0  27  ; "_update_glow"
0130    MOV      8   1
0131    CALL     6   1   3
0132    GGET     6  28      ; "table"
0133    TGETS    6   6  29  ; "size"
0134    MOV      7   3
0135    CALL     6   2   2
0136    ISNEV    4   6
0137    JMP      6 => 0160
0138    TGETS    6   0  30  ; "grace_time"
0139    IST          6
0140    JMP      6 => 0144
0141    KSHORT   6   0
0142    TSETS    6   0  30  ; "grace_time"
0143    JMP      6 => 0160
0144 => TGETS    6   0  30  ; "grace_time"
0145    KNUM     7   2      ; 1.5
0146    ISGT     7   6
0147    JMP      6 => 0157
0148    KPRI     6   1
0149    TSETS    6   0   0  ; "rolling"
0150    MOV      7   0
0151    TGETS    6   0  32  ; "cleanup_post_roll"
0152    CALL     6   2   2
0153    TSETS    6   0  31  ; "rolling_finished"
0154    KPRI     6   0
0155    TSETS    6   0  30  ; "grace_time"
0156    JMP      6 => 0160
0157 => TGETS    6   0  30  ; "grace_time"
0158    ADDVV    6   6   1
0159    TSETS    6   0  30  ; "grace_time"
0160 => TSETS    2   0   1  ; "roll_time"
0161    RET0     0   1

-- BYTECODE -- dice_roller.lua:623-657
0001    TGETS    1   0   0  ; "dice_units"
0002    TNEW     2   0
0003    KSHORT   3   0
0004    KPRI     4   1
0005    TSETS    4   0   1  ; "needs_rerolls"
0006    GGET     4   2      ; "pairs"
0007    MOV      5   1
0008    CALL     4   4   2
0009    ISNEXT   7 => 0045
0010 => LEN      9   2
0011    ADDVN    9   9   0  ; 1
0012    TSETV    7   2   9
0013    TGETS    9   8   3  ; "dice_result"
0014    ISEQN    9   1      ; 0
0015    JMP      9 => 0025
0016    TGETS    9   0   4  ; "remaining_dice"
0017    TGETS   10   8   5  ; "dice_type"
0018    TGETS   11   0   4  ; "remaining_dice"
0019    TGETS   12   8   5  ; "dice_type"
0020    TGETV   11  11  12
0021    SUBVN   11  11   0  ; 1
0022    TSETV   11   9  10
0023    ADDVN    3   3   0  ; 1
0024    JMP      9 => 0045
0025 => TGETS    9   0   4  ; "remaining_dice"
0026    TGETS   10   8   5  ; "dice_type"
0027    TGETV    9   9  10
0028    TGETS    9   9   6  ; "successes"
0029    IST          9
0030    JMP     10 => 0032
0031    KSHORT   9   0
0032 => TGETS   10   0   4  ; "remaining_dice"
0033    TGETS   11   8   5  ; "dice_type"
0034    TGETV   10  10  11
0035    TGETS   11   8   7  ; "success"
0036    ISF         11
0037    JMP     12 => 0041
0038    ADDVN   11   9   0  ; 1
0039    IST         11
0040    JMP     12 => 0042
0041 => MOV     11   9
0042 => TSETS   11  10   6  ; "successes"
0043    KPRI    10   2
0044    TSETS   10   0   1  ; "needs_rerolls"
0045 => ITERN    7   3   3
0046    ITERL    7 => 0010
0047    LEN      4   2
0048    TGETS    5   0   1  ; "needs_rerolls"
0049    ISF          5
0050    JMP      6 => 0065
0051    KSHORT   5   1
0052    MOV      6   4
0053    KSHORT   7   1
0054    FORI     5 => 0065
0055 => TGETV    9   2   8
0056    TGETS   10   0   0  ; "dice_units"
0057    KPRI    11   0
0058    TSETV   11  10   9
0059    GGET    10   8      ; "World"
0060    TGETS   10  10   9  ; "destroy_unit"
0061    TGETS   11   0  10  ; "world"
0062    MOV     12   9
0063    CALL    10   1   3
0064    FORL     5 => 0055
0065 => GGET     5  11      ; "Managers"
0066    TGETS    5   5  10  ; "world"
0067    MOV      6   5
0068    TGETS    5   5  12  ; "destroy_world"
0069    TGETS    7   0  13  ; "simulation_world"
0070    CALL     5   1   3
0071    KPRI     5   2
0072    TSETS    5   0  14  ; "post_cleanup_done"
0073    ISEQV    3   4
0074    JMP      5 => 0077
0075    KPRI     5   1
0076    JMP      6 => 0078
0077 => KPRI     5   2
0078 => RET1     5   2

-- BYTECODE -- dice_roller.lua:0-744
0001    TNEW     0  10
0002    TDUP     1   1
0003    TDUP     2   0
0004    TSETS    2   1   2  ; "up"
0005    TSETB    1   0   1
0006    TDUP     1   4
0007    TDUP     2   3
0008    TSETS    2   1   2  ; "up"
0009    GGET     2   5      ; "math"
0010    TGETS    2   2   6  ; "pi"
0011    DIVVN    2   2   0  ; 2
0012    TSETS    2   1   7  ; "rot"
0013    TSETB    1   0   2
0014    TDUP     1   9
0015    TDUP     2   8
0016    TSETS    2   1   2  ; "up"
0017    GGET     2   5      ; "math"
0018    TGETS    2   2   6  ; "pi"
0019    DIVVN    2   2   0  ; 2
0020    TSETS    2   1   7  ; "rot"
0021    TSETB    1   0   3
0022    TDUP     1  11
0023    TDUP     2  10
0024    TSETS    2   1   2  ; "up"
0025    GGET     2   5      ; "math"
0026    TGETS    2   2   6  ; "pi"
0027    UNM      2   2
0028    DIVVN    2   2   0  ; 2
0029    TSETS    2   1   7  ; "rot"
0030    TSETB    1   0   4
0031    TDUP     1  13
0032    TDUP     2  12
0033    TSETS    2   1   2  ; "up"
0034    GGET     2   5      ; "math"
0035    TGETS    2   2   6  ; "pi"
0036    UNM      2   2
0037    DIVVN    2   2   0  ; 2
0038    TSETS    2   1   7  ; "rot"
0039    TSETB    1   0   5
0040    TDUP     1  15
0041    TDUP     2  14
0042    TSETS    2   1   2  ; "up"
0043    GGET     2   5      ; "math"
0044    TGETS    2   2   6  ; "pi"
0045    TSETS    2   1   7  ; "rot"
0046    TSETB    1   0   6
0047    TDUP     1  17
0048    TDUP     2  16
0049    TSETS    2   1   2  ; "up"
0050    GGET     2   5      ; "math"
0051    TGETS    2   2   6  ; "pi"
0052    DIVVN    2   2   0  ; 2
0053    TSETS    2   1   7  ; "rot"
0054    TSETB    1   0   7
0055    TDUP     1  19
0056    TDUP     2  18
0057    TSETS    2   1   2  ; "up"
0058    GGET     2   5      ; "math"
0059    TGETS    2   2   6  ; "pi"
0060    UNM      2   2
0061    DIVVN    2   2   0  ; 2
0062    TSETS    2   1   7  ; "rot"
0063    TSETB    1   0   8
0064    TDUP     1  21
0065    TDUP     2  20
0066    TSETS    2   1   2  ; "up"
0067    GGET     2   5      ; "math"
0068    TGETS    2   2   6  ; "pi"
0069    TSETS    2   1   7  ; "rot"
0070    TSETB    1   0   9
0071    TNEW     1   7
0072    TDUP     2  22
0073    TSETB    2   1   1
0074    TDUP     2  23
0075    TSETB    2   1   2
0076    TDUP     2  24
0077    TSETB    2   1   3
0078    TDUP     2  25
0079    TSETB    2   1   4
0080    TDUP     2  26
0081    TSETB    2   1   5
0082    TDUP     2  27
0083    TSETB    2   1   6
0084    TDUP     2  28
0085    TDUP     3  29
0086    TDUP     4  30
0087    TDUP     5  31
0088    KNUM     6   1      ; 0.03
0089    GGET     7  32      ; "class"
0090    GGET     8  33      ; "DiceRoller"
0091    CALL     7   2   2
0092    GSET     7  33      ; "DiceRoller"
0093    GGET     7  33      ; "DiceRoller"
0094    FNEW     8  35      ; dice_roller.lua:67
0095    TSETS    8   7  34  ; "init"
0096    GGET     7  33      ; "DiceRoller"
0097    FNEW     8  37      ; dice_roller.lua:110
0098    TSETS    8   7  36  ; "destroy"
0099    GGET     7  33      ; "DiceRoller"
0100    FNEW     8  39      ; dice_roller.lua:116
0101    TSETS    8   7  38  ; "_request_from_backend"
0102    GGET     7  33      ; "DiceRoller"
0103    FNEW     8  41      ; dice_roller.lua:127
0104    TSETS    8   7  40  ; "_check_for_achievement"
0105    GGET     7  33      ; "DiceRoller"
0106    FNEW     8  43      ; dice_roller.lua:161
0107    TSETS    8   7  42  ; "poll_for_backend_result"
0108    GGET     7  33      ; "DiceRoller"
0109    FNEW     8  45      ; dice_roller.lua:179
0110    TSETS    8   7  44  ; "dice"
0111    GGET     7  33      ; "DiceRoller"
0112    FNEW     8  47      ; dice_roller.lua:183
0113    TSETS    8   7  46  ; "successes"
0114    GGET     7  33      ; "DiceRoller"
0115    FNEW     8  49      ; dice_roller.lua:188
0116    TSETS    8   7  48  ; "reward_backend_id"
0117    GGET     7  33      ; "DiceRoller"
0118    FNEW     8  51      ; dice_roller.lua:193
0119    TSETS    8   7  50  ; "num_successes"
0120    GGET     7  33      ; "DiceRoller"
0121    FNEW     8  53      ; dice_roller.lua:202
0122    TSETS    8   7  52  ; "level_up_rewards"
0123    GGET     7  33      ; "DiceRoller"
0124    FNEW     8  55      ; dice_roller.lua:207
0125    TSETS    8   7  54  ; "win_list"
0126    GGET     7  33      ; "DiceRoller"
0127    FNEW     8  57      ; dice_roller.lua:212
0128    TSETS    8   7  56  ; "reward_item_key"
0129    GGET     7  33      ; "DiceRoller"
0130    FNEW     8  59      ; dice_roller.lua:218
0131    TSETS    8   7  58  ; "flow_callback_die_collision"
0132    GGET     7  33      ; "DiceRoller"
0133    FNEW     8  61      ; dice_roller.lua:231
0134    TSETS    8   7  60  ; "is_rolling"
0135    GGET     7  33      ; "DiceRoller"
0136    FNEW     8  63      ; dice_roller.lua:235
0137    TSETS    8   7  62  ; "is_completed"
0138    GGET     7  33      ; "DiceRoller"
0139    FNEW     8  65      ; dice_roller.lua:239
0140    TSETS    8   7  64  ; "has_rerolls"
0141    TDUP     7  66
0142    FNEW     8  67      ; dice_roller.lua:247
0143    GGET     9  33      ; "DiceRoller"
0144    FNEW    10  69      ; dice_roller.lua:257
0145    TSETS   10   9  68  ; "_add_to_glow_list"
0146    GGET     9  33      ; "DiceRoller"
0147    FNEW    10  71      ; dice_roller.lua:262
0148    TSETS   10   9  70  ; "_update_glow"
0149    GGET     9  33      ; "DiceRoller"
0150    FNEW    10  73      ; dice_roller.lua:276
0151    TSETS   10   9  72  ; "_create_success_table"
0152    GGET     9  33      ; "DiceRoller"
0153    FNEW    10  75      ; dice_roller.lua:300
0154    TSETS   10   9  74  ; "roll_dices"
0155    GGET     9  33      ; "DiceRoller"
0156    FNEW    10  77      ; dice_roller.lua:333
0157    TSETS   10   9  76  ; "simulate_dice_rolls"
0158    GGET     9  33      ; "DiceRoller"
0159    FNEW    10  79      ; dice_roller.lua:413
0160    TSETS   10   9  78  ; "run_simulation"
0161    GGET     9  33      ; "DiceRoller"
0162    FNEW    10  81      ; dice_roller.lua:473
0163    TSETS   10   9  80  ; "calculate_results"
0164    GGET     9  33      ; "DiceRoller"
0165    FNEW    10  83      ; dice_roller.lua:485
0166    TSETS   10   9  82  ; "get_dice_result"
0167    GGET     9  33      ; "DiceRoller"
0168    FNEW    10  85      ; dice_roller.lua:518
0169    TSETS   10   9  84  ; "alter_rotations"
0170    GGET     9  33      ; "DiceRoller"
0171    FNEW    10  87      ; dice_roller.lua:552
0172    TSETS   10   9  86  ; "get_dice_results"
0173    GGET     9  33      ; "DiceRoller"
0174    FNEW    10  89      ; dice_roller.lua:556
0175    TSETS   10   9  88  ; "update"
0176    GGET     9  33      ; "DiceRoller"
0177    FNEW    10  91      ; dice_roller.lua:623
0178    TSETS   10   9  90  ; "cleanup_post_roll"
0179    GGET     9  92      ; "Development"
0180    TGETS    9   9  93  ; "parameter"
0181    KSTR    10  94      ; "dice_chance_simulation"
0182    CALL     9   2   2
0183    ISF          9
0184    JMP     10 => 0325
0185    TNEW     9  37
0186    TDUP    10  95
0187    TSETB   10   9   1
0188    TDUP    10  96
0189    TSETB   10   9   2
0190    TDUP    10  97
0191    TSETB   10   9   3
0192    TDUP    10  98
0193    TSETB   10   9   4
0194    TDUP    10  99
0195    TSETB   10   9   5
0196    TDUP    10 100
0197    TSETB   10   9   6
0198    TDUP    10 101
0199    TSETB   10   9   7
0200    TDUP    10 102
0201    TSETB   10   9   8
0202    TDUP    10 103
0203    TSETB   10   9   9
0204    TDUP    10 104
0205    TSETB   10   9  10
0206    TDUP    10 105
0207    TSETB   10   9  11
0208    TDUP    10 106
0209    TSETB   10   9  12
0210    TDUP    10 107
0211    TSETB   10   9  13
0212    TDUP    10 108
0213    TSETB   10   9  14
0214    TDUP    10 109
0215    TSETB   10   9  15
0216    TDUP    10 110
0217    TSETB   10   9  16
0218    TDUP    10 111
0219    TSETB   10   9  17
0220    TDUP    10 112
0221    TSETB   10   9  18
0222    TDUP    10 113
0223    TSETB   10   9  19
0224    TDUP    10 114
0225    TSETB   10   9  20
0226    TDUP    10 115
0227    TSETB   10   9  21
0228    TDUP    10 116
0229    TSETB   10   9  22
0230    TDUP    10 117
0231    TSETB   10   9  23
0232    TDUP    10 118
0233    TSETB   10   9  24
0234    TDUP    10 119
0235    TSETB   10   9  25
0236    TDUP    10 120
0237    TSETB   10   9  26
0238    TDUP    10 121
0239    TSETB   10   9  27
0240    TDUP    10 122
0241    TSETB   10   9  28
0242    TDUP    10 123
0243    TSETB   10   9  29
0244    TDUP    10 124
0245    TSETB   10   9  30
0246    TDUP    10 125
0247    TSETB   10   9  31
0248    TDUP    10 126
0249    TSETB   10   9  32
0250    TDUP    10 127
0251    TSETB   10   9  33
0252    TDUP    10 128
0253    TSETB   10   9  34
0254    TDUP    10 129
0255    TSETB   10   9  35
0256    TDUP    10 130
0257    TSETB   10   9  36
0258    TDUP    10 131
0259    TNEW    11   0
0260    KSHORT  12  20
0261    KSHORT  13   1
0262    LEN     14   9
0263    KSHORT  15   1
0264    FORI    13 => 0325
0265 => TGETV   17   9  16
0266    TNEW    18   0
0267    KSHORT  19   1
0268    MOV     20  12
0269    KSHORT  21   1
0270    FORI    19 => 0299
0271 => KSHORT  23   0
0272    KSHORT  24   1
0273    KSHORT  25   4
0274    KSHORT  26   1
0275    FORI    24 => 0290
0276 => TGETV   28  17  27
0277    TGETV   29  10  27
0278    KSHORT  30   1
0279    MOV     31  28
0280    KSHORT  32   1
0281    FORI    30 => 0289
0282 => GGET    34   5      ; "math"
0283    TGETS   34  34 132  ; "random"
0284    CALL    34   2   1
0285    ISGE    34  29
0286    JMP     34 => 0288
0287    ADDVN   23  23   2  ; 1
0288 => FORL    30 => 0282
0289 => FORL    24 => 0276
0290 => TGETV   24  18  23
0291    IST         24
0292    JMP     24 => 0295
0293    KSHORT  24   0
0294    TSETV   24  18  23
0295 => TGETV   24  18  23
0296    ADDVN   24  24   2  ; 1
0297    TSETV   24  18  23
0298    FORL    19 => 0271
0299 => KSHORT  19   0
0300    KSHORT  20   7
0301    KSHORT  21   1
0302    FORI    19 => 0317
0303 => TGETV   23  18  22
0304    ISF         23
0305    JMP     24 => 0316
0306    GGET    23   5      ; "math"
0307    TGETS   23  23 133  ; "round_with_precision"
0308    TGETV   24  18  22
0309    DIVVV   24  24  12
0310    MULVN   24  24   3  ; 100
0311    KSHORT  25   3
0312    CALL    23   2   3
0313    KSTR    24 134      ; "%"
0314    CAT     23  23  24
0315    TSETV   23  18  22
0316 => FORL    19 => 0303
0317 => GGET    19 135      ; "print"
0318    KSTR    20 136      ; "-----"
0319    CALL    19   1   2
0320    GGET    19 137      ; "table"
0321    TGETS   19  19 138  ; "dump"
0322    MOV     20  18
0323    CALL    19   1   2
0324    FORL    13 => 0265
0325 => UCLO     0 => 0326
0326 => RET0     0   1

