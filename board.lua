local GameUtil = require 'game_util'
local Piece = require 'piece'

local Board = {}

Board.params = {
	{ x = 0, y = 0, time = 200 },
	{ x = 100, y = 0, time = 200 },
	{ x = 200, y = 0, time = 200 },
	{ x = 0, y = 100, time = 200 },
	{ x = 100, y = 100, time = 200 },
	{ x = 200, y = 100, time = 200 },
	{ x = 0, y = 200, time = 200 },
	{ x = 100, y = 200, time = 200 },
	{ x = 200, y = 200, time = 200 },
}

Board.new = function( x, y )
	local board = display.newGroup()
	board.anchorChildren = true
	board.pieces = {}

	function board:_create_pieces()
		sequence = GameUtil.generate_sequence()	
		for i = 1, 9 do
			if sequence[i] ~= 9 then
				self.pieces[i] = Piece.new( self, sequence[i], i )
			end
		end
	end
	
	function board.get_coordinates( index )
		return Board.params[index].x, Board.params[index].y
	end

	function board:get_blank_index()
		for i = 1, 9 do
			if self.pieces[i] == nil then
				return i
			end
		end
	end

	function board:move_piece_to_blank( index )
		self.state = 'moving'
		local blank_index = self:get_blank_index()
		local x, y = Board.params[ blank_index ].x, Board.params[ blank_index ].y
		transition.to( self.pieces[index], {
			x = x,
			y = y,
			time = 200,
			onComplete = function()
				self.pieces[index].index = blank_index
				GameUtil.change( board.pieces, index, blank_index )
				self.state = 'waiting'
			end
		})
	end

	board:_create_pieces()
	board.x, board.y = x, y
	board.state = 'waiting'
	return board
end

return Board