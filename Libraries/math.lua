createParserFunc({
    name = "$inc",
    parameters = 1,
    code = function(n)
    local number = tonumber(n)
    number = number + 1
    return tostring(number)
    end
  })
