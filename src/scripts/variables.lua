-- variables.lua
-- Exemplos de declaração, tipos dinâmicos, controle de fluxo
-- Versão da linguagem: Lua 5.1.5.

------------------------------------------------------------
-- 1) Variáveis e tipos dinamicos

-- As variáveis não têm um tipo fixo definido em tempo de compilação; em vez disso, 
-- elas podem armazenar valores de qualquer tipo, e o tipo real é verificado em tempo de execução.
------------------------------------------------------------

print("--------------------------------")
print("1) Variaveis e tipos dinamicos")
local x = 10
print("Valor:", x, "| Tipo:", type(x))

x = "Agora sou uma string"
print("Valor:", x, "| Tipo:", type(x))

x = true
print("Valor:", x, "| Tipo:", type(x))

-- 2) Controle de fluxo
print("--------------------------------")
print("2) Controle de fluxo")
for i=1,5 do
    if i % 2 == 0 then
    print(i, "par")
    else
    print(i, "impar")
    end
    end
    
-- função com múltiplos retornos
local function dividir(a,b)
if b == 0 then return nil, "divisão por zero" end
return a/b, nil
end


local q, err = dividir(10,2)
print("10/2 =", q, err)
print("--------------------------------")