-- Lua is dynamically typed.
-- Eight basic types in Lua: nil, boolean, number, string, userdata, function, thread, and table.

print(type("Hello world")) --> string
print(type(10.4 * 3)) --> number
print(type(print)) --> function
print(type(type)) --> function
print(type(true)) --> boolean
print(type(nil)) --> nil
print(type(type(X))) --> string

print(type(a)) --> nil   (`a' is not initialized)
a = 10
print(type(a)) --> number
a = "a string!!"
print(type(a)) --> string

-- Functions are first class in Lua.
a = print -- yes, this is valid!
a(type(a)) --> function
