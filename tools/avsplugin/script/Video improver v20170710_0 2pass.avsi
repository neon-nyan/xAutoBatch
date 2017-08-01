###################################################################################################################
##
##    Video improver v20170710_0
##    oleh: codeneon
##
###################################################################################################################
##
##    Dibutuhkan:
##        1. Avisynth+ r1858 atau diatasnya.
##        2. aWarpSharp2 v2012.03.28 atau diatasnya.
##        3. flash3kyuu_deband 1.5.1 atau diatasnya.
##        4. RgTools v0.96 atau diatasnya.
##        5. FluxSmooth v1.1b atau diatasnya (disarankan dengan SSSE3 Accel. Support).
##
###################################################################################################################
##
##    Release Note:
##        - v0.9_alpha
##            - Rilisan pertama. Perubahan belum tersentuh sama sekali.
##        - v20170620_0
##            - Pengkonversian colorspace lebih dulu.
##            - Mengurangi penggunaan Memori Maksimal dari 1 GB -> 512 MB.
##            - Sedikit perbaikan dalam algoritma penghitungan aritmatika.
##            - Threshold diubah ke 86 dan pass 2 -> 3.
##            - Penambahan Tweaking untuk memperbaiki warna yang rusak akibat pengkonversian colorspace.
##            - Perbaikan dalam penulisan syntax.
##                - Ganti tipe EndLine/EOL dari CRLF [Windows] ke LF [Unix].
##                - Ganti Tab menjadi 4x Space untuk support editing script pada OS berbasis Unix/Linux.
##            - Prefetch dan Threading tidak dibutuhkan lagi karena akan di auto-detect oleh avisynth.
##            - Improvement pada debanding menjadi sedikit lebih akurat.
##                - Penambahan plug-in RgTools dan FluxSmooth. Untuk mengurangi Ringing akibat proses
##                  debanding oleh plugin f3k deband.
##                    catatan: Mungkin akan berdampak terhadap Performa pada saat Pre-Processing.
##                - Plug-in GradFun2DB tidak digunakan lagi karena tidak berfungsi pada Avisynth MT.
##        - v20170621_0
##            - Order Priority f3k Deband menjadi paling awal. Hal ini mencegah "thinning line" dan noise yang
##              berlebihan.
##            - Threshold aWarpSharp menjadi 22. Jadi plug-in ini sekarang hanya sebatas pembantu untuk denoising/
##              degraining dengan cara memblur luma dan chroma dan menajamkannya kembali.
##            - Degraining/Denoising sekarang menjadi bagian dari fungsi Plugin f3k Deband.
##            - Order Priority FluxSmoothST dipisahkan dari Degraining :'( .
##            - Tweaking sekarang tidak membutuhkan pengkonversian ke Colorspace RGB untuk output. Jadi, hanya
##              pengkoreksi saturasi dan brightness akibat dari ke-4 plugin yang sudah dijalankan.
##            - Kini prefix folder untuk plugin dipisahkan dari script. Jadi, anda bisa mengaturnya sendiri.
##            - Degrain Lebih banyak. :v
##        - v20170710_0
##            - Proses Pemfilteran kini menjadi 2 tahapan.
##
###################################################################################################################

# Pre-Eksekusi
    SetMemoryMax(512)
    ConvertToYV12                                                            # Convert colorspace RGB -> YV12 untuk Proses Debanding dan Unsharp

# Set environment degrain/denoise
    global degval = 3                                                        # Setel mode degrain. Untuk value bisa dilihat di: http://avisynth.nl/index.php/RgTools/RemoveGrain
    if (degval > 24) { degval = 3 }                                            # Bila mode bukan area (-1) - 24, maka kembalikan degval -> 3.

## 1 Pass

	# Eksekusi fungsi script: GradFun2DBMod
		global debug = false
		GradFun2DBmod(\
			thr = 2.2, \
			thrC = 3.1,\
			mode = 2,\
			str = 0.8,\
			strC = 0.15,\
			temp = 50,\
			adapt = 64,\
			custom = "empty",\
			mask = true,\
			radius = 1,\
			range = 2\
		)

	# Eksekusi Plug-in: aWarpSharp
		thr = 24                                                                # Threshold Masking.
		chtype = 3                                                                    # Tipe Chroma: 0 = chroma=0, 1 = default, 2 = copy dari source, 3 = proses chroma, 4 = gunakan pemrosesan hanya untuk aWarp, aWarpSharp, dan aWarp4, 5 = sama seperti 3 namun tidak memperhitungkan luma, 6 = sama seperti 4 namun tidak memperhitungkan luma.
		global dptpass = 2                                                            # Depth Pass: 1 = 1pass, 2 = 2pass, 3 = Extreme.
		if (dptpass > 3) {                                                            # Bila dptpass > 3, maka kembalikan dptpass -> 2.
			dptpass = 2
			dpt = 16*(1+dptpass)/2                                                # Hitung jumlah Depth.
		} else {                                                                    # Kembalikan value dptpass bila dptpass x< atau == 3 :D.
			dptpass = dptpass
			dpt = 16*(1+dptpass)/2                                                    # Hitung jumlah Depth
		}
		aWarpSharp2(\
			thresh = thr,\
			depth = dpt,\
			chroma = chtype\
		)

## 2 Pass

	# Eksekusi fungsi script: GradFun2DBMod
		GradFun2DBmod(\
			thr = 1.9, \
			thrC = 2.3,\
			mode = 2,\
			str = 0.8,\
			strC = 0.12,\
			temp = 50,\
			adapt = 64,\
			custom = "empty",\
			mask = true,\
			radius = 1,\
			range = 2,\
			screenW = 1920,\
			screenH = 1080,\
			show = debug\
		)

	# Eksekusi Plug-in: aWarpSharp
		aWarpSharp2(\
			thresh = thr,\
			depth = dpt,\
			chroma = chtype\
		)

# Tweaking untuk koreksi warna akibat konversi colorspace.
    Tweak(\
        sat = 1.08,\
        bright = 0,\
        coring = true,\
        sse = false,\
        dither = true\
    )