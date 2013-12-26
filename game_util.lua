GameUtil = {}

GameUtil.generate_sequence = function()
	sequence = {}
	while #sequence ~= 9 do
		value = math.random( 1, 9 )
		if not GameUtil._has_value( sequence, value ) then
			sequence[ #sequence + 1 ] = value
		end
	end

	return sequence
end

GameUtil.change = function( table, index1, index2 ) 
	table[ index1 ], table[ index2 ] = table[ index2 ], table[ index1 ]
end

GameUtil._has_value = function( table, value )
	for i = 1, #table do
		if table[i] == value then
			return true
		end
	end

	return false
end

GameUtil.get_font_name = function()
	if "Android" == system.getInfo( "platformName" ) then
		return 'Roboto-Light'
	else
		return 'roboto'
	end
end

return GameUtil