--[[
 NT-Parser
--]]

variables = {}
functions = {}
multiF = {}

inputString = ""

if not db then dbExists = false end
if not inputString then inputString = "" end

function createParserFunc(di)

nameF = di.name
codeF = di.code
paramsF = di.params or di.parameters

if not paramsF or paramsF == 0 then
fi = #functions + 1
functions[fi] = {}
functions[fi][1] = nameF
functions[fi][2] = codeF
functions[fi][3] = 0
elseif paramsF == 1 then
mf = #multiF + 1
multiF[mf] = {}
multiF[mf].name = nameF
multiF[mf].code = codeF
multiF[mf].params = paramsF

end
end

function parse(ist)
if not type(ist) == "string" then ist = "" end
inputString = inputString.. ist
inputString = string.gsub(inputString, "$nt", "NeverTrolls")

if functions then
for i = 1, #functions do
if functions[i][3] == 0 then
inputString = string.gsub(inputString, functions[i][1], functions[i][2])
end
end
end

if multiF then
for key, value in pairs(multiF) do
FunCname = multiF[key].name
FunCparams = multiF[key].params
FunCcode = multiF[key].code
 inputString = string.gsub(inputString, "%" ..FunCname.."%((.-)%)", function(varName)
 return FunCcode(varName)
end)
end
end


inputString = string.gsub(inputString, "%$global%((%w+)%)", function(varName)
return _G[varName] or ""
end)


inputString = string.gsub(inputString, "%$sub%((%w+);(.-)%)", function(a, b)
local successA, numA = pcall(tonumber, a)
local successB, numB = pcall(tonumber, b)

if successA and successB then
local sub = numA - numB
return tostring(sub)
else
return "Error: Invalid operands for $sub"
end
end)

inputString = string.gsub(inputString, "%$sum%((%w+);(.-)%)", function(a, b)
local successA, numA = pcall(tonumber, a)
local successB, numB = pcall(tonumber, b)

if successA and successB then
local sum = numA + numB
return tostring(sum)
else
return "Error: Invalid operands for $sum"
end
end)

inputString = string.gsub(inputString, "%$let%((%w+);(.-)%)", function(varName, varValue)
variables[varName] = varValue
return ""
end)

inputString = string.gsub(inputString, "%$get%((%w+)%)", function(varName)
return variables[varName] or ""
end)

inputString = string.gsub(inputString, "%$print%((.-)%)", function(content)
print(content)
return ""
end)

print(inputString)
return inputString
end
