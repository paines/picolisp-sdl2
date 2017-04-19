
(de *w* 1280)
(de *h* 720)

(setq pixels (native "@" "malloc" 'N (* *w* *h*)))


(sdl-init SDL_INIT_VIDEO)

(sdl-create-window-and-renderer *w* *h*)

(de tex (sdl-create-texture sdl-renderer *w* *h*))

(let j (* *w* 4)
   (loop
      (let j (* *h)
         (loop
            (setq col (xor i j))
            (struct (+ pixels 4) 'N '(col . 8)) 
            (T (=0 (- (* *w* *h* 4) 4)) 'done) ) ) ) )


(sdl-update-texture tex *w* *h* pixels (* *w* 4))
(sdl-render-clear sdl-renderer)
(sdl-render-copy renderer tex *w* *h* *w* *h*)
(sdl-render-present sdl-renderer)
(sdl-destroy-texture tex)

(sdl-delay 5000)

(sdl-quit)
