-- Strings are immutable values
a = "one string"
b = string.gsub(a, "one", "another") -- change string parts
print(a) --> one string
print(b) --> another string

-- Lua provides automatic conversions.
print("10" + 1) --> 11
print("10 + 1") --> 10 + 1
print("-5.3e-10" * "2") --> -1.06e-09
print(10 .. 20) --> 1020
print("hello" + 1) -- ERROR (cannot convert "hello")

print(10 == "10") --> false
-- Converting a number to string
print(tostring(10) == "10") --> true
print(10 .. "" == "10") --> true
