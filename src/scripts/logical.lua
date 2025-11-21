-- logica_basica.lua
-- Exemplo simples de programação lógica em Lua
-- Definição de fatos, regras e um mecanismo básico de inferência (backward chaining)
-- Versão da linguagem: Lua 5.1.5.

-- Representação de termos:
-- Átomos: strings minúsculas ou números: "joao", "maria"
-- Variáveis: strings que começam com letra maiúscula: "X", "Quem"
-- Predicados compostos: tabela {pred = "nome", args = {arg1, arg2, ...}}
-- Exemplo: {pred="pai", args={"joao","maria"}}

-- Helpers para criar termos
function P(name, ...)
    local args = {...}
    return {pred = name, args = args}
end

function is_variable(x)
    if type(x) ~= "string" then return false end
    local c = string.sub(x,1,1)
    return c:match("%u") ~= nil -- começa com maiúscula
end

-- Unificação com ambiente (substituições)
-- env é tabela mapeando variável -> valor
function env_lookup(env, v)
    -- procura encadeada de variáveis (para casos como X = Y, Y = a)
    local val = env[v]
    if val == nil then return nil end
    if type(val) == "string" and is_variable(val) and env[val] ~= nil then
        return env_lookup(env, val)
    end
    return val
end

function extend_env(env, var, val)
    local new = {}
    for k, v in pairs(env) do new[k] = v end
    new[var] = val
    return new
end

-- unifica dois termos com um dado ambiente; retorna novo ambiente ou nil se falhar
function unify(t1, t2, env)
    env = env or {}
    -- resolve variáveis já ligadas
    if type(t1) == "string" and is_variable(t1) then
        local v1 = env_lookup(env, t1) or t1
        t1 = v1
    end
    if type(t2) == "string" and is_variable(t2) then
        local v2 = env_lookup(env, t2) or t2
        t2 = v2
    end

    -- casos: variável com algo
    if type(t1) == "string" and is_variable(t1) then
        return extend_env(env, t1, t2)
    end
    if type(t2) == "string" and is_variable(t2) then
        return extend_env(env, t2, t1)
    end

    -- ambos são átomos (strings/numbers)
    if (type(t1) == "string" or type(t1) == "number") and (type(t2) == "string" or type(t2) == "number") then
        if t1 == t2 then return env else return nil end
    end

    -- ambos são predicados compostos
    if type(t1) == "table" and type(t2) == "table" then
        if t1.pred ~= t2.pred or #t1.args ~= #t2.args then return nil end
        local cur_env = env
        for i = 1, #t1.args do
            cur_env = unify(t1.args[i], t2.args[i], cur_env)
            if cur_env == nil then return nil end
        end
        return cur_env
    end

    return nil
end

-- Base de conhecimento: fatos e regras
KB = { facts = {}, rules = {} }

function add_fact(fact)
    table.insert(KB.facts, fact)
end

-- regra: {head = P(...), body = {goal1, goal2, ...}}
function add_rule(head, body)
    table.insert(KB.rules, {head = head, body = body})
end

-- Prova (backward chaining)
-- goal: termo a provar (ex: P("pai","joao","Quem"))
-- env: ambiente de unificação atual
-- retorna um gerador (função que produz soluções via fechamento)
function prove(goal, env)
    env = env or {}
    local idx_fact = 1
    local idx_rule = 1
    local state = {stage = "facts"}

    return coroutine.wrap(function()
        -- Tentar fatos
        for i, fact in ipairs(KB.facts) do
            local e = unify(goal, fact, env)
            if e then
                coroutine.yield(e)
            end
        end
        -- Tentar regras
        for i, rule in ipairs(KB.rules) do
            -- tentar unificar objetivo com a cabeça da regra
            local e_head = unify(goal, rule.head, env)
            if e_head then
                -- precisamos provar o corpo sequencialmente com backtracking
                local solutions = { e_head }
                local function prove_body(goals, envs, pos)
                    pos = pos or 1
                    if pos > #goals then
                        -- todas provadas: retorna as envs
                        for _, en in ipairs(envs) do coroutine.yield(en) end
                        return
                    end
                    -- para cada ambiente atual, tente provar goals[pos]
                    for _, curenv in ipairs(envs) do
                        -- substitui variáveis no goal antes de chamar prove (não implementamos substituição estrutural completa,
                        -- deixamos a unificação cuidar durante prove)
                        local g = goals[pos]
                        -- gerar soluções para este subgoal usando prove recursivamente
                        for sol in prove(substitute(g, curenv), curenv) do
                            prove_body(goals, {sol}, pos + 1) -- continua com próximo objetivo usando apenas a solução atual
                        end
                    end
                end
                -- chamar prover corpo
                prove_body(rule.body, {e_head}, 1)
            end
        end
    end)
end

-- substitui variáveis nos argumentos de um goal usando env (aplica env ao termo)
function substitute(term, env)
    if type(term) == "string" then
        if is_variable(term) then
            local val = env_lookup(env, term)
            if val == nil then return term else return val end
        else
            return term
        end
    elseif type(term) == "table" then
        local newargs = {}
        for i, a in ipairs(term.args) do
            newargs[i] = substitute(a, env)
        end
        return {pred = term.pred, args = newargs}
    else
        return term
    end
end

-- Função de consulta (query). Recebe um goal e imprime soluções encontradas.
function query(goal)
    print("Consulta:", pretty_term(goal))
    local found = false
    local gen = prove(goal, {})
    local n = 0
    for sol in gen do
        n = n + 1
        found = true
        print("Solucao " .. n .. ":")
        print_env(sol)
    end
    if not found then print("Nenhuma solucao encontrada.") end
    print("---- Fim da consulta ----\n")
end

function print_env(env)
    for k, v in pairs(env) do
        print("  " .. k .. " = " .. pretty_term(v))
    end
end

function pretty_term(t)
    if type(t) == "string" then return t end
    if type(t) == "number" then return tostring(t) end
    if type(t) == "table" then
        local s = t.pred .. "("
        for i=1,#t.args do
            s = s .. pretty_term(t.args[i])
            if i < #t.args then s = s .. ", " end
        end
        s = s .. ")"
        return s
    end
    return tostring(t)
end

-- --------------------------------------------------
-- Exemplo de Base de Conhecimento (Árvore genealógica)
-- --------------------------------------------------
-- Fatos
add_fact(P("pai", "joao", "maria"))
add_fact(P("pai", "joao", "ana"))
add_fact(P("pai", "carlos", "joao"))
add_fact(P("pai", "pedro", "carlos"))
add_fact(P("mae", "maria", "lucas"))

-- Regras
-- avo(X, Z) :- pai(X, Y), pai(Y, Z).
add_rule(P("avo", "X", "Z"), { P("pai", "X", "Y"), P("pai", "Y", "Z") })

-- avo_materno(X, Z) :- mae(X, Y), mae(Y, Z).
add_rule(P("avo_materno", "X", "Z"), { P("mae", "X", "Y"), P("mae", "Y", "Z") })

-- avo_combined(X,Z) :- pai(X,Y), mae(Y,Z).
add_rule(P("avo_mix", "X", "Z"), { P("pai", "X", "Y"), P("mae", "Y", "Z") })

-- descendente/2 recursiva: descendente(X, Y) :- pai(X, Y). descendente(X, Y) :- pai(X, Z), descendente(Z, Y).
add_rule(P("descendente", "X", "Y"), { P("pai", "X", "Y") })
add_rule(P("descendente", "X", "Y"), { P("pai", "X", "Z"), P("descendente", "Z", "Y") })

-- --------------------------------------------------
-- Consultas de exemplo
-- --------------------------------------------------
-- Quem são os avôs de joao?
query(P("avo", "Quem", "joao"))

-- Quem é avô de ana?
query(P("avo", "Quem", "ana"))

-- Descendentes de pedro
query(P("descendente", "pedro", "Quem"))

-- Avo mix (pai + mae)
query(P("avo_mix", "Quem", "lucas"))

-- Consulta direta com fato
query(P("pai", "joao", "maria"))

-- Consulta sem soluções
query(P("mae", "joao", "Quem"))

-- Fim do script
print("-- Fim do exemplo de programação lógica --")