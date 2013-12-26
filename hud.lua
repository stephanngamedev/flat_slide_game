local GameUtil = require 'game_util'

local HUD = {}
local screenWidth = display.contentWidth
local screenHeight = display.contentHeight
local screenCenterX = display.contentCenterX
local screenCenterY = display.contentCenterY

local font_name = GameUtil.get_font_name()
local font_size = 20

HUD.new = function()
	local hud = display.newGroup()
	
	function hud:_create_moves()
		local moves = display.newText{
			parent = self,
			text = "moves: 0",
			font = font_name,
			fontSize = font_size
		}
		moves:setFillColor( 0, 0, 0 )
		moves.anchorX = 0
		moves.anchorY = .5
		moves.y = screenCenterY - 170
		moves.x = 10
		self.moves = moves
		self._moves = 0
	end

	function hud:increment_moves()
		self._moves = self._moves + 1
		self.moves.text = "moves: "..self._moves
	end
	
	hud:_create_moves()
	return hud
end

return HUD