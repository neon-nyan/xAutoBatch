lwidth=width
lheight=height

global debug = false

multadd=128                             # hP={32,64,128,256,512,...,seterusnya} [default=128]. Semakin besar, semakin bagus namun semakin besar penggunaan RAMnya.

GradFun2DBmod(\
    LanczosResize(\
        width+((width/2)-((width-multadd)/2)),\
        height+((height/2)-((height-multadd)/2))\
    ),\
    thr = 1.1,\
    mode = 2,\
    str = 0.98,\
    strC = 0.12,\
    temp = 85,\
    adapt = 23,\
    custom = "empty",\
    mask = true,\
    radius = 2,\
    range = 2,\
    show = debug\
)

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

#Restore ukuran bingkai
   LanczosResize(\
       lwidth,\
       lheight\
   )
#:end

Tweak(\
    sat = 1.08,\
    bright = 0,\
    coring = true,\
    sse = false,\
    dither = true\
)