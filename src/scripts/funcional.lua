-- Funções de alta ordem
function aplicar(f, x)
	return f(x)
end

function dobro(n)
	return n * 2
end
print(aplicar(dobro, 5)) -- Saída: 10

-- Funções Lambda
local quadrado = function(x)
	return x * x
end
print(quadrado(6)) -- Saída: 36
