class_name VsObject

static func create_reference(var script) -> Reference:
	var object : Reference = Reference.new();
	object.set_script(script);
	return object;

static func get_(var array : Array, var index : int) -> Object:
	return array[index];
