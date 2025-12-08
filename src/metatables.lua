--[[
================================================================================
    METATABELAS (METATABLES) EM LUA - EXPLICAÇÃO COMPLETA
================================================================================

    O QUE É UMA METATABELA? 
    
    Imagine que uma TABELA em Lua é uma CAIXA. 
    Uma METATABELA é um "MANUAL DE INSTRUÇÕES" que você gruda nessa caixa,
    dizendo: "Quando alguém tentar fazer X com essa caixa, faça Y."

================================================================================
--]]

print("=" :rep(60))
print("TUTORIAL DE METATABELAS EM LUA")
print("=":rep(60))


--[[
--------------------------------------------------------------------------------
PARTE 1: SEM METATABELA (COMPORTAMENTO NORMAL)
--------------------------------------------------------------------------------
--]]

print("\n[PARTE 1] Sem metatabela - Lua não sabe somar tabelas")

local caixa1 = { valor = 10 }
local caixa2 = { valor = 20 }

-- Se você descomentar a linha abaixo, vai dar ERRO!
-- Lua não sabe somar duas tabelas por padrão. 
-- local resultado = caixa1 + caixa2  -- ERRO!

print("caixa1. valor = " .. caixa1.valor)
print("caixa2.valor = " .. caixa2.valor)
print("Tentar somar caixa1 + caixa2 daria erro!")


--[[
--------------------------------------------------------------------------------
PARTE 2: COM METATABELA - ENSINANDO LUA A SOMAR TABELAS
--------------------------------------------------------------------------------

Metamétodos comuns:
    __add       -> quando usa +
    __sub       -> quando usa -
    __mul       -> quando usa *
    __div       -> quando usa /
    __eq        -> quando usa ==
    __lt        -> quando usa <
    __le        -> quando usa <=
    __tostring  -> quando usa print() ou tostring()
    __index     -> quando acessa algo que NAO EXISTE
    __newindex  -> quando tenta CRIAR algo novo
    __call      -> quando tenta CHAMAR como funcao

--------------------------------------------------------------------------------
--]]

print("\n" ..  "=":rep(60))
print("[PARTE 2] Com metatabela - Ensinando Lua a somar tabelas")
print("=":rep(60))

-- Criamos o "manual de instrucoes" (metatabela)
local manual_soma = {
    -- __add diz o que fazer quando alguem usar "+"
    __add = function(a, b)
        return { valor = a.valor + b.valor }
    end
}

-- Criamos novas caixas
local caixaA = { valor = 10 }
local caixaB = { valor = 20 }

-- Grudamos o manual na caixaA
setmetatable(caixaA, manual_soma)

-- Agora funciona! 
local resultado = caixaA + caixaB
print("caixaA.valor = " .. caixaA.valor)
print("caixaB.valor = " .. caixaB.valor)
print("caixaA + caixaB = " .. resultado. valor)


--[[
--------------------------------------------------------------------------------
PARTE 3: METAMÉTODO __tostring - PERSONALIZANDO O PRINT
--------------------------------------------------------------------------------
--]]

print("\n" .. "=":rep(60))
print("[PARTE 3] __tostring - Personalizando o print()")
print("=":rep(60))

local pessoa = {
    nome = "Joao",
    idade = 25
}

-- Sem metatabela, print mostra algo feio tipo "table: 0x12345"
print("Sem __tostring: " .. tostring(pessoa))

-- Com metatabela, podemos personalizar
local manual_pessoa = {
    __tostring = function(p)
        return "Pessoa: " ..  p.nome .. ", " .. p.idade ..  " anos"
    end
}

setmetatable(pessoa, manual_pessoa)
print("Com __tostring: " .. tostring(pessoa))


--[[
--------------------------------------------------------------------------------
PARTE 4: O MAIS IMPORTANTE - __index
--------------------------------------------------------------------------------

__index e o metamétodo que permite fazer "heranca"! 

Quando voce acessa algo que NAO EXISTE na tabela, Lua olha o __index
da metatabela para saber onde procurar. 

Fluxo:
    1. Lua procura "latir" dentro de "rex"
    2. Nao encontra
    3. Olha o manual (metatabela)
    4. Ve __index = ModeloCachorro
    5. Procura "latir" em ModeloCachorro
    6. Encontra e executa! 

--------------------------------------------------------------------------------
--]]

print("\n" ..  "=":rep(60))
print("[PARTE 4] __index - O segredo da heranca em Lua")
print("=":rep(60))

-- O "modelo" de cachorro (seria como uma "classe")
local ModeloCachorro = {
    raca = "Vira-lata",
    latir = function(self)
        print(self.nome .. " diz: Au au!")
    end,
    correr = function(self)
        print(self.nome .. " esta correndo!")
    end
}

-- Um cachorro especifico (seria como um "objeto")
local rex = {
    nome = "Rex"
    -- Note que rex NAO tem "latir" nem "raca"
}

-- O manual diz: "se nao achar algo no rex, procura no ModeloCachorro"
setmetatable(rex, { __index = ModeloCachorro })

print("rex.nome = " .. rex. nome)           -- "Rex" (existe em rex)
print("rex.raca = " .. rex.raca)           -- "Vira-lata" (vem do ModeloCachorro)
rex:latir()                                 -- "Rex diz: Au au!"
rex:correr()                                -- "Rex esta correndo!"


--[[
--------------------------------------------------------------------------------
PARTE 5: __newindex - CONTROLANDO A CRIACAO DE NOVOS CAMPOS
--------------------------------------------------------------------------------
--]]

print("\n" .. "=":rep(60))
print("[PARTE 5] __newindex - Controlando criacao de campos")
print("=":rep(60))

local dados_protegidos = {
    senha = "123456"
}

local manual_protecao = {
    __newindex = function(tabela, chave, valor)
        print("BLOQUEADO! Voce tentou criar '" .. chave .. "' = " .. tostring(valor))
        print("Esta tabela nao permite novos campos!")
        -- Se quisesse permitir, faria: rawset(tabela, chave, valor)
    end
}

setmetatable(dados_protegidos, manual_protecao)

-- Tentar criar um novo campo sera bloqueado
dados_protegidos. novo_campo = "teste"

-- Mas campos que ja existem podem ser alterados
dados_protegidos.senha = "nova_senha"
print("Senha alterada para: " .. dados_protegidos.senha)


--[[
--------------------------------------------------------------------------------
PARTE 6: __call - FAZENDO UMA TABELA SER "CHAMAVEL" COMO FUNCAO
--------------------------------------------------------------------------------
--]]

print("\n" .. "=":rep(60))
print("[PARTE 6] __call - Tabela como funcao")
print("=":rep(60))

local somador = {
    valor_base = 10
}

local manual_call = {
    __call = function(self, numero)
        return self.valor_base + numero
    end
}

setmetatable(somador, manual_call)

-- Agora podemos "chamar" a tabela como se fosse uma funcao! 
local resultado1 = somador(5)   -- 10 + 5 = 15
local resultado2 = somador(20)  -- 10 + 20 = 30

print("somador(5) = " .. resultado1)
print("somador(20) = " .. resultado2)


--[[
--------------------------------------------------------------------------------
PARTE 7: EXEMPLO PRATICO - CRIANDO UM SISTEMA DE "CLASSES"
--------------------------------------------------------------------------------

Este e o padrao mais comum em Lua para simular orientacao a objetos! 

--------------------------------------------------------------------------------
--]]

print("\n" ..  "=":rep(60))
print("[PARTE 7] Exemplo Pratico - Sistema de Jogador")
print("=":rep(60))

-- "Classe" Jogador
local Jogador = {
    vida = 100,
    ataque = 10
}

-- Metodo construtor
function Jogador:novo(nome)
    local novoJogador = {
        nome = nome,
        vida = self.vida,  -- Copia o valor padrao
        ataque = self.ataque
    }
    
    -- Define Jogador como o "pai" deste novo jogador
    setmetatable(novoJogador, { __index = self })
    
    return novoJogador
end

-- Metodos da "classe"
function Jogador:atacar(alvo)
    print(self.nome .. " atacou " .. alvo.nome ..  "!")
    alvo. vida = alvo. vida - self.ataque
    print(alvo.nome .. " agora tem " ..  alvo.vida ..  " de vida")
end

function Jogador:status()
    print("--- " .. self.nome ..  " ---")
    print("Vida: " .. self.vida)
    print("Ataque: " .. self.ataque)
end

-- Criando jogadores
local player1 = Jogador:novo("Guerreiro")
local player2 = Jogador:novo("Mago")

-- Personalizando o mago
player2. ataque = 15

print("\n> Status inicial:")
player1:status()
player2:status()

print("\n> Batalha:")
player2:atacar(player1)
player1:atacar(player2)

print("\n> Status final:")
player1:status()
player2:status()


--[[
--------------------------------------------------------------------------------
PARTE 8: HERANCA - UMA CLASSE HERDANDO DE OUTRA
--------------------------------------------------------------------------------
--]]

print("\n" .. "=":rep(60))
print("[PARTE 8] Heranca - Classe Guerreiro herda de Jogador")
print("=":rep(60))

-- "Classe" Guerreiro que herda de Jogador
local Guerreiro = Jogador:novo("TemplateGuerreiro")
Guerreiro. ataque = 20
Guerreiro. defesa = 5

function Guerreiro:novo(nome)
    local novoGuerreiro = Jogador. novo(self, nome)
    novoGuerreiro.defesa = self.defesa
    return novoGuerreiro
end

function Guerreiro:defender()
    print(self.nome .. " levantou o escudo!  (+" .. self.defesa .. " defesa)")
end

-- Criando um guerreiro
local conan = Guerreiro:novo("Conan")

print("\n> Guerreiro Conan:")
conan:status()        -- Metodo herdado de Jogador
conan:defender()      -- Metodo proprio de Guerreiro
print("Defesa: " .. conan.defesa)


--[[
================================================================================
RESUMO FINAL
================================================================================

METATABELA = Um conjunto de instrucoes que diz ao Lua o que fazer em
             situacoes especiais (somar, comparar, acessar coisas que
             nao existem, etc.)

Funcoes principais:
    setmetatable(tabela, metatabela)  -> Define a metatabela
    getmetatable(tabela)              -> Retorna a metatabela

Metamétodos mais usados:
    __index     -> Heranca e acesso a campos inexistentes
    __newindex  -> Controle de criacao de campos
    __add       -> Sobrecarga do operador +
    __tostring  -> Personalizacao do print()
    __call      -> Fazer tabela ser chamavel como funcao

================================================================================
--]]

print("\n" .. "=":rep(60))
print("FIM DO TUTORIAL!")
print("=":rep(60))
print("\nExecute este arquivo com: lua metatables. lua")
