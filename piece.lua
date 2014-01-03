local GameUtil = require 'game_util'

local Piece = {}

Piece.colors = {
	{ 0.20392156862745, 0.59607843137255, 0.85882352941176 },
	{ 0.18039215686275, 0.8, 0.44313725490196 },
	{ 0.6078431372549, 0.34901960784314, 0.71372549019608 },
	{ 0.94509803921569, 0.76862745098039, 0.058823529411765 },
	{ 0.20392156862745, 0.28627450980392, 0.36862745098039 },
	{ 0.90196078431373, 0.49411764705882, 0.13333333333333 },
	{ 0.101, 0.737, 0.611 },
	{ 0.90588235294118, 0.29803921568627, 0.23529411764706 }
}

function Piece:get_color( number )
	local color = self.colors[ number ]
	return color[1], color[2], color[3]
end

Piece.new = function( board, number, index  )
	local x, y = board.get_coordinates( index )
	local piece = display.newGroup()
	piece.x, piece.y = x, y 
	
	piece.number = number
	piece.index = index
	
	local rect = display.newRect( piece, 0, 0, 100, 100 )
	rect:setFillColor( Piece:get_color( number ) )
	
	local label = display.newText{
		parent = piece,
		text = number,
		x = 0,
		y = 0,
		font = GameUtil.get_aller_font_name(),
		fontSize = 60
	}
	label.anchorX, label.anchorY = .5, .5

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