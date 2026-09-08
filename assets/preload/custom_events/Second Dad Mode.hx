var ghostAlpha = 0.45;
var ghostOffsetX = 90;
var ghostOffsetY = -20;
var enabled = false;
var secondDad = null;
var ghostCharacter = '';
var loadedCharacter = '';

function syncGhost()
{
    var dad = PlayState.dad;
    if (!enabled || dad == null) return;

    if (ghostCharacter == '') ghostCharacter = dad.curCharacter;
    if (secondDad == null || loadedCharacter != ghostCharacter)
    {
        if (secondDad != null)
        {
            PlayState.dadGroup.remove(secondDad, true);
            secondDad.destroy();
        }
        var characterClass = Type.resolveClass('Character');
        secondDad = Type.createInstance(characterClass, [dad.x, dad.y, ghostCharacter, false]);
        loadedCharacter = ghostCharacter;
        PlayState.dadGroup.insert(PlayState.dadGroup.members.length, secondDad);
    }

    if (PlayState.dadGroup.members.indexOf(secondDad) < PlayState.dadGroup.members.indexOf(dad))
    {
        PlayState.dadGroup.remove(secondDad, true);
        PlayState.dadGroup.insert(PlayState.dadGroup.members.length, secondDad);
    }

    secondDad.setPosition(dad.x - dad.positionArray[0] + secondDad.positionArray[0] + ghostOffsetX,
        dad.y - dad.positionArray[1] + secondDad.positionArray[1] + ghostOffsetY);
    secondDad.scrollFactor.set(dad.scrollFactor.x, dad.scrollFactor.y);
    secondDad.angle = dad.angle;
    secondDad.color = dad.color;
    secondDad.alpha = dad.alpha * ghostAlpha;
    secondDad.visible = dad.visible;
    secondDad.active = true;
}

function onEvent(name, value1, value2)
{
    if (name != 'Second Dad Mode') return;
    var mode = value1 == null ? '' : StringTools.trim(value1).toLowerCase();
    if (mode != '' && mode != 'on' && mode != 'off') return;
    var character = value2 == null ? '' : StringTools.trim(value2);
    if (character != '') ghostCharacter = character;
    if (mode != '') enabled = mode == 'on';
    if (enabled) syncGhost();
    else if (secondDad != null)
    {
        secondDad.visible = false;
        secondDad.active = false;
        secondDad.holdTimer = 0;
        secondDad.dance();
    }
}

function getSecondDad()
{
    if (!enabled) return null;
    syncGhost();
    return secondDad;
}

function onUpdatePost(elapsed)
{
    syncGhost();
}

function onBeatHit(beat)
{
    if (!enabled || secondDad == null) return;
    var anim = secondDad.animation.curAnim;
    if ((anim == null || anim.name.indexOf('sing') != 0) && !secondDad.specialAnim)
        secondDad.dance();
}
