T = {}

function T.number(value, message)
    if type(value) ~= "number" then
        message = message or "Expected a number"
        error(message, 2)
    end
end