:: Hak Cipta ©2017
:: @neon-nyan / codeneon
:: [codeneon123@gmail.com]
:: 
:: Di bawah Hak Cipta MIT License
:: [https://github.com/neon-nyan/xAutoBatch/raw/master/LICENSE]

:CheckComponent
    if /i not exist "%file.exec.encoder.video.x264.10bit%" msg * File: %file.exec.encoder.video.x264.10bit% tidak ditemukan.
    if /i not exist "%file.exec.encoder.video.x264.8bit%" msg * File: %file.exec.encoder.video.x264.8bit% tidak ditemukan.
    if /i not exist "%file.exec.msys.tee%" msg * File: %file.exec.msys.tee% tidak ditemukan.
    if /i not exist "%file.exec.avs.preview%" msg * File: %file.exec.avs.preview% tidak ditemukan.
    if /i not exist "%file.exec.muxer%" msg * File: %file.exec.muxer% tidak ditemukan.
    if /i not exist "%file.exec.encoder.audio.opus%" msg * File: %file.exec.encoder.audio.opus% tidak ditemukan.
    if /i not exist "%file.exec.encoder.audio.aac%" msg * File: %file.exec.encoder.audio.aac% tidak ditemukan.
    if /i not exist "%file.exec.encoder.audio.vorbis%" msg * File: %file.exec.encoder.audio.vorbis% tidak ditemukan.
    if /i not exist "%file.exec.encoder.audio.flac%" msg * File: %file.exec.encoder.audio.flac% tidak ditemukan.

:__end