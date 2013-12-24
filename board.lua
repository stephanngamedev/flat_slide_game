local GameUtil = require 'game_util'
local Piece = require 'piece'

local Board = {}

Board.coordinates = {
	{ x = 0, y = 0 }, --1
	{ x = 100, y = 0 }, --2
	{ x = 200, y = 0 }, --3
	{ x = 0, y = 100 }, --4
	{ x = 100, y = 100 }, --5
	{ x = 200, y = 100 }, --6
	{ x = 0, y = 200 }, --7
	{ x = 100, y = 200 }, --8
	{ x = 200, y = 200 } -- 9
}

Board.new = function( x, y )
	local board = display.newGroup()
	board.anchorChildren = true
	board.pieces = {}

	function board:_create_pieces()
		self:_destroy_pieces()
		local sequence = { 1,2,3,4,5,6,7,9,8 }--GameUtil.generate_sequence()	
		for i = 1, 9 do
			local piece_number = sequence[ i ]
			if piece_number ~= 9 then
				self.pieces[ i ] = Piece.new( self, piece_number, i )
			end
		end
	end
	
	function board:_destroy_pieces()
		for i = 1, 9 do
			local piece = self.pieces[ i ]
			if piece then
				piece:removeSelf()
				piece = nil
			end
		end
		self.pieces = {}
	end

	function board.get_coordinates( index )
		local coordinates = Board.coordinates[ index ]
		return coordinates.x, coordinates.y
	end

	function board:get_blank_index()
		for i = 1, 9 do
			if self.pieces[ i ] == nil then
				return i
			end
		end
	end

	function board:move_piece_to_blank( index )
		self.state = 'moving'
		local blank_index = self:get_blank_index()
		local x, y = self.get_coordinates( blank_index )
		transition.to( self.pieces[ index ], {
			x = x,
			y = y,
			time = 200,
			onComplete = function()
				self.pieces[index].index = blank_index
				GameUtil.change( board.pieces, index, blank_index )
				self:_check_state()
			end
		})
	end

	function board:_check_state()
		local pieces = self.pieces
		for i = 1, 9 do
			if pieces[i] then
				if pieces[ i ].number ~= pieces[ i ].index then
					self.state = 'waiting'
					return false
				end
			end
		end
		self.state = 'finished'
	end

	board:_create_pieces()
	board.x, board.y = x, y
	board.state = 'waiting'
	return board
end

return Board