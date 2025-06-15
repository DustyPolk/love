function love.conf(t)
    t.title = "D&D Combat System"
    t.author = "Love2D Developer"
    t.version = "11.4"
    
    t.window.width = 1024
    t.window.height = 768
    t.window.resizable = true
    t.window.minwidth = 800
    t.window.minheight = 600
    
    t.console = true
    
    t.modules.audio = true
    t.modules.event = true
    t.modules.graphics = true
    t.modules.image = true
    t.modules.joystick = false
    t.modules.keyboard = true
    t.modules.math = true
    t.modules.mouse = true
    t.modules.physics = false
    t.modules.sound = true
    t.modules.system = true
    t.modules.timer = true
    t.modules.touch = false
    t.modules.video = false
    t.modules.window = true
    t.modules.thread = true
end