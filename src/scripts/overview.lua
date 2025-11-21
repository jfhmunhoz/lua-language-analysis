-- guia_basico.lua
-- Demonstração dos principais comandos, estruturas e funcionalidades da linguagem Lua
-- Versão da linguagem: Lua 5.1.5.
------------------------------------------------------------
-- 1) Comentários
------------------------------------------------------------
-- Comentário de linha
--[[ Comentário de bloco ]]

------------------------------------------------------------
-- 2) Variáveis e Tipos
------------------------------------------------------------
x = 10
nome = "Luccas"
ativo = true

print("x:", x, "nome:", nome, "ativo:", ativo)

------------------------------------------------------------
-- 3) Operadores
------------------------------------------------------------
print("5 > 3:", 5 > 3)
print("true and false:", true and false)

------------------------------------------------------------
-- 4) Estruturas de Controle
------------------------------------------------------------
idade = 20
-- Comando If
if idade >= 18 then
    print("Maior de idade")
else
    print("Menor de idade")
end

-- Comando For
for i = 1, 5 do
    print("For:", i)
end

-- Comando While
x = 1
while x <= 3 do
    print("While:", x)
    x = x + 1
end

y = 1
-- Comando Repeat
repeat
    print("Repeat:", y)
    y = y + 1
until y > 3

------------------------------------------------------------
-- 5) Funções
------------------------------------------------------------
function soma(a, b)
    return a + b
end
print("Soma 3 + 4 =", soma(3, 4))

f = function(x) return x * 2 end
print("Função anônima:", f(10))

------------------------------------------------------------
-- 6) Tabelas
------------------------------------------------------------
pessoa = {nome = "Ana", idade = 25}
print("Pessoa:", pessoa.nome, pessoa.idade)

nums = {10, 20, 30}
table.insert(nums, 40)
print("Array:", nums[1], nums[2], nums[3], nums[4])

------------------------------------------------------------
-- 7) Metatabelas
------------------------------------------------------------
mt = {
    __add = function(a, b)
        return a.valor + b.valor
    end
}

A = {valor = 10}
B = {valor = 5}
setmetatable(A, mt)
setmetatable(B, mt)
print("A + B =", A + B)

------------------------------------------------------------
-- 8) POO Simples
------------------------------------------------------------
Pessoa = {}
Pessoa.__index = Pessoa

function Pessoa.new(nome, idade)
    return setmetatable({nome = nome, idade = idade}, Pessoa)
end

p1 = Pessoa.new("Luccas", 24)
print("Pessoa:", p1.nome, p1.idade)

------------------------------------------------------------
-- 9) Strings
------------------------------------------------------------
s = "Lua"
print("Tamanho:", #s)
print("Upper:", s:upper())
print("Sub:", string.sub(s, 1, 2))

------------------------------------------------------------
-- 10) Corrotinas
------------------------------------------------------------
co = coroutine.create(function()
    for i = 1, 3 do
        print("Coroutine step:", i)
        coroutine.yield()
    end
end)

coroutine.resume(co)
coroutine.resume(co)
coroutine.resume(co)

print("--- Fim do arquivo demonstrativo ---")
