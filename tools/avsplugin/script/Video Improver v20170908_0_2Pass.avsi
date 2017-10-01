SetFilterMTMode("GradFun2DBmod",1)
SetFilterMTMode("aWarp",1)
SetFilterMTMode("aWarp4",1)
SetFilterMTMode("aSobel",1)
SetFilterMTMode("aBlur",1)
SetFilterMTMode("nnedi3_rpow2",1)
SetFilterMTMode("Spline36Resize",1)
SetFilterMTMode("Tweak",1)

lwidth=width
lheight=height

global debug = false

multadd=256                             # hP={32,64,128,256,512,...,seterusnya} [default=128]. Semakin besar, semakin bagus namun semakin besar penggunaan RAMnya.

GradFun2DBmod(\
    LanczosResize(\
        width+((width/2)-((width-multadd)/2)),\
        height+((height/2)-((height-multadd)/2))\
    ),\
	thr = 1.6,\
	mode = 2.2,\
	str = 1,\
	strC = 0.18,\
	temp = 85,\
	adapt = 12,\
	custom = "empty",\
	mask = true,\
	radius = 2,\
	range = 2,\
	show = debug\
)

#Restore ukuran bingkai
   LanczosResize(\
       lwidth,\
       lheight\
   )
#:end

# UnsharpPass Ke-1
#    aWarp(\
#        aSobel.aBlur(),\
#        depth=5,\
#        depthC=-6\
#    )
# :end

# UnsharpPass Ke-2
#    Spline36Resize(\
#        (width*2)-(width-(width/2)),\
#        (height*2)-(height-(height/2))\
#    )
#    aWarp(\
#        aSobel.aBlur(),\
#        depth=-1,\
#        depthC=8\
#    )
# :end

# Restore ukuran bingkai
#    Spline36Resize(\
#        lwidth,\
#        lheight\
#    )
# :end

GradFun2DBmod(\
	thr = 1.2,\
	mode = 2,\
	str = 0.6,\
	strC = 0.2,\
	temp = 48,\
	adapt = 45,\
	mask = true,\
	radius = 2,\
	range = 2\
)

Tweak(\
    sat = 1.08,\
    bright = 0,\
    coring = true,\
    sse = false,\
    dither = true\
)