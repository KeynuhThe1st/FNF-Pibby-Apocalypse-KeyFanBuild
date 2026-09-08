
function getOpponentCharacter(note)
{
    var eventScript = getScript('custom_events/Second Dad Mode');
    if (eventScript == null || !eventScript.exists('getSecondDad')) return null;
    return eventScript.get('getSecondDad')();
}
