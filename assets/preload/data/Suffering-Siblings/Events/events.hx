var missBarEnabled:Bool = false;
var missWarning = null;
var missWarningTime:Float = 0;

function onCreatePost()
{
    missWarning = new flixel.text.FlxText(40, ClientPrefs.downScroll ? 150 : 440, FlxG.width - 80,
        "Missing a note will cause you to lose one of your hit points. Be careful!", 24);
    missWarning.setFormat(Paths.font('vcr.ttf'), 24, FlxColor.YELLOW, 'center');
    missWarning.setBorderStyle(PlayState.scoreTxt.borderStyle, FlxColor.BLACK, 2);
    missWarning.scrollFactor.set();
    missWarning.cameras = [PlayState.camHUD];
    missWarning.visible = false;
    add(missWarning);
}

function showMissWarning()
{
    if (!missBarEnabled || missWarning == null)
        return;

    missWarningTime = 3;
    missWarning.visible = true;
}

function onUpdate(elapsed:Float)
{
    updateMissBarState();
    if (missWarningTime > 0)
    {
        missWarningTime -= elapsed;
        if (missWarningTime <= 0)
            missWarning.visible = false;
    }
}

function onEvent(name:String, value1:String, value2:String)
{
}

function updateMissBarState()
{
    var enabled = PlayState.dad != null && PlayState.dad.curCharacter == 'finn-slash';
    if (enabled == missBarEnabled)
        return;

    missBarEnabled = enabled;
    if (missBarEnabled)
    {
        PlayState.finnBarThing.visible = true;
        PlayState.finnBarThing.alpha = ClientPrefs.healthBarAlpha;
    }
    else
    {
        missWarningTime = 0;
        if (missWarning != null)
            missWarning.visible = false;
    }
}

function noteMiss(note:Note)
{
    updateMissBarState();
    showMissWarning();
    if (missBarEnabled && !note.isSustainNote && !note.dodgeNote)
        PlayState.dodgeMisses++;
}

function goodNoteHit(index:Int, dir:Float, noteType:String, isSus:Bool)
{
    updateMissBarState();
    if (!missBarEnabled || isSus)
        return;

    var note = PlayState.notes.members[index];
    if (note != null && note.rating == 'bad')
        showMissWarning();
}
