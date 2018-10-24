function set_visibility(when)
	mp.commandv('script-message', 'osc-visibility', when, 'true')
end

function show_osc()
	set_visibility('always')

	timer:kill()
	timer:resume()

end

timer = mp.add_timeout(1.5, function() set_visibility('auto') end)
timer:kill()

mp.add_key_binding(nil, 'show-osc', show_osc, {repeatable=true})
mp.register_event('seek', show_osc)
