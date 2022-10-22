-- 0tto#3949 

Config = {} 

Config.SkeletalSystem = true -- If you're using Mod Freakz skeletal system (It heals all bones)

Config.locale = {
    ["enter_bed"] = "~g~E~w~ - To lie on the bed",
    ["progress_label"] = "You're being helped...",
}

Config.settings = {
    ["healing_time"] = 120, -- Seconds
    ["heal_amount"] = 50, -- Health given when "healed"
}

Config.beds = {
    ["pillbox-1"] = {["pos"] = vector4(317.79, -585.6, 44.2, -15.0), ["busy"] = false},
    ["pillbox-2"] = {["pos"] = vector4(322.63, -587.2, 44.2, -15.0), ["busy"] = false},
    ["pillbox-3"] = {["pos"] = vector4(314.48, -584.22, 44.2, -15.0), ["busy"] = false},
    ["pillbox-4"] = {["pos"] = vector4(311.08, -582.91, 44.2, -15.0), ["busy"] = false},
    ["pillbox-5"] = {["pos"] = vector4(307.68, -581.77, 44.2, -15.0), ["busy"] = false},
    ["pillbox-6"] = {["pos"] = vector4(324.14, -583.06, 44.2, 175.0), ["busy"] = false},
    ["pillbox-7"] = {["pos"] = vector4(319.34, -581.16, 44.2, 175.0), ["busy"] = false},
    ["pillbox-8"] = {["pos"] = vector4(313.87, -579.23, 44.2, 175.0), ["busy"] = false},
    ["pillbox-9"] = {["pos"] = vector4(309.33, -577.63, 44.2, 175.0), ["busy"] = false},
}