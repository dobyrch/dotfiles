function autodeband(name, height)
	if height then
		mp.set_property_bool('deband', height < 600)
		print(mp.get_property('deband'))
	end
end

mp.observe_property('height', 'number', autodeband)
