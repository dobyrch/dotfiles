function autodeband(property, dropped_frames)
	if dropped_frames and dropped_frames - baseline > 30 then
		mp.set_property_bool('deband', false)
		mp.unobserve_property(autodeband)
		mp.msg.info('disabled')
	end
end

function reset(property, deband)
	if deband then
		baseline = mp.get_property_number('frame-drop-count') or 0
		mp.observe_property('frame-drop-count', 'number', autodeband)
	end
end

mp.observe_property('deband', 'bool', reset)
