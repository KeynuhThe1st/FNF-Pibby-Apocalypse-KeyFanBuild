function onEvent(name, value1, value2)
    if name ~= 'bf-middlescroll' then return end

    local enabled = string.lower(tostring(value1)):match('^%s*(.-)%s*$')
    if enabled ~= 'true' and enabled ~= 'false' then return end

    local duration = tonumber(value2) or 0
    local baseX = getPropertyFromClass('PlayState', enabled == 'true' and 'STRUM_X_MIDDLESCROLL' or 'STRUM_X')
    local laneWidth = getPropertyFromClass('Note', 'swagWidth')
    local screenWidth = getPropertyFromClass('flixel.FlxG', 'width')

    for lane = 0, 3 do
        local tag = 'bf-middlescrollPlayerX' .. lane
        local targetX = baseX + 50 + screenWidth / 2 + laneWidth * lane
        cancelTween(tag)

        if duration > 0 then
            noteTweenX(tag, lane + 4, targetX, duration, 'quadInOut')
        else
            setPropertyFromGroup('playerStrums', lane, 'x', targetX)
        end
    end
end
