local valores = { false, nil, 0, "" }

for i = 1, #valores do
	local valor = valores[i]
	if valor then
		print(i .. ":", tostring(valor), "->true")
	else
		print(i .. ": " .. tostring(valor) .. " ->false")
	end
end

--[[ Saída final esperada:
1: false ->false
2: nil ->false
3: 0 ->true
4:  ->true
]]
