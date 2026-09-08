function onEvent(name, value1, value2)
    if name ~= 'blackbg' then return end

    local enabled = string.lower(tostring(value1 or '')):match('^%s*(.-)%s*$') ~= 'false'
    setProperty('theBlackness.alpha', enabled and 1 or 0)
end