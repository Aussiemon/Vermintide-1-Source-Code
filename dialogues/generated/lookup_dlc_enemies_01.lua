assert(DialogueLookup[DialogueLookup_n + 1] == nil)
assert(DialogueLookup[DialogueLookup_n + 2] == nil)
assert(DialogueLookup[DialogueLookup_n + 3] == nil)
assert(DialogueLookup[DialogueLookup_n + 4] == nil)
assert(DialogueLookup[DialogueLookup_n + 5] == nil)

DialogueLookup[DialogueLookup_n + 1] = "pwh_gameplay_seeing_a_scr"
DialogueLookup[DialogueLookup_n + 2] = "pes_gameplay_seeing_a_scr"
DialogueLookup[DialogueLookup_n + 3] = "pbw_gameplay_seeing_a_scr"
DialogueLookup[DialogueLookup_n + 4] = "pdr_gameplay_seeing_a_scr"
DialogueLookup[DialogueLookup_n + 5] = "pwe_gameplay_seeing_a_scr"
DialogueLookup_n = DialogueLookup_n + 5

return 
