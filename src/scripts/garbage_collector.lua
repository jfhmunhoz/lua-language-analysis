-- memoria_gc.lua
-- Explicação sobre a estrutura de memória e garbage collection em Lua
-- Versão da linguagem: Lua 5.1.5.

------------------------------------------------------------
-- 1) Estrutura de memória em Lua
------------------------------------------------------------
-- Em Lua, a memória é dividida em duas grandes categorias:
--
-- (A) **Stack (pilha)**
--     - Usada para armazenar variáveis locais, parâmetros de funções
--       e valores temporários.
--     - Gerida automaticamente enquanto funções são chamadas ou retornam.
--
-- (B) **Heap**
--     - Região de memória usada para armazenar objetos dinâmicos:
--         * tabelas (tables)
--         * funções (closures)
--         * strings criadas dinamicamente
--         * userdata
--     - Tudo no heap é gerido pelo Garbage Collector (GC).

print("--------------------------------")
print("1) Estrutura de memoria")

local a = 10          -- armazenado na stack
local b = {1, 2, 3}   -- tabela armazenada no heap
local c = function(x) -- função armazenada no heap
    return x * 2
end

print("Variavel local (stack):", a)
print("Tabela (heap):", b[1], b[2], b[3])
print("Funcao (heap):", c(5))

------------------------------------------------------------
-- 2) Garbage Collection (GC) em Lua
------------------------------------------------------------
-- Lua usa um **coletor de lixo incremental** baseado em marcação (mark) e
-- varredura (sweep). Ele funciona automaticamente e identifica objetos que
-- não têm mais referências, liberando a memória.
--
-- Características principais:
--  - Gerenciamento automático de memória.
--  - Sem necessidade de free() ou delete.
--  - O GC roda periodicamente ou pode ser acionado manualmente.
--
-- Funções úteis do GC:
--   collectgarbage("count")  -> retorna memória usada (KB)
--   collectgarbage("collect") -> força um ciclo completo de GC
--   collectgarbage("step", n) -> executa um passo do GC

print("--------------------------------")
print("2) Garbage Collection (GC)")
print("Memoria em uso (KB):", collectgarbage("count"))

-- Criando muitos objetos temporários para ilustrar
for i = 1, 50000 do
    local temp = {i, i+1, i+2} -- criado no heap
end

print("Memoria apos alocacoes (KB):", collectgarbage("count"))

-- Forçando coleta de lixo\collectgarbage("collect")
print("Memoria apos GC (KB):", collectgarbage("count"))

------------------------------------------------------------
-- 3) Quando o GC libera memória?
------------------------------------------------------------
-- Objetos no heap só são coletados quando **nenhuma referência** aponta
-- para eles. Exemplo:

local t = {1, 2, 3} -- tabela no heap
print("Tabela existe:", t[1])

t = nil -- remove a referência

-- Agora a tabela está "órfã" e será coletada pelo GC
collectgarbage("collect")
print("Apos remover referencia, GC coleta a tabela.")

------------------------------------------------------------
-- 4) Conclusão
------------------------------------------------------------
-- Lua possui:
--  * Estrutura de memória simples (stack + heap)
--  * GC automático eficiente
--  * Permite acionamento manual para estudos ou casos específicos
--
print("--------------------------------")
print("Fim do script de memoria e GC.")
