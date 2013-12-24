local storyboard = require 'storyboard'

local Board = require 'Board'

local scene = storyboard.newScene()
local board

local screenWidth = display.contentWidth
local screenHeight = display.contentHeight
local screenCenterX = display.contentCenterX
local screenCenterY = display.contentCenterY

local function init( group )
	board = Board.new( screenCenterX, screenCenterY )
	group:insert( board )
end

function scene:createScene( event )
	local group = self.view
	init( group )
end

function scene:enterScene( event )
	local group = self.view
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )

return scene