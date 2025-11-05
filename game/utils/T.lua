T = {}

function T.number(value, message)
    if type(value) ~= "number" then
        message = message or "Expected a number"
        error(message, 2)
    end
end

function T.boolean(value, message)
    if type(value) ~= "boolean" then
        message = message or "Expected a boolean"
        error(message, 2)
    end
end

function T.table(value, message)
    if type(value) ~= "table" then
        message = message or "Expected a table"
        error(message, 2)
    end
end

function T.string(value, message)
    if type(value) ~= "string" then
        message = message or "Expected a string"
        error(message, 2)
    end
end

function T.optional_number(value, message)
    if value ~= nil and type(value) ~= "number" then
        message = message or "Expected a number or nil"
        error(message, 2)
    end
end

function T.optional_boolean(value, message)
    if value ~= nil and type(value) ~= "boolean" then
        message = message or "Expected a boolean or nil"
        error(message, 2)
    end
end