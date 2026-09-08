var introStarted:Bool = false;

function onCreate()
{
    PlayState.largeKey = 'fh';
}

function onCreatePost()
{
    PlayState.camGame.alpha = 0;
    PlayState.camHUD.alpha = 0;
    PlayState.healthDrain = true;
    PlayState.timeTxt.setFormat(Paths.font('finn.ttf'), 32, FlxColor.WHITE, 'center', PlayState.scoreTxt.borderStyle, FlxColor.BLACK);
    PlayState.scoreTxt.setFormat(Paths.font('finn.ttf'), 20, PlayState.boyfriendColor, 'center', PlayState.scoreTxt.borderStyle, FlxColor.BLACK);
    PlayState.lyricTxt.setFormat(Paths.font('finn.ttf'), 48, PlayState.dadColor, 'center', PlayState.scoreTxt.borderStyle, FlxColor.BLACK);
    PlayState.botplayTxt.setFormat(Paths.font('finn.ttf'), 32, FlxColor.WHITE, 'center', PlayState.scoreTxt.borderStyle, FlxColor.BLACK);
    FlxTween.tween(PlayState.lyricTxt, {alpha: 1}, 0.5, {
        ease: FlxEase.linear,
        onComplete:
        function (twn:FlxTween)
            {
                PlayState.lyricTxt.alpha = 1;
            }
    });

    if (ClientPrefs.gore) {
        GameOverSubstate.characterName = 'bf-dead-finn';
        GameOverSubstate.deathSoundName = 'bffinndeath';
        GameOverSubstate.endSoundName = 'gffinnrevive';
    }
}

function killyourselfCheck():Bool
{
    return PlayState.curStep >= 448;
}

function onStartCountdown()
{
    PlayState.camGame.alpha = 0;
    PlayState.camHUD.alpha = 0;
}

function onUpdatePost(elapsed:Float)
{
    // The final countdown camera bump resets HUD alpha in PlayState.
    if (!introStarted)
    {
        PlayState.camGame.alpha = 0;
        PlayState.camHUD.alpha = 0;
    }
}

function onSongStart()
{
    introStarted = true;
    PlayState.camGame.alpha = 0;
    PlayState.camHUD.alpha = 0;
    if (ClientPrefs.flashing) PlayState.camOther.flash(FlxColor.WHITE, 1);
    FlxTween.tween(PlayState.camGame, {alpha: 1}, 2, {ease: FlxEase.sineInOut});
    FlxTween.tween(PlayState.camHUD, {alpha: 1}, 2, {ease: FlxEase.sineInOut});
}

function setLabEffectsVisible(visible:Bool)
{
    var lab = getScript('lab');
    if (lab != null && lab.exists('setEffectsVisible'))
        lab.get('setEffectsVisible')(visible);
}

function onStepHit(curStep:Int)
{
    switch (curStep)
    {
        case 1136, 2463: setLabEffectsVisible(false);
        case 1392, 2943: setLabEffectsVisible(true);
    }

    switch (curStep)
    {
        case 64:
            //cinematic bars
            triggerEvent('Cinematics', 'on', '1');
        case 128:
            var fallenHeroText:FlxText = new flixel.text.FlxText(0, 0, FlxG.width, "Fallen Hero", 64);
            fallenHeroText.setFormat(Paths.font('finn.ttf'), 64, FlxColor.WHITE, 'center');
            fallenHeroText.screenCenter();
            fallenHeroText.cameras = [PlayState.camOther];
            fallenHeroText.alpha = 0;
            add(fallenHeroText);
            FlxTween.tween(fallenHeroText, {alpha: 1}, 0.5);

            var authorText:FlxText = new flixel.text.FlxText(0, fallenHeroText.y + 80, FlxG.width, "By IAmDaDogeOfDaFuture", 32);
            authorText.setFormat(Paths.font('finn.ttf'), 32, FlxColor.WHITE, 'center');
            authorText.screenCenter(0x01);
            authorText.cameras = [PlayState.camOther];
            authorText.alpha = 0;
            add(authorText);
            FlxTween.tween(authorText, {alpha: 1}, 0.5);

            new FlxTimer().start(1.5, function(tmr:FlxTimer){
                FlxTween.tween(fallenHeroText, {alpha: 0}, 2, {onComplete: function(twn:FlxTween) { fallenHeroText.destroy(); }});
                FlxTween.tween(authorText, {alpha: 0}, 2, {onComplete: function(twn:FlxTween) { authorText.destroy(); }});
            });
            if (ClientPrefs.flashing) PlayState.camGame.flash(FlxColor.WHITE, 1);
        case 192: PlayState.lyricTxt.text = "HAHAHAHAHAHAHA";
            triggerEvent('Cinematics', 'off', '1');
            if (ClientPrefs.flashing) PlayState.camGame.flash(FlxColor.WHITE, 1);
            triggerEvent('Apple Filter', 'on', 'black');
        case 200: PlayState.lyricTxt.text = "*inhales*";
        case 203: PlayState.lyricTxt.text = "HAHAHAHAHAHAHA";
        case 214: PlayState.lyricTxt.text = "*inhales*";
        case 220: PlayState.lyricTxt.text = "HAHAHAHAHAHAHA";
        case 228: PlayState.lyricTxt.text = "*inhales*";
        case 232: PlayState.lyricTxt.text = "WHY!!!!!";
        case 240: PlayState.lyricTxt.text = "WHY!?!?!?!?!?";
        case 244: PlayState.lyricTxt.text = "JUST WHY!?!?!?!?";
        case 255: PlayState.lyricTxt.text = "WHY!?!?!?!?!?";
        case 262: PlayState.lyricTxt.text = "WHY DO YOU KEEP REJECTING THE DARKNESS!?";
        case 295: PlayState.lyricTxt.text = "LET IT SPREAD BOYFRIEND...";
        case 324: PlayState.lyricTxt.text = "LET IT...";
        case 330: PlayState.lyricTxt.text = "SPREAAAAAAAAAD";
        case 355: PlayState.lyricTxt.text = " ";
        case 432: PlayState.lyricTxt.text = "DIEEEEEEEEEEEEEE!!!!!";
            triggerEvent('Apple Filter', 'off', '');
            if (ClientPrefs.flashing) PlayState.camGame.flash(FlxColor.WHITE, 1);
        case 448:
            PlayState.lyricTxt.text = "";
        case 703:
            triggerEvent('Change Scroll Speed', '0.1', '0.25');
        case 704:
            PlayState.lyricTxt.text = "WHY!?!?!?!?!?";
        case 711:
            triggerEvent('Change Scroll Speed', '1', '0.25');
            PlayState.lyricTxt.text = " ";
        case 1088:
            FlxTween.tween(PlayState.camGame, {alpha: 0}, 0.8, {ease: FlxEase.quadInOut});
            FlxTween.tween(PlayState.camHUD, {alpha: 0}, 0.8, {ease: FlxEase.quadInOut});
        case 1100: PlayState.lyricTxt.text = "Just...";
        case 1107: PlayState.lyricTxt.text = "Let the darkness CONSUME YOU ALREADY!!!";
        case 1136:
            PlayState.lyricTxt.text = "";
            PlayState.theBlackness.alpha = 1;
            if (ClientPrefs.flashing) PlayState.camGame.flash(FlxColor.WHITE, 1);
            PlayState.addCharacterToList('fhfinn-white', 1);
            triggerEvent('Change Character', '1', 'fhfinn-white');
            PlayState.camHUD.alpha = 1;
            PlayState.camGame.alpha = 1;
            PlayState.addCharacterToList('fhbf-white', 0);
            triggerEvent('Change Character', '0', 'fhbf-white');
            if(PlayState.gf != null) PlayState.gf.visible = false;
        case 1392:
            PlayState.theBlackness.alpha = 0;
            triggerEvent('Change Character', '1', 'finn-sword');
            triggerEvent('Change Character', '0', 'newbf');
            if(PlayState.gf != null) PlayState.gf.visible = true;
        case 1660: PlayState.lyricTxt.text = "The darkness...";
        case 1672: PlayState.lyricTxt.text = "It is calling to me...";
        case 1694: PlayState.lyricTxt.text = "To be...";
        case 1705:
            PlayState.lyricTxt.text = "HAPPY...";
            PlayState.lyricTxt.color = FlxColor.RED;
        case 1722:
            PlayState.lyricTxt.text = "HAHAHAHAHAHAHAHA";
            PlayState.lyricTxt.color = PlayState.dadColor;
        case 1741: PlayState.lyricTxt.text = "TO SHOW TRUE";
        case 1756:
            PlayState.lyricTxt.text = "HAPPINESS!";
            PlayState.lyricTxt.color = FlxColor.RED;
            new FlxTimer().start(1, function(tmr:FlxTimer){
                PlayState.lyricTxt.color = PlayState.dadColor;});
        case 1768:
            PlayState.lyricTxt.text = " ";
        case 1904:
            PlayState.opponentStrums.forEach(function(strum:StrumNote) {
                strum.alpha = 0;
            });
            PlayState.playerStrums.forEach(function(strum:StrumNote) {
                strum.alpha = 0;
            });
            PlayState.lyricTxt.color = PlayState.dadColor;
            PlayState.camGame.alpha = 0;

            PlayState.iconP1.alpha = 0;
            PlayState.iconP2.alpha = 0;
            if (PlayState.gf != null) PlayState.iconP3.alpha = 0;
            PlayState.healthBar.alpha = 0;
            PlayState.healthBarBG.alpha = 0;
            PlayState.pibbyHealthbar.alpha = 0;
            PlayState.finnBarThing.alpha = 0;
            PlayState.scoreTxt.alpha = 0;
            PlayState.timeTxt.alpha = 0;
            PlayState.timeBar.alpha = 0;
            PlayState.timeBarBG.alpha = 0;

            FlxTween.tween(PlayState.camGame, {alpha: 1}, 2);
            PlayState.dad.visible = false;
            PlayState.boyfriend.visible = false;
            triggerEvent('Apple Filter', 'on', 'black');
        case 1911:
            PlayState.playerStrums.forEach(function(strum:StrumNote) {
                strum.alpha = 0;
                FlxTween.tween(strum, {alpha: 1}, 1);
            });
        case 1920:
            PlayState.opponentStrums.forEach(function(strum:StrumNote) {
                strum.alpha = 1;
            });
            PlayState.camGame.alpha = 1;

            PlayState.iconP1.alpha = 1;
            PlayState.iconP2.alpha = 1;
            if (PlayState.gf != null) PlayState.iconP3.alpha = 1;
            PlayState.healthBar.alpha = ClientPrefs.healthBarAlpha;
            PlayState.healthBarBG.alpha = ClientPrefs.healthBarAlpha;
            PlayState.pibbyHealthbar.alpha = 1;
            PlayState.finnBarThing.alpha = ClientPrefs.healthBarAlpha;
            PlayState.scoreTxt.alpha = 1;
            PlayState.timeTxt.alpha = 1;
            PlayState.timeBar.alpha = 1;
            PlayState.timeBarBG.alpha = 1;

            PlayState.dad.visible = true;
            PlayState.boyfriend.visible = true;
            triggerEvent('Apple Filter', 'off', '');
        case 2431:
            PlayState.theBlackness.alpha = 1;
            FlxTween.tween(PlayState.camGame, {alpha: 0}, 1);
            FlxTween.tween(PlayState.camHUD, {alpha: 0}, 1);
        case 2447:
            PlayState.dad.visible = false;
            if(PlayState.gf != null) PlayState.gf.visible = false;
        case 2543:
            PlayState.theBlackness.alpha = 1;
            PlayState.camHUD.alpha = 1;
            PlayState.opponentStrums.forEach(function(strum:StrumNote) {
                strum.alpha = 0;
            });
            PlayState.playerStrums.forEach(function(strum:StrumNote) {
                strum.alpha = 0;
                FlxTween.tween(strum, {alpha: 1}, 1);
            });
            FlxTween.tween(PlayState.camGame, {alpha: 1}, 1);
        case 2687:
            if(PlayState.gf != null) {
                PlayState.gf.alpha = 0;
                PlayState.gf.visible = true;
                FlxTween.tween(PlayState.gf, {alpha: 1}, 2);
            }
            PlayState.opponentStrums.forEach(function(strum:StrumNote) {
                strum.alpha = 0;
                FlxTween.tween(strum, {alpha: 1}, 20);
            });
        case 2943:
            PlayState.camHUD.alpha = 1;
            PlayState.theBlackness.alpha = 0;
            PlayState.dad.visible = true;
            PlayState.iconP1.alpha = 1;
            PlayState.iconP2.alpha = 1;
            if (PlayState.gf != null) PlayState.iconP3.alpha = 1;
            PlayState.pibbyHealthbar.alpha = 1;
            PlayState.finnBarThing.alpha = ClientPrefs.healthBarAlpha;
            PlayState.scoreTxt.alpha = 1;
        case 3173: PlayState.lyricTxt.text = "There's no one to save you";
        case 3196:
            PlayState.lyricTxt.text = "NOW...";
            PlayState.lyricTxt.color = FlxColor.RED;
            new FlxTimer().start(1, function(tmr:FlxTimer) {
                PlayState.lyricTxt.color = PlayState.dadColor;});
        case 3199:
            PlayState.lyricTxt.text = " ";
        case 4015:
            PlayState.playerStrums.forEach(function(strum:StrumNote) {
                FlxTween.tween(strum, {alpha: 0}, 1);
            });
            PlayState.opponentStrums.forEach(function(strum:StrumNote) {
                FlxTween.tween(strum, {alpha: 0}, 1);
            });
            PlayState.lyricTxt.color = PlayState.dadColor;
            FlxTween.tween(PlayState.camGame, {alpha: 0}, 1);
            FlxTween.tween(PlayState.iconP1, {alpha: 0}, 1);
            FlxTween.tween(PlayState.iconP2, {alpha: 0}, 1);
            if (PlayState.gf != null) FlxTween.tween(PlayState.iconP3, {alpha: 0}, 1);
            FlxTween.tween(PlayState.pibbyHealthbar, {alpha: 0}, 1);
            FlxTween.tween(PlayState.finnBarThing, {alpha: 0}, 1);
            FlxTween.tween(PlayState.scoreTxt, {alpha: 0}, 1);
            FlxTween.tween(PlayState.timeBar, {alpha: 0}, 1);
            FlxTween.tween(PlayState.timeBarBG, {alpha: 0}, 1);
            FlxTween.tween(PlayState.timeTxt, {alpha: 0}, 1);
        case 4366:
            var fallenHeroText:FlxText = new flixel.text.FlxText(0, 0, FlxG.width, "Fallen Hero", 64);
            fallenHeroText.setFormat(Paths.font('finn.ttf'), 64, FlxColor.WHITE, 'center');
            fallenHeroText.screenCenter();
            fallenHeroText.cameras = [PlayState.camOther];
            fallenHeroText.alpha = 0;
            add(fallenHeroText);
            FlxTween.tween(fallenHeroText, {alpha: 1}, 0.5);

            var authorText:FlxText = new flixel.text.FlxText(0, fallenHeroText.y + 80, FlxG.width, "By IAmDaDogeOfDaFuture", 32);
            authorText.setFormat(Paths.font('finn.ttf'), 32, FlxColor.WHITE, 'center');
            authorText.screenCenter(0x01); // This was already correct, but for consistency with the fix above.
            authorText.cameras = [PlayState.camOther];
            authorText.alpha = 0;
            add(authorText);
            FlxTween.tween(authorText, {alpha: 1}, 0.5);

            new FlxTimer().start(1.5, function(tmr:FlxTimer){
                FlxTween.tween(fallenHeroText, {alpha: 0}, 2, {onComplete: function(twn:FlxTween) { fallenHeroText.destroy(); }});
                FlxTween.tween(authorText, {alpha: 0}, 2, {onComplete: function(twn:FlxTween) { authorText.destroy(); }});
            });
    }
}
