-- Strings are immutable values
a = "one string"
b = string.gsub(a, "one", "another") -- change string parts
print(a) --> one string
print(b) --> another string

-- Lua provides automatic conversions between numbers and strings at run time. Any numeric operation applied to a string tries to convert the string to a number:
print("10" + 1) --> 11
print("10 + 1") --> 10 + 1
print("-5.3e-10" * "2") --> -1.06e-09
print(10 .. 20) --> 1020
--print("hello" + 1) -- ERROR (cannot convert "hello")

print(10 == "10") --> false
-- To convert a number to a string, you can call the function tostring or concatenate the number with the empty string:
print(tostring(10) == "10") --> true
print(10 .. "" == "10") --> true
