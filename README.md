## 📋 Descrição dos Scripts

Este projeto contém uma série de scripts Lua que demonstram diferentes aspectos e paradigmas da linguagem Lua 5.1.5. Cada script explora conceitos específicos da linguagem de forma prática e didática.

### 📄 Scripts Disponíveis

#### 1. `overview.lua`
**Descrição:** Script introdutório que apresenta os principais comandos, estruturas e funcionalidades básicas da linguagem Lua. Demonstra conceitos fundamentais como:
- Comentários (linha e bloco)
- Variáveis e tipos básicos
- Operadores aritméticos e lógicos
- Estruturas de controle (if, for, while, repeat)
- Funções (nomeadas e anônimas)
- Tabelas (arrays e dicionários)
- Metatabelas básicas
- Programação Orientada a Objetos simples
- Manipulação de strings
- Corrotinas básicas

#### 2. `types_scope.lua`
**Descrição:** Explora aspectos fundamentais do sistema de tipos e escopo em Lua:
- **Tipagem dinâmica:** Demonstra como Lua associa tipos aos valores, não às variáveis
- **Escopo léxico (estático):** Exemplos de variáveis locais e globais, e como o escopo é determinado pela estrutura textual do código
- **Vinculação profunda (deep binding):** Mostra como funções capturam variáveis do contexto léxico onde foram declaradas (closures)
- **Controle de fluxo:** Exemplos práticos de estruturas condicionais e loops
- **Múltiplos retornos:** Demonstra como funções podem retornar múltiplos valores

#### 3. `logical.lua`
**Descrição:** Implementa um sistema básico de programação lógica em Lua, demonstrando:
- Representação de termos (átomos, variáveis, predicados)
- Sistema de unificação
- Base de conhecimento com fatos e regras
- Mecanismo de inferência usando backward chaining (encadeamento para trás)
- Consultas lógicas com múltiplas soluções
- Exemplo prático de árvore genealógica com regras recursivas

#### 4. `functional.lua`
**Descrição:** Demonstra conceitos de programação funcional em Lua:
- **Funções de alta ordem:** Implementação de `map` que recebe funções como argumentos
- **Funções anônimas:** Uso de lambdas para criar funções inline
- **Recursão:** Exemplo de fatorial com suporte a tail calls
- **Pattern matching:** Emulação de pattern matching usando tabelas de casos

#### 5. `oop_tests.lua`
**Descrição:** Explora a programação orientada a objetos em Lua usando metatabelas:
- **Encapsulamento:** Implementação de campos privados usando closures
- **Herança simples:** Como simular herança usando metatabelas
- **Polimorfismo:** Sobrescrita de métodos em classes derivadas
- **Mixins:** Simulação de herança múltipla
- **Composição:** Relacionamento "tem-um" entre objetos

#### 6. `garbage_collector.lua`
**Descrição:** Explica e demonstra o sistema de gerenciamento de memória em Lua:
- **Estrutura de memória:** Diferença entre stack (pilha) e heap
- **Garbage Collection (GC):** Como o coletor de lixo incremental funciona
- **Funções do GC:** Uso de `collectgarbage()` para monitorar e controlar a coleta
- **Quando objetos são coletados:** Exemplos práticos de quando a memória é liberada

## 🚀 Comandos para Executar

### Pré-requisitos
Certifique-se de ter o interpretador Lua instalado. Você pode verificar com:
```bash
lua -v
```

### Executando os Scripts

Para executar cada script, use o comando `lua` seguido do caminho do arquivo:

#### 1. Overview (Visão Geral)
```bash
lua src/scripts/overview.lua
```

#### 2. Tipos e Escopo
```bash
lua src/scripts/types_scope.lua
```

#### 3. Programação Funcional
```bash
lua src/scripts/functional.lua
```

#### 4. Testes de POO
```bash
lua src/scripts/oop_tests.lua
```

#### 5. Programação Lógica
```bash
lua src/scripts/logical.lua
```

#### 6. Garbage Collector
```bash
lua src/scripts/garbage_collector.lua
```

## 📝 Notas

- Todos os scripts foram testados com **Lua 5.1.5**
- Os scripts são independentes e podem ser executados separadamente
- Cada script contém comentários explicativos em português
- Os exemplos são práticos e demonstram conceitos reais de uso da linguagem

## 🔗 Estrutura do Projeto

```
lua-language-analysis/
├── README.md
└── src/
    └── scripts/
        ├── overview.lua
        ├── types_scope.lua
        ├── functional.lua
        ├── oop_tests.lua
        ├── logical.lua
        └── garbage_collector.lua
```
