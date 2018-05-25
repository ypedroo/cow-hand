--MUSIC 
menubgmusic = audio.loadStream ("sound/Splashing_Around.mp3")
gameoverbgmusic = audio.loadStream ("sound/St_Francis.mp3")
oldbgmusic = audio.loadStream ("sound/AI_2.mp3")

--SOUND
bubblepop = audio.loadSound ("sound/jackpot.wav")
losesound = audio.loadSound ("sound/mu.wav")
-- menupicksound = audio.loadSound ("sound/menu_pick.wav")
-- jumpsound = audio.loadSound ("sound/jump.wav")
 
audio.reserveChannels (2) 

function playSFX (soundfile) 
	audio.play(soundfile, {channel =  2})
end 
 
function playGameMusic(soundfile)
	audio.play (soundfile, {channel = 1, loops = -1 , fadein=2500})	
end
 
function resetMusic (soundfile)
 
if musicisOn == true then 
	audio.stop(1)
	audio.rewind (oldbgmusic)
end
 
end
 
function pauseMusic (soundfile)
	if musicisOn == true then 
		audio.pause()
	end
end
 
function resumeMusic (channel)
	if musicisOn == true then 
		audio.resume(channel)
	end
end