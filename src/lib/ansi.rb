require 'rainbow'

hello = "
  ██   ██ ███████ ██      ██       ██████  ██ 
  ██   ██ ██      ██      ██      ██    ██ ██ 
  ███████ █████   ██      ██      ██    ██ ██ 
  ██   ██ ██      ██      ██      ██    ██    
  ██   ██ ███████ ███████ ███████  ██████  ██ 
                                            
                                            
"

seeya = "

███████ ███████ ███████     ██    ██  █████  ██ 
██      ██      ██           ██  ██  ██   ██ ██ 
███████ █████   █████         ████   ███████ ██ 
     ██ ██      ██             ██    ██   ██    
███████ ███████ ███████        ██    ██   ██ ██ 
                                                
                                                
"

takecare = "
████████  █████  ██   ██ ███████      ██████  █████  ██████  ███████ ██ 
   ██    ██   ██ ██  ██  ██          ██      ██   ██ ██   ██ ██      ██ 
   ██    ███████ █████   █████       ██      ███████ ██████  █████   ██ 
   ██    ██   ██ ██  ██  ██          ██      ██   ██ ██   ██ ██         
   ██    ██   ██ ██   ██ ███████      ██████ ██   ██ ██   ██ ███████ ██ 
                                                                        
                                                                        
"


def ansi_hello(text)
  puts Rainbow(text).color("C5AEEE")  
end



# color list (HEX):
# Calm Light Green - color("8DEEA6")
# Deep Blue - color("5257BA")
# Sky of Ocean - color("82CDE5")
# Calm Brown - color("907D79")
# Deep Olive - color("677762")
# Lilac - color("C5AEEE")
