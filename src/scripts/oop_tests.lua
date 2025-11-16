-- oop_tests.lua
-- Exemplos de Programação Orientada a Objetos
-- Versão da linguagem: Lua 5.1.5.

-- Lua tem suporte à programação orientada a objetos, embora não tenha um sistema de classes nativo como outras linguagens. 
-- A POO em Lua é implementada usando sua estrutura de tabelas e metatabelas, permitindo criar objetos, herança e polimorfismo de forma flexível. 

-- Muitos conceitos de POO em Lua são implementados usando metatabelas.
------------------------------------------------------------
--                METATABELAS EM LUA
-- As metatabelas permitem alterar o comportamento de uma
-- tabela: herança, operadores, impressão, comparação, etc.
-- Elas funcionam como “regras especiais” atribuídas a uma tabela.
------------------------------------------------------------

------------------------------------------------------------
-- 1) Encapsulamento via closure (campo privado)
------------------------------------------------------------

local Counter = {}
Counter.__index = Counter

function Counter.new(initial)
    local private = {value = initial or 0} -- campo privado
    local self = setmetatable({}, Counter)

    function self:inc()
        private.value = private.value + 1
    end

    function self:get()
        return private.value
    end

    return self
end

-- Teste de encapsulamento
local c = Counter.new(5)
c:inc()
print("Counter value (esperado 6):", c:get())

-- Tentando acessar o campo privado (nao funciona)
print("Acessando c.value (esperado nil):", c.value)

------------------------------------------------------------
-- 2) Criando uma classe base Person para heranca
-- Lua não possui herança nativa, mas podemos simular herança usando metatabelas.
------------------------------------------------------------

Person = {}
Person.__index = Person

function Person.new(name, age)
    local self = setmetatable({}, Person)
    self.name = name
    self.age  = age
    return self
end

function Person:greet()
    return "Ola, eu sou " .. self.name
end


------------------------------------------------------------
-- 3) Heranca simples (Employee herda de Person)
------------------------------------------------------------

local Employee = setmetatable({}, {__index = Person})
Employee.__index = Employee

function Employee.new(name, age, role)
    local self = setmetatable(Person.new(name, age), Employee)
    self.role = role
    return self
end

-- Polimorfismo: sobrescrevendo greet()
function Employee:greet()
    return Person.greet(self) .. ", e sou " .. (self.role or "funcionario")
end

-- Teste de heranca e polimorfismo
local e = Employee.new("Luccas", 25, "Desenvolvedor")
print("Employee greet:", e:greet())


------------------------------------------------------------
-- 4) Mixin (heranca multipla simulada)
-- Da mesma forma que a herança simples, a herança multipla pode ser simulada usando metatabelas.
------------------------------------------------------------

local LoggerMixin = {}

function LoggerMixin:log(msg)
    print("[LOG]", msg)
end

-- Aplicando mixin
local dev = Employee.new("Joao Vitor", 22, "Dev Backend")

-- Copia metodos do mixin para o objeto
for k, v in pairs(LoggerMixin) do
    dev[k] = v
end

-- Teste do mixin
dev:log(dev:greet())


------------------------------------------------------------
-- 5) Composicao (Team tem membros)
-- De forma similar, aqui também podemos simular a composição usando metatabelas. 
-- A ideia é que estamos guardando uma tabela dentro de outra tabela.
------------------------------------------------------------

local Team = {}
Team.__index = Team

function Team.new(name)
    return setmetatable({name = name, members = {}}, Team)
end

function Team:add(member)
    table.insert(self.members, member)
end

-- Teste de composicao
local t = Team.new("Equipe A")
t:add(dev)

print("Team:", t.name)
print("Membros da equipe:")
for i, m in ipairs(t.members) do
    print("-", m.name, "(" .. m.role .. ")")
end
