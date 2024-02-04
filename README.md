# NT Parser

This is a parser, similar to aoi.js, it can parse the strings and convert it into functions. This is just the base of the parser, so, you can expand it if you want.

## Download this parser
This parser is compatible with any lua version with the string library.
Download this parser by clicking [here](parser.lua).

## Using the Parser
You can use the parser by using the `parse` function like this:
```lua
parse([[
$let(hm;Hi Mom)
hm is $get(hm)
]])
```
This parser This will print "hm is Hi Mom". This parser automatically prints the result for you, so you don't have to use $print everytime!

## Creating Parser Functions
To create user-made functions in the parser, you can use the `createParserFunc` function like these:

1. Creating a function with no parameters
This example will replace `$foo` to `bar` in your code. You can do many kinds of things with these types of functions
```lua
createParserFunc({
 name = "$foo",
 params = 0, -- This is optional here.
 code = function()
  return "bar"
 end})
```
> [!WARNING]
> This needs to return something or else it will not work properly.

2. Creating a function with 1 parameter
This example will increment the given number inside the `$inc` custom function.
```lua
createParserFunc({
 name = "$inc",
 params = 1, -- Set params as 1
 code = function(num) -- Your parameter would be num here.
 local incrementedNumber = tonumber(num) + 1
 
 return incrementedNumber
 end
})

parse([[
3+1 is $inc[3] 
]])
```
## Creating Internal Functions
If you want to use multiple parameters, or your own logic for functions, you can internally modify the parser. This is called as an internal function.\
You can create internal functions by modifying the `parse` function like this:
```lua
function parse(ist)

-- Function with one parameter, remember to replace $funcName to your desired function name.
inputString = string.gsub(inputString, "%$funcName%((%w+)%)", function(p)
-- p is the variable of your parameter. p will always be a string

-- Your code
numberP = tonumber(p)
incP = p + 1
stringPbutIncremented = tostring(incP)

-- The return call, remember to always return something, or else it might break the parser / cause an error. If you want a function that gets params but doesn't return anything simple put return "" instead of nothing. 

return stringPbutIncremented
  end)

-- (...) Other code
end
```
> [!TIP]
> Make sure to put your internal functions above every functions so that it will become compatible with other functions.


## Custom Libraries
This parser has extensive libraries with extensive custom functions.

| Library Name | Author |
|-----|--------|
