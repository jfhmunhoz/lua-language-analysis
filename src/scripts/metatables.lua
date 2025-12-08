t = {}
print(getmetatable(t)) --> nil

t1 = {}
setmetatable(t, t1)
print(getmetatable(t) == t1) --> true

Set = {}
local mt = {}
function Set.new(l)
	local set = {}
	setmetatable(set, mt)
	for _, v in ipairs(l) do
		set[v] = true
	end
	return set
end
function Set.union(a, b)
	if getmetatable(a) ~= mt or getmetatable(b) ~= mt then
		error("só é possível somar conjuntos")
	end
	local res = Set.new({})
	for k in pairs(a) do
		res[k] = true
	end
	for k in pairs(b) do
		res[k] = true
	end
	return res
end
mt.__add = Set.union

s1 = Set.new({ 1, 2, 3 })
s2 = Set.new({ 2, 3, 4 })
s3 = s1 + s2 -- união
