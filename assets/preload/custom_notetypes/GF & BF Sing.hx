function goodNoteHit(index:Int, direction:Float, noteType:String, isSustainNote:Bool)
{
    if (noteType != 'GF & BF Sing') return;

    var note = PlayState.notes.members[index];
    if (note == null || note.noAnimation) return;

    var animations = ['singLEFT', 'singDOWN', 'singUP', 'singRIGHT'];
    var lane = Std.int(direction);
    if (lane < 0 || lane >= animations.length) return;

    var animation = animations[lane] + note.animSuffix;
    for (character in [PlayState.boyfriend, PlayState.gf])
    {
        if (character != null)
        {
            character.playAnim(animation, true);
            character.holdTimer = 0;
        }
    }
}
