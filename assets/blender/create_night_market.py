"""Create the original paper-cut night market diorama and export it as GLB.

Run with:
  blender.exe --background --python assets/blender/create_night_market.py
"""
import math
import os
import bpy
from mathutils import Vector

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
BLEND_PATH = os.path.join(ROOT, "assets", "blender", "night_market.blend")
GLB_PATH = os.path.join(ROOT, "assets", "models", "night_market_diorama.glb")
PREVIEW_PATH = os.path.join(ROOT, "assets", "art", "night_market_preview.png")

os.makedirs(os.path.dirname(BLEND_PATH), exist_ok=True)
os.makedirs(os.path.dirname(GLB_PATH), exist_ok=True)
os.makedirs(os.path.dirname(PREVIEW_PATH), exist_ok=True)

for obj in list(bpy.data.objects):
    bpy.data.objects.remove(obj, do_unlink=True)
for material in list(bpy.data.materials):
    bpy.data.materials.remove(material)

def color(hex_value):
    value = hex_value.lstrip("#")
    rgb = [int(value[index:index + 2], 16) / 255.0 for index in (0, 2, 4)]
    return tuple(channel / 12.92 if channel <= 0.04045 else ((channel + 0.055) / 1.055) ** 2.4 for channel in rgb)

def make_material(name, hex_value, roughness=0.86, emission=0.0):
    material = bpy.data.materials.new(name)
    material.diffuse_color = (*color(hex_value), 1.0)
    material.use_nodes = True
    bsdf = material.node_tree.nodes.get("Principled BSDF")
    if bsdf:
        bsdf.inputs["Base Color"].default_value = (*color(hex_value), 1.0)
        bsdf.inputs["Roughness"].default_value = roughness
        if "Emission Color" in bsdf.inputs:
            bsdf.inputs["Emission Color"].default_value = (*color(hex_value), 1.0)
            bsdf.inputs["Emission Strength"].default_value = emission
    return material

M = {
    "sky": make_material("Paper · midnight teal", "#263E49"),
    "sky_light": make_material("Paper · mist blue", "#99B9B2"),
    "hill": make_material("Paper · eucalyptus", "#617E72"),
    "hill_light": make_material("Paper · sage", "#9EB39B"),
    "ground": make_material("Paper · warm sand", "#C49A70"),
    "path": make_material("Paper · brick path", "#A97354"),
    "red": make_material("Paper · persimmon", "#C95E49"),
    "red_light": make_material("Paper · coral", "#E27B5F"),
    "cream": make_material("Paper · moon cream", "#F1DDAF"),
    "gold": make_material("Paper · lantern gold", "#E5BA5B", emission=0.35),
    "teal": make_material("Paper · deep green", "#426B64"),
    "blue": make_material("Paper · indigo", "#546D80"),
    "brown": make_material("Paper · cocoa", "#593F38"),
    "peach": make_material("Paper · warm peach", "#E9B893"),
    "ink": make_material("Paper · dark ink", "#302D32"),
    "plum": make_material("Paper · plum", "#78546A"),
}

def extruded_polygon(name, points, material, y=0.0, depth=0.18, bevel=0.025):
    """Extrude a 2D (x,z) paper-cut polygon toward/away from the front camera."""
    count = len(points)
    front_y, back_y = y - depth / 2, y + depth / 2
    vertices = [(x, front_y, z) for x, z in points] + [(x, back_y, z) for x, z in points]
    faces = [tuple(range(count)), tuple(range(count, count * 2))[::-1]]
    for index in range(count):
        nxt = (index + 1) % count
        faces.append((index, nxt, nxt + count, index + count))
    mesh = bpy.data.meshes.new(name + " · mesh")
    mesh.from_pydata(vertices, [], faces)
    mesh.materials.append(material)
    mesh.update()
    obj = bpy.data.objects.new(name, mesh)
    bpy.context.collection.objects.link(obj)
    if bevel:
        modifier = obj.modifiers.new("Soft paper edge", "BEVEL")
        modifier.width = bevel
        modifier.segments = 1
        modifier.affect = "EDGES"
        obj.modifiers.new("Paper normals", "WEIGHTED_NORMAL")
    return obj

def box(name, location, scale, material, bevel=0.035):
    bpy.ops.mesh.primitive_cube_add(size=1, location=location)
    obj = bpy.context.object
    obj.name = name
    obj.dimensions = scale
    bpy.ops.object.transform_apply(location=False, rotation=False, scale=True)
    obj.data.materials.append(material)
    if bevel:
        mod = obj.modifiers.new("Rounded paper corners", "BEVEL")
        mod.width = bevel
        mod.segments = 1
        obj.modifiers.new("Paper normals", "WEIGHTED_NORMAL")
    return obj

def sphere(name, location, scale, material, segments=16, rings=8):
    bpy.ops.mesh.primitive_uv_sphere_add(segments=segments, ring_count=rings, radius=1, location=location)
    obj = bpy.context.object
    obj.name = name
    obj.scale = scale
    bpy.ops.object.transform_apply(location=False, rotation=False, scale=True)
    obj.data.materials.append(material)
    for face in obj.data.polygons:
        face.use_smooth = True
    return obj

def paper_star(name, x, z, size, material, y=-0.2):
    points = []
    for i in range(8):
        angle = math.pi * i / 4 + math.pi / 8
        radius = size if i % 2 == 0 else size * 0.28
        points.append((x + math.cos(angle) * radius, z + math.sin(angle) * radius))
    return extruded_polygon(name, points, material, y=y, depth=0.07, bevel=0.006)

# A calm layered sky and rolling paper hills (16 x 9 scene, Blender XY composition).
extruded_polygon("Night sky · deep sheet", [(-8, 0), (8, 0), (8, 9), (-8, 9)], M["sky"], y=1.25, depth=0.15, bevel=0)
extruded_polygon("Distant mist · cut sheet", [(-8, 1.6), (-6.4, 2.7), (-5.0, 2.2), (-3.3, 3.2), (-1.4, 2.4), (0.5, 3.0), (2.2, 2.1), (4.5, 3.1), (6.2, 2.4), (8, 3.0), (8, 0), (-8, 0)], M["sky_light"], y=0.8, depth=0.13)
extruded_polygon("Far hill · green paper", [(-8, 0.8), (-6.5, 1.5), (-4.7, 1.25), (-3.0, 2.0), (-1.0, 1.3), (1.0, 2.0), (3.4, 1.2), (5.0, 1.8), (6.8, 1.2), (8, 1.7), (8, 0), (-8, 0)], M["hill"], y=0.35, depth=0.16)
extruded_polygon("Market ground · cut paper", [(-8, 0), (8, 0), (8, 1.15), (5.2, 0.85), (2.1, 1.3), (-1.0, 0.9), (-4.6, 1.3), (-8, 0.9)], M["ground"], y=0.0, depth=0.2)

# Moon, stars, and a string of paper pennants.
sphere("Full moon · paper disk", (5.0, 0.68, 7.0), (0.76, 0.12, 0.76), M["cream"], 20, 10)
for index, (x, z, size) in enumerate([(-6.2, 7.35, .18), (-4.1, 6.35, .13), (-2.1, 7.55, .16), (0.2, 6.75, .12), (2.2, 7.8, .17), (6.6, 5.85, .14), (7.25, 7.45, .1), (-6.8, 5.7, .1)]):
    paper_star("Star · cut foil %02d" % index, x, z, size, M["gold"] if index % 2 else M["cream"])
extruded_polygon("Pennant string", [(-7.3, 7.85), (-7.25, 7.90), (7.25, 6.95), (7.25, 6.88)], M["brown"], y=-0.18, depth=0.035, bevel=0)
for index, x in enumerate([-6.7, -5.5, -4.3, -3.1, -1.9, -.7, .5, 1.7, 2.9, 4.1, 5.3, 6.5]):
    z = 7.75 - (x + 7.3) * .066
    cloth = M["red"] if index % 2 == 0 else M["cream"]
    extruded_polygon("Pennant · %02d" % index, [(x, z), (x + .65, z - .04), (x + .32, z - .5)], cloth, y=-0.25, depth=.06, bevel=.012)

# Giant lantern: scale contrast creates the fantasy beat without imitating the source game.
extruded_polygon("Lantern cord", [(-4.15, 8.5), (-4.05, 8.5), (-4.05, 6.45), (-4.15, 6.45)], M["brown"], y=-.55, depth=.07, bevel=.02)
sphere("Moon lantern · glowing paper", (-4.1, -0.62, 5.95), (0.8, 0.19, 1.05), M["gold"], 20, 12)
box("Lantern cap", (-4.1, -.65, 6.92), (.76, .18, .18), M["red"], .06)
box("Lantern tassel", (-4.1, -.64, 4.82), (.13, .16, .45), M["red"], .04)
for x in [-4.48, -4.1, -3.72]:
    extruded_polygon("Lantern rib", [(x, 5.12), (x + .06, 5.12), (x + .06, 6.72), (x, 6.72)], M["cream"], y=-.86, depth=.035, bevel=.01)

# Paper-cut stall: roof, striped awning, counter, jars and little hanging price cards.
extruded_polygon("Market stall · canopy backing", [(2.55, 4.85), (4.6, 6.05), (6.75, 4.85), (6.45, 4.46), (2.85, 4.46)], M["red"], y=-.30, depth=.34, bevel=.035)
for index in range(7):
    x = 2.82 + index * .54
    extruded_polygon("Awning stripe · %02d" % index, [(x, 4.91 + abs(index - 3) * .28), (x + .28, 5.07 + abs(index - 3) * .15), (x + .28, 4.48), (x, 4.48)], M["cream"] if index % 2 == 0 else M["red_light"], y=-.54, depth=.05, bevel=.008)
box("Stall counter", (4.65, -.32, 3.25), (4.3, .48, .56), M["brown"], .09)
box("Counter paper top", (4.65, -.62, 3.57), (4.5, .24, .16), M["cream"], .045)
for x in [2.85, 6.45]:
    box("Stall post", (x, -.3, 3.95), (.16, .22, 1.65), M["teal"], .025)
    box("Post foot", (x, -.33, 3.02), (.32, .4, .15), M["red"], .025)
box("Back shelf", (4.65, -.22, 4.05), (3.35, .2, .16), M["gold"], .025)
for index, (x, z, material) in enumerate([(3.4, 3.9, M["plum"]), (4.05, 3.88, M["teal"]), (4.75, 3.9, M["red_light"]), (5.42, 3.9, M["blue"]), (3.68, 3.0, M["gold"]), (5.15, 3.02, M["cream"])]):
    sphere("Moon candy jar · %02d" % index, (x, -.75, z), (.18, .16, .26), material, 12, 6)
    box("Jar lid · %02d" % index, (x, -.75, z + .24), (.25, .18, .07), M["cream"], .025)
extruded_polygon("Menu card", [(5.75, 4.55), (6.35, 4.55), (6.35, 4.04), (5.75, 4.04)], M["cream"], y=-.63, depth=.04, bevel=.025)
paper_star("Menu star", 6.05, 4.32, .13, M["red"], y=-.68)

# Original tiny traveler with a coral coat and soft paper hood.
extruded_polygon("Traveler · cloak", [(-1.95, 1.0), (-.65, 1.0), (-.88, 3.0), (-1.18, 3.42), (-1.56, 3.4), (-1.78, 3.0)], M["red"], y=-1.0, depth=.48, bevel=.07)
sphere("Traveler · face", (-1.3, -1.25, 3.35), (.36, .26, .4), M["peach"], 16, 8)
extruded_polygon("Traveler · paper hood", [(-1.78, 3.35), (-1.66, 3.8), (-1.31, 4.08), (-.93, 3.82), (-.82, 3.35), (-1.08, 3.16), (-1.48, 3.16)], M["gold"], y=-1.43, depth=.16, bevel=.04)
extruded_polygon("Traveler · hood shadow", [(-1.68, 3.47), (-1.31, 3.72), (-.92, 3.45), (-1.02, 3.21), (-1.54, 3.19)], M["brown"], y=-1.53, depth=.045, bevel=.02)
box("Traveler · left shoe", (-1.68, -1.18, .94), (.5, .34, .18), M["brown"], .06)
box("Traveler · right shoe", (-.92, -1.18, .94), (.5, .34, .18), M["brown"], .06)

# Coins and paper paths tie the market to the budgeting decision.
for index, (x, z) in enumerate([(-3.0, 2.0), (-2.52, 1.83), (-2.05, 2.07)]):
    sphere("Dream coin · %02d" % index, (x, -.7, z), (.18, .055, .18), M["gold"], 12, 6)
    paper_star("Coin mark · %02d" % index, x, z, .07, M["cream"], y=-.77)
extruded_polygon("Winding market path", [(-7.8, .15), (-5.9, .15), (-4.9, .54), (-3.6, .24), (-2.5, .68), (-1.2, .28), (.2, .75), (1.5, .46), (2.6, .8), (4.2, .6), (7.6, .9), (7.6, .55), (4.2, .3), (2.4, .48), (.3, .14), (-1.2, -.05), (-2.5, .28), (-3.6, -.1), (-4.9, .2), (-5.9, -.12), (-7.8, -.12)], M["path"], y=-.14, depth=.05, bevel=0)

# Renderable source scene for artist iteration. The GLB excludes camera and lights.
scene = bpy.context.scene
scene.render.engine = "CYCLES"
scene.cycles.samples = 24
scene.render.resolution_x = 1280
scene.render.resolution_y = 720
scene.render.resolution_percentage = 60
scene.render.image_settings.file_format = "PNG"
scene.render.filepath = PREVIEW_PATH
scene.world.color = color("#25333B")
camera_data = bpy.data.cameras.new("Diorama Camera")
camera = bpy.data.objects.new("Diorama Camera", camera_data)
bpy.context.collection.objects.link(camera)
camera.location = (0, -24, 4.5)
camera.rotation_euler = (math.radians(90), 0, 0)
camera.data.type = "ORTHO"
camera.data.ortho_scale = 16.0
scene.camera = camera
area_data = bpy.data.lights.new("Softbox", type="AREA")
area = bpy.data.objects.new("Softbox", area_data)
bpy.context.collection.objects.link(area)
area.location = (-2, -8, 10)
area.rotation_euler = (math.radians(25), 0, math.radians(-12))
area.data.energy = 1500
area.data.shape = "DISK"
area.data.size = 12
scene.view_settings.view_transform = "AgX"
bpy.ops.wm.save_as_mainfile(filepath=BLEND_PATH)
bpy.ops.render.render(write_still=True)

# Export only model geometry; the Godot scene owns its camera and lighting.
bpy.ops.object.select_all(action="DESELECT")
for obj in scene.objects:
    if obj.type == "MESH":
        obj.select_set(True)
bpy.context.view_layer.objects.active = next(obj for obj in scene.objects if obj.type == "MESH")
bpy.ops.export_scene.gltf(filepath=GLB_PATH, export_format="GLB", use_selection=True, export_apply=True, export_yup=True, export_materials="EXPORT", export_cameras=False, export_lights=False)
print("Created:", BLEND_PATH, GLB_PATH, PREVIEW_PATH)
