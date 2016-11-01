function autodeband(name, height)
	mp.set_property_bool('deband', height < 600)
	print(mp.get_property('deband'))
end

mp.observe_property('height', 'number', autodeband)
