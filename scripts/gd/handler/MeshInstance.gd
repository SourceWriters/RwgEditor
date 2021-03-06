extends MeshInstance

var noise : OpenSimplexNoise;
var shape : CollisionShape;

func _ready():
	shape = get_child(0).get_child(0);
	noise = OpenSimplexNoise.new();
	noise.octaves = 4;
	noise.period = 20.0;
	noise.persistence = 0.8;
	gen_terrain();
	
func gen_terrain():
	if mesh.get_surface_count() != 0:	
		mesh.surface_remove(0);
	noise.seed = randi();
	
	var arr = [];
	arr.resize(Mesh.ARRAY_MAX);

	var verts = PoolVector3Array();
	var normals = PoolVector3Array();
	var indices = PoolIntArray();
	var uvs = PoolVector2Array();
	
	var index = 0;
	
	var mult = 0.45;
	var ymult = 32;
	
	var size_x = 100;
	var size_z = 100;
	for x in range(size_x):
		var offset = verts.size();
		for z in range(size_z):
			var y : int = int(floor(noise.get_noise_2d(x * mult, z * mult) * ymult));
			var size = verts.size()
			# X border
			if not z == 0:
				indices.append(size - 1)
				indices.append(size - 2)
				indices.append(size + 1)
				indices.append(size - 2)
				indices.append(size)
				indices.append(size + 1)
			# Z border
			if not x == 0:
				var x_index = offset - (size_z * 4) + (z * 4);
				indices.append(x_index + 3);
				indices.append(size + 2);
				indices.append(size);
				indices.append(size);
				indices.append(x_index + 1);
				indices.append(x_index + 3);
				pass
			var vert = Vector3(x, z, y);
			verts.append(vert);
			normals.append(vert.normalized());
			vert = Vector3(x + 1, z, y);
			verts.append(vert);
			normals.append(vert.normalized());
			vert = Vector3(x, z + 1, y);
			verts.append(vert);
			normals.append(vert.normalized());
			vert = Vector3(x + 1, z + 1, y);
			verts.append(vert);
			normals.append(vert.normalized());
			indices.append(size + 2);
			indices.append(size + 3);
			indices.append(size + 1);
			indices.append(size + 1);
			indices.append(size);
			indices.append(size + 2);

	arr[Mesh.ARRAY_VERTEX] = verts;
	arr[Mesh.ARRAY_INDEX] = indices;
	arr[Mesh.ARRAY_NORMAL] = normals;
			
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arr);
	shape.shape = mesh.create_trimesh_shape();

func _on_Button_pressed():
	gen_terrain();
