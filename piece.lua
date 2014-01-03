local Piece = {}

Piece.new = function( board, number, index  )
	local x, y = board.get_coordinates( index )
	local piece = display.newImage( board, 'img/'..number..'.png', x, y )
	piece.number = number
	piece.index = index
	
	function piece:tap( event )
		local board = self.parent
		if self:_can_move() and board.state == 'waiting' then
			self.parent:move_piece_to_blank( self.index )
		end
	end

	function piece:_can_move()
		local blank_index = self.parent:get_blank_index()
		if ( self.index - 1 == blank_index and self.index ~= 4 and self.index ~= 7)
			or ( self.index + 1 == blank_index and self.index ~= 3 and self.index ~= 6 )
			or self.index - 3 == blank_index 
			or self.index + 3 == blank_index then
			return true
		end
		return false
	end

	piece:addEventListener( 'tap', piece )

	return piece
end

return Piece