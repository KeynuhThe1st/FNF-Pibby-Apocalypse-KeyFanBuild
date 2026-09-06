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
