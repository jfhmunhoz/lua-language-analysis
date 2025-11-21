-- variables.lua
-- Exemplos de declaração, tipos dinâmicos, controle de fluxo
-- Versão da linguagem: Lua 5.1.5.

------------------------------------------------------------
-- 1) Variáveis e sistema de tipos
------------------------------------------------------------
-- Lua utiliza TIPAGEM DINÂMICA: o tipo é associado ao valor, não à variável.
-- Não há anotação de tipos e não existe inferência estática.
-- O tipo é determinado em tempo de execução.
-- Tipos básicos: nil, boolean, number, string, table, function, userdata, thread.
-- Variáveis são criadas com atribuição; sem declaração prévia.

print("--------------------------------")
print("1) Variaveis e sistema de tipos (dinamico)")

local x = 10  -- 'x' armazena um number
print("Valor:", x, "| Tipo:", type(x))

x = "Agora sou uma string" -- agora 'x' armazena uma string
print("Valor:", x, "| Tipo:", type(x))

x = true -- agora é um boolean
print("Valor:", x, "| Tipo:", type(x))

------------------------------------------------------------
-- 2) Escopo (estático / léxico)
------------------------------------------------------------
-- Lua utiliza ESCOPO ESTÁTICO:
-- O escopo é determinado pela estrutura textual do código.
-- 'local' cria variáveis locais — preferível para evitar colisões.
-- Variáveis sem 'local' tornam-se globais.

print("--------------------------------")
print("2) Escopo (lexico)")

local function exemploEscopo()
    local a = 5
    do
        local a = 10  -- outro 'a', válido apenas dentro do bloco
        print("Valor de a dentro do bloco:", a)
    end
    print("Valor de a fora do bloco:", a)
end
exemploEscopo()

------------------------------------------------------------
-- 3) Sistema de avaliação (vinculação profunda ou rasa)
------------------------------------------------------------
-- Lua utiliza AVALIAÇÃO POR VINCULAÇÃO PROFUNDA (deep binding):
-- Funções fecham sobre o ambiente léxico onde foram declaradas.
-- Ou seja, capturam variáveis do contexto original.

print("--------------------------------")
print("3) Vinculacao profunda (deep binding)")

local function criarContador()
    local count = 0  -- variável do escopo léxico
    return function()
        count = count + 1
        return count
    end
end

local c1 = criarContador()
print(c1())  -- 1
print(c1())  -- 2
print(c1())  -- 3 (mantém estado porque capturou 'count')

------------------------------------------------------------
-- 4) Controle de fluxo
------------------------------------------------------------
print("--------------------------------")
print("4) Controle de fluxo")

for i = 1, 5 do
    if i % 2 == 0 then
        print(i, "par")
    else
        print(i, "impar")
    end
end

------------------------------------------------------------
-- 5) Função com múltiplos retornos
------------------------------------------------------------
print("--------------------------------")
print("5) Funcao com multiplos retornos")

local function dividir(a, b)
    if b == 0 then return nil, "divisão por zero" end
    return a / b, nil
end

local q, err = dividir(10, 2)
print("10/2 =", q, err)
print("--------------------------------")