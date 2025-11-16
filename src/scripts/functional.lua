-- functional.lua
-- Exemplos de Programação Funcional
-- Versão da linguagem: Lua 5.1.5.

------------------------------------------------------------
-- 1) Funções anônimas e alta-ordem: map

-- Lua suporta a programação funcional, pois permite que funções sejam tratadas como valores. 
-- Isso significa que é possível atribuir funções a variáveis, passá-las como argumentos
-- para outras funções e retorná-las como resultados. 
------------------------------------------------------------

local function map(tbl, fn)
    local out = {}
    for i,v in ipairs(tbl) do out[i] = fn(v) end
    return out
    end
    
    
    local squares = map({1,2,3,4}, function(x) return x*x end)
    for i,v in ipairs(squares) do print(v) end
    
    
    -- recursão (fatorial) — Lua suporta tail calls
    local function fact(n, acc)
    acc = acc or 1
    if n <= 1 then return acc end
    return fact(n-1, acc * n)
    end
    print("5! =", fact(5))
    
    
    -- pattern-matching simples (emulação)
    local function match(value)
    -- emular match usando table de guards
    local cases = {
    ["number"] = function(v) return "é um numero: "..v end,
    ["string"] = function(v) return "é uma string: "..v end,
    }
    local t = type(value)
    if cases[t] then return cases[t](value) end
    return "caso padrao"
    end
    print(match(10))
    print(match("oi"))