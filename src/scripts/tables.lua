-- The table type implements associative arrays.
-- Tables have no fixed size.
-- Tables are the main (in fact, the only) data structuring mechanism in Lua, and a powerful one.
-- We use tables to represent ordinary arrays, symbol tables, sets, records, queues, and other data structures, in a simple, uniform, and efficient way.
-- Lua uses tables to represent packages as well. When we write io.read, we mean "the read entry from the io package".

-- Tables in Lua are neither values nor variables; they are objects.
-- You do not have to declare a table in Lua; in fact, there is no way to declare one. You create tables by means of a constructor expression, which in its simplest form is written as {}:

a = {} -- create a table and store its reference in `a'
k = "x"
a[k] = 10 -- new entry, with key="x" and value=10
a[20] = "great" -- new entry, with key=20 and value="great"
print(a["x"]) --> 10
k = 20
print(a[k]) --> "great"
a["x"] = a["x"] + 1 -- increments entry "x"
print(a["x"]) --> 11

-- A table is always anonymous. There is no fixed relationship between a variable that holds a table and the table itself:

a = {}
a["x"] = 10
b = a -- `b' refers to the same table as `a'
print(b["x"]) --> 10
b["x"] = 20
print(a["x"]) --> 20
a = nil -- now only `b' still refers to the table
b = nil -- now there are no references left to the table

-- When a program has no references to a table left, Lua memory management will eventually delete the table and reuse its memory.

-- Each table may store values with different types of indices and it grows as it needs to accommodate new entries:

a = {} -- empty table
-- create 1000 new entries
for i = 1, 1000 do
	a[i] = i * 2
end
print(a[9]) --> 18
a["x"] = 10
print(a["x"]) --> 10
print(a["y"]) --> nil

-- Notice the last line: Like global variables, table fields evaluate to nil if they are not initialized. Also like global variables, you can assign nil to a table field to delete it. That is not a coincidence: Lua stores global variables in ordinary tables. More about this subject in Chapter 14.

-- To represent records, you use the field name as an index. Lua supports this representation by providing a.name as syntactic sugar for a["name"]. So, we could write the last lines of the previous example in a cleanlier manner as

a.x = 10 -- same as a["x"] = 10
print(a.x) -- same as print(a["x"])
print(a.y) -- same as print(a["y"])

-- For Lua, the two forms are equivalent and can be intermixed freely; but for a human reader, each form may signal a different intention.

--A common mistake for beginners is to confuse a.x with a[x]. The first form represents a["x"], that is, a table indexed by the string "x". The second form is a table indexed by the value of the variable x. See the difference:

a = {}
x = "y"
a[x] = 10 -- put 10 in field "y"
print(a[x]) --> 10      -- value of field "y"
print(a.x) --> nil     -- value of field "x" (undefined)
print(a.y) --> 10      -- value of field "y"

--To represent a conventional array, you simply use a table with integer keys. There is no way to declare its size; you just initialize the elements you need:

-- read 10 lines storing them in a table
a = {}
for i = 1, 10 do
	a[i] = io.read()
end

-- When you iterate over the elements of the array, the first non-initialized index will result in nil; you can use this value as a sentinel to represent the end of the array. For instance, you could print the lines read in the last example with the following code:

-- print the lines
for i, line in ipairs(a) do
	print(line)
end

--The basic Lua library provides ipairs, a handy function that allows you to iterate over the elements of an array, following the convention that the array ends at its first nil element.

-- Since you can index a table with any value, you can start the indices of an array with any number that pleases you. However, it is customary in Lua to start arrays with one (and not with zero, as in C) and the standard libraries stick to this convention.

-- Because we can index a table with any type, when indexing a table we have the same subtleties that arise in equality. Although we can index a table both with the number 0 and with the string "0", these two values are different (according to equality) and therefore denote different positions in a table. By the same token, the strings "+1", "01", and "1" all denote different positions. When in doubt about the actual types of your indices, use an explicit conversion to be sure:

i = 10
j = "10"
k = "+10"
a = {}
a[i] = "one value"
a[j] = "another value"
a[k] = "yet another value"
print(a[j]) --> another value
print(a[k]) --> yet another value
print(a[tonumber(j)]) --> one value
print(a[tonumber(k)]) --> one value

-- You can introduce subtle bugs in your program if you do not pay attention to this point.
