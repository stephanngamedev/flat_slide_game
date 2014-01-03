local storyboard = require 'storyboard'
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
		moves.y = screenCenterY - 180
		moves.x = 10
		self.moves = moves
		self._moves = 0
	end

	function hud:_create_back_button()
		local back = display.newText{
			parent = self,
			text = "back",
			font = font_name,
			fontSize = font_size
		}
		back:setFillColor( 0, 0, 0 )
		back.anchorX = 1
		back.anchorY = .5
		back.y = screenCenterY - 180
		back.x = screenWidth - 10

		function back:tap( event )
			storyboard.gotoScene( 'menu', {
				effect = 'slideRight',
				time = 400
			})
		end

		back:addEventListener( 'tap', back )
	end

	function hud:increment_moves()
		self._moves = self._moves + 1
		self.moves.text = "moves: "..self._moves
	end

	function hud:reset()
		self._moves = 0
		if self.moves then
			self.moves.text = "moves: "..self._moves
		end
	end
	
	hud:_create_moves()
	hud:_create_back_button()
	return hud
end

return HUD