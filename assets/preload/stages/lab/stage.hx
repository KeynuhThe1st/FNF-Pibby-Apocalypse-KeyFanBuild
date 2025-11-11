var effectsEnabled:Bool = false;

function onCreate()
	{	
		bg = new FlxSprite(400, 350);
		bg.loadGraphic(retrieveAsset('images/bg', 'image'));
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		bg.setGraphicSize(Std.int(bg.width * 1.7));
		bg.updateHitbox();
		bg.active = false;
	
		// add to the final array
		add(bg);
	
		effectsEnabled = !ClientPrefs.lowQuality || !ClientPrefs.flashing;
		if (effectsEnabled)
		{
			bulb = new FlxSprite(1120, -475);
			bulb.loadGraphic(retrieveAsset('images/bulb', 'image'));
			bulb.setGraphicSize(Std.int(bulb.width * 2));
			bulb.updateHitbox();
			bulb.antialiasing = ClientPrefs.globalAntialiasing;
			bulb.active = false;
			bulb.centerOrigin();
			bulb.origin.set(bulb.origin.x, bulb.origin.y -= bulb.height/2);
	
			dark = new FlxSprite(550, 35);
			dark.loadGraphic(retrieveAsset('images/dark', 'image'));
			dark.setGraphicSize(Std.int(dark.width * 1.7));
			dark.updateHitbox();
			dark.antialiasing = ClientPrefs.globalAntialiasing;
			dark.active = false;
			dark.centerOrigin();
			dark.origin.set(dark.origin.x, -250);
	
			var objects = [dark, bulb];
			for (object in objects) {
				object.x -= 100;
			}
	
			// add to the final array
			foreground.add(dark);
	
			light = new FlxSprite(dark.x, dark.y);
			light.loadGraphic(retrieveAsset('images/light', 'image'));
			light.setGraphicSize(Std.int(light.width * 1.7));
			light.alpha = 0.8;
			light.updateHitbox();
			
			light.antialiasing = ClientPrefs.globalAntialiasing;
			light.active = false;
			light.centerOrigin();
			light.origin.set(light.origin.x, -250);
			flickerTween = FlxTween.tween(light, {alpha: 0}, 0.25, {ease: FlxEase.bounceInOut, type: 4});
			flickerTween.active = true;
	
			// add to the final array
			foreground.add(light);
	
			// add to the final array
			foreground.add(dark);
			foreground.add(bulb);
		}
	}
	
	function setEffectsVisible(visible:Bool) {
		if (effectsEnabled) {
			dark.visible = visible;
			light.visible = visible;
			bulb.visible = visible;
		}
	}
	
	function onSongStart()
		{
			if (PlayState.curSong == 'Mindless')
				{
					bg.visible = false;
					setEffectsVisible(false);
				}
	}
	
	function onMoveCamera(focus:String)
		{
			if (focus == 'dad') {
				if (PlayState.dad.curCharacter != 'jake')
					PlayState.defaultCamZoom = 0.9;
				else
					PlayState.defaultCamZoom = 1;
	
			}
			else
				PlayState.defaultCamZoom = 1.1;
		}
	
	function onUpdate (elapsed) {
		if (effectsEnabled){ 
			var a = Math.sin((Conductor.songPosition / 1000) * (Conductor.bpm / 60) * 1.0);
			bg.alpha -= Math.sin((Conductor.songPosition / 1000) * (Conductor.bpm / 60) * 1.0) / 1200;
			light.angle = a * 5;
			dark.angle = light.angle;
			bulb.angle = light.angle;
	
			dark.x = 450 - (a * 45);
			light.x = 450 - (a * 45);
		}
		
	}
	
	function onStepHit(curStep:Int)
	{
		if (curStep == 296)
		{
			if (PlayState.curSong == 'Mindless')
				{
					bg.visible = true;
					setEffectsVisible(true);
				}
		}
		
		if (curStep == 2080)
		{
			if (PlayState.curSong == 'Suffering Siblings')
				setEffectsVisible(false);
		}
		if (curStep == 2336)
		{
			if (PlayState.curSong == 'Suffering Siblings')
				setEffectsVisible(true);
		}
		if (curStep == 1136)
		{
			if (PlayState.curSong == 'Fallen Hero')
				setEffectsVisible(false);
		}
		if (curStep == 1392)
		{
			if (PlayState.curSong == 'Fallen Hero')
				setEffectsVisible(true);
		}
		if (curStep == 2463)
		{
			if (PlayState.curSong == 'Fallen Hero')
				setEffectsVisible(false);
		}
		if (curStep == 2943)
		{
			if (PlayState.curSong == 'Fallen Hero')
				setEffectsVisible(true);
		}
	}
	
	function onEvent(event:String, value1:String, value2:String)
		{
		 if (event == 'Apple Filter')
			{
				 if (value1 == 'on') 
				{
					bg.visible = false;
					setEffectsVisible(false);
				}
				 else if (value1 == 'off')
				{
					bg.visible = true;
					setEffectsVisible(true);
				}
			}
		}
	
	function onPause()
	{
		if (effectsEnabled) flickerTween.active = false;
	}
	
	function onResume()
	{
		if (effectsEnabled) flickerTween.active = false;
	}