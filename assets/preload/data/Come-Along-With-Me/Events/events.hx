var singingFinn = null;
var finnSkipDance:Bool = false;

function opponentNoteHit(index:Int, dir:Float, noteType:String, isSus:Bool)
{
    var finn = PlayState.dad;
    if (finn == null || finn.curCharacter != 'finncawm_reveal' || finn.animation.curAnim == null)
        return;

    var anim = finn.animation.curAnim;
    if (!StringTools.startsWith(anim.name, 'sing') || StringTools.endsWith(anim.name, 'miss'))
        return;

    if (singingFinn != finn)
    {
        if (singingFinn != null)
            singingFinn.skipDance = finnSkipDance;
        singingFinn = finn;
        finnSkipDance = finn.skipDance;
    }
    finn.skipDance = true;
}

function onUpdatePost(elapsed:Float)
{
    if (singingFinn == null)
        return;

    var finn = singingFinn;
    var anim = finn.animation.curAnim;
    var isSinging = anim != null && StringTools.startsWith(anim.name, 'sing') && !StringTools.endsWith(anim.name, 'miss');
    if (finn != PlayState.dad || !isSinging || anim.finished)
    {
        finn.skipDance = finnSkipDance;
        singingFinn = null;
        if (finn == PlayState.dad && isSinging && anim.finished)
            finn.dance();
    }
}

function onEvent(name:String, value1:String, value2:String)
{
}

function onStepHit(curStep:Int)
{
    switch (curStep)
    {
        case 607:
            PlayState.triggerEventNote('Change Character', 'Dad', 'finnanimstuff');
            PlayState.triggerEventNote('Play Animation', 'lesgo', 'Dad');
            PlayState.iconP2.changeIcon('fakefinn');
    }
}
