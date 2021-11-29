extends ViewportContainer

# This does the same work as Example1, and is the method used by OddLib

func _ready():
	# Creating the viewport
	var vp = Viewport.new()
	vp.set_name("Viewport")
	add_child(vp)
	
	vp.set_handle_input_locally(false)
	vp.set_update_mode(Viewport.UPDATE_ALWAYS)
	vp.set_keep_3d_linear(true)
	vp.set_hdr(false)
	
	
	# Creating the camera
	var cam = Camera.new()
	cam.set_name("Camera")
	vp.add_child(cam)
	
	
	# Linking the ViewportTexture
	var mat = get_material()
	mat.set_shader_param("pgBuffer", vp.get_texture())
	
	
	# Forcing a refresh (hacky method until I find a better one)
	var windowSize = OS.get_window_size()
	_bootlegResizerSize = windowSize
	OS.set_window_size(windowSize - Vector2(1,1))
	_bootlegResizerTimer = 0.2

var _bootlegResizerTimer = 0.0
var _bootlegResizerSize = Vector2(64,64)
func _process(delta):
	if(_bootlegResizerTimer > 0.0):
		_bootlegResizerTimer -= delta
		if(_bootlegResizerTimer <= 0.0):
			OS.set_window_size(_bootlegResizerSize)
