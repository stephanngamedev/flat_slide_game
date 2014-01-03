local storyboard = require 'storyboard'
local GameUtil = require 'game_util'
local screenCenterX = display.contentCenterX
local screenCenterY = display.contentCenterY

local scene = storyboard.newScene()
local font_name
local logo_image
local logo_text
local start_button
local records_button
local about_button

local create_logo_text = function( group )
	logo_text = display.newGroup()
	logo_text.anchorChildren = true

	local logo_text1 = display.newText{
		parent = logo_text,
		text = 'S L I D E',
		x = screenCenterX,
		y = 0,
		fontSize = 56,
		font = font_name
	}

	local logo_text2 = display.newText{
		parent = logo_text,
		text = 'P U Z Z L E',
		x = screenCenterX,
		y = 70,
		fontSize = 56,
		font = font_name
	}
	
	logo_text1:setFillColor( 0, 0, 0 )
	logo_text2:setFillColor( 0, 0, 0 )
	
	logo_text.x, logo_text.y = screenCenterX, 175
	group:insert( logo_text )
end

local create_logo_image = function( group )
	logo_image = display.newGroup()
	logo_image.anchorChildren = true
	
	local rect1 = display.newRect( logo_image, 0, 0, 20, 20 )
	local rect2 = display.newRect( logo_image, 20, 0, 20, 20 )
	local rect3 = display.newRect( logo_image, 40, 0, 20, 20 )
	local rect4 = display.newRect( logo_image, 0, 20, 20, 20 )
	local rect5 = display.newRect( logo_image, 20, 20, 20, 20 )
	local rect6 = display.newRect( logo_image, 40, 20, 20, 20 )	
	local rect7 = display.newRect( logo_image, 0, 40, 20, 20 )
	local rect8 = display.newRect( logo_image, 20, 40, 20, 20 )

	rect1:setFillColor(  0.20392156862745, 0.59607843137255, 0.85882352941176 ) --peter river
	rect2:setFillColor(  0.18039215686275, 0.8, 0.44313725490196 ) --emerald
	rect3:setFillColor(  0.6078431372549, 0.34901960784314, 0.71372549019608 ) --amethyst
	rect4:setFillColor(  0.94509803921569, 0.76862745098039, 0.058823529411765 ) --sun flower
	rect5:setFillColor(  0.20392156862745, 0.28627450980392, 0.36862745098039 ) --wet asphalt
	rect6:setFillColor(  0.90196078431373, 0.49411764705882, 0.13333333333333 ) --carrot
	rect7:setFillColor(  0.101, 0.737, 0.611 ) --turquoise
	rect8:setFillColor(  0.90588235294118, 0.29803921568627, 0.23529411764706 ) --alizarin

	logo_image.x, logo_image.y = screenCenterX - 100, screenCenterY - 155
	logo_image.alpha = .5

	group:insert( logo_image )
end

local create_start_button = function( group )
	start_button = display.newText{
		parent = group,
		text = 'Start',
		x = screenCenterX,
		y = screenCenterY + 30,
		fontSize = 32,
		font = font_name
	}
	
	start_button:setFillColor( 0, 0, 0 )

	function start_button:tap()
		storyboard.gotoScene( 'game', {
			effect = 'slideLeft',
			time = 400
		})
	end

	start_button:addEventListener( 'tap', start_button )
end

local create_records_button = function( group )
	records_button = display.newText{
		parent = group,
		text = 'Records',
		x = screenCenterX,
		y = screenCenterY + 80,
		fontSize = 32,
		font = font_name
	}

	records_button:setFillColor( 0, 0, 0 )
end

local create_about_button = function( group )
	about_button = display.newText{
		parent = group,
		text = 'About',
		x = screenCenterX,
		y = screenCenterY + 130,
		fontSize = 32,
		font = font_name
	}

	about_button:setFillColor( 0, 0, 0 )
end

function scene:init( group )
	font_name = GameUtil.get_roboto_font_name()
	create_logo_image( group )
	create_logo_text( group )
	create_start_button( group )
	create_records_button( group )
	create_about_button( group )
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