-- Fansware loader (v3.1) — fetches parts and runs
local base = "https://raw.githubusercontent.com/Fansware/something2/main/"
local function get(path)
    return game:HttpGet(base .. path)
end
local src = get("part1.luau") .. get("part2.luau") .. get("part3.luau")
assert(#src > 1000, "Fansware fetch failed")
loadstring(src)()
