dir = "..\tools\avsplugin\"

# Baca plug-in
    LoadPlugin(dir + "aWarpSharp.dll")
    LoadPlugin(dir + "RgTools.dll")
    LoadPlugin(dir + "masktools2.dll")
    LoadPlugin(dir + "AddGrainC.dll")
    LoadPlugin(dir + "gradfun2db.dll")
    LoadPlugin(dir + "nnedi3.dll")
    Import(dir + "script\GradFun2DBmod.v1.5.avsi")