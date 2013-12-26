local storyboard = require 'storyboard'

local screenCenterX = display.contentCenterX
local screenCenterY = display.contentCenterY

local Board = require 'board'
local HUD = require 'hud'

local scene = storyboard.newScene()
local board
local hud

function scene:init( group )
	hud = HUD.new()
	board = Board.new( hud )
	group:insert( board )
	group:insert( hud )
end

function scene:createScene( event )
	local group = self.view
	self:init( group )
end

function scene:enterScene( event )
	local group = self.view
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )

return scene