-- Fansware loader (v3.1)
local url = "https://raw.githubusercontent.com/Fansware/something2/main/Fansware_v3.1.luau"
local src = game:HttpGet(url)
assert(type(src) == "string" and #src > 1000, "Fansware fetch failed")
loadstring(src)()
