local enabled = false
local tweenPrefix = 'brotherlyLoveShake'
local tweenNames = {'HudAngle', 'GameAngle'}

local function stopShake()
    for _, name in ipairs(tweenNames) do
        cancelTween(tweenPrefix .. name)
    end

    setProperty('camHUD.angle', 0)
    setProperty('camGame.angle', 0)
    setProperty('camHUD.x', 0)
    setProperty('camGame.x', 0)
end

function onEvent(name, value1, value2)
    if name ~= 'Brotherly Love Shake' then return end

    local value = string.lower(tostring(value1 or '')):match('^%s*(.-)%s*$')
    if value == 'true' then
        enabled = true
    elseif value == 'false' then
        enabled = false
        stopShake()
    end
end

function onBeatHit()
    if not enabled then return end

    -- Brotherly Love alternates a one-degree tilt on each beat.
    local angle = curBeat % 2 == 0 and 1 or -1
    setProperty('camHUD.angle', angle * 1.5)
    setProperty('camGame.angle', angle * 1.5)
    doTweenAngle(tweenPrefix .. 'HudAngle', 'camHUD', angle, stepCrochet * 0.002, 'circOut')
    doTweenAngle(tweenPrefix .. 'GameAngle', 'camGame', angle, stepCrochet * 0.002, 'circOut')
    setProperty('camHUD.x', -angle * 2)
    setProperty('camGame.x', -angle * 2)
end
