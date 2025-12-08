local arquivo = io.open("teste.txt", "w")
print(type(arquivo)) -- "userdata"
arquivo:write("Olá Lua!")
arquivo:close()
