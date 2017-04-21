(load "sdl.l")

(seed (in "/dev/urandom" (rd 3)))

(setq *w* 1280)
(setq *h* 720)
(setq pixels (native "@" "malloc" 'N (* *w* *h* 4 )))

(sdl-init SDL_INIT_VIDEO)
(sdl-create-window-and-renderer *w* *h*)

(loop
   (let tex (sdl-create-texture sdl-renderer *w* *h*)
      (for I (* *w* *h*)
         (setq mycolor (rand 1 255))
         (setq c (* mycolor mycolor mycolor))
         (struct (+ pixels (* I 4)) 'N (cons c 8)) )
      (sdl-update-texture tex *w* *h* pixels (* *w* 4))
      (sdl-render-copy sdl-renderer tex *w* *h* *w* *h*)
      (sdl-render-present sdl-renderer)
      (sdl-render-clear sdl-renderer)
      (sdl-destroy-texture tex) ) )


#actually, we do not ever reach this point atm
(sdl-delay 4000)
(sdl-quit)
(bye)
