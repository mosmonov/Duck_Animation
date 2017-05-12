local w = display.contentWidth
local h = display.contentHeight

local duckTable = {
    sheetContentWidth = 400,
    sheetContentHeight = 100,
    width = 100,
    height = 100,
    numFrames = 4
}

local duckSheet = graphics.newImageSheet( "blueDuck.png", duckTable )

local duckSequenceTable = {
    {
    name = "flying",
    start = 1,
    count = 4,
    time = 600,
    loopCount = 0,     -- repeat indefinitely
    loopDirection = "forward"
    }
}

local duckCount = 0        -- keep track of ducks caught
local ducksMade = 0        -- keep track of number of ducks created

local explosionTable = {
    sheetContentWidth = 12288,
    sheetContentHeight = 192,
    width = 12288/64,
    height = 192,
    numFrames = 64
    }
   
local explosionSheet = graphics.newImageSheet( "explosion_sheet.png", explosionTable )

local explosionSequenceTable = {
    {
    name = "explosion",
    start = 1,
    count = 64,
    time = 800,
    loopCount = 1,
    loopDirection = "forward"
    }
}

local function explode( event )
    local fireball = display.newSprite( explosionSheet, explosionSequenceTable )
    local duckTapped = event.target
    fireball.x = duckTapped.x
    fireball.y = duckTapped.y
    fireball.xScale = 2
    fireball.yScale = 2
    duckTapped:removeSelf()
    fireball:setSequence('explosion')
    fireball:play()
end
local function makeDuck()
    -- increase the counter of the total number of ducks created
    ducksMade = ducksMade + 1
   
    -- creates the duck image on screen
    local duck = display.newSprite( duckSheet, duckSequenceTable )
        duck.xScale = 3
        duck.yScale = 3
        duck:setSequence( 'flying' )
        duck:play()
       
    if ( ducksMade%2 == 1) then    -- if the number of ducks is odd
        duck.x = -300
        duck.y = math.random(h)
        transition.to( duck, { x = w + 300, y = math.random(h), time = 2000 } )
    else
        duck.x = w + 300
        duck.y = math.random(h)
        duck.xScale = -3
        transition.to( duck, { x = -300, y = math.random(h), time = 2000 })
    end
   
    duck:addEventListener("tap", explode)
end

timer.performWithDelay( 2000, makeDuck, -1 )



