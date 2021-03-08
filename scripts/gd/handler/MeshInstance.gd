extends MeshInstance

func _ready():
	var arr = [];
	arr.resize(Mesh.ARRAY_MAX);

	var verts = PoolVector3Array();
	var normals = PoolVector3Array();
	var indices = PoolIntArray();
	
	var index = 0;
	
	var size_x = 100;
	var size_z = 100;
	for x in range(size_x):
		var offset = verts.size();
		for z in range(size_z):
			var y : int = int(floor(sin(x * size_x + z) * 3));
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
	
	
	
