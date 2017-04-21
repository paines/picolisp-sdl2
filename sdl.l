(default
   *SDLlib "libSDL2-2.0.so.0")

;;some globals
(de sdl-window 0)
(de sdl-renderer 0)

(def 'SDL_INIT_TIMER          (hex "00000001"))
(def 'SDL_INIT_AUDIO          (hex "00000010"))
(def 'SDL_INIT_VIDEO          (hex "00000020"))
(def 'SDL_INIT_JOYSTICK       (hex "00000200"))
(def 'SDL_INIT_HAPTIC         (hex "00001000"))
(def 'SDL_INIT_GAMECONTROLLER (hex "00002000"))
(def 'SDL_INIT_EVENTS         (hex "00004000"))
(def 'SDL_INIT_NOPARACHUTE    (hex "00100000"))
(def 'SDL_INIT_EVERYTHING     (hex (+ SDL_INIT_TIMER SDL_INIT_AUDIO SDL_INIT_VIDEO SDL_INIT_EVENTS SDL_INIT_JOYSTICK SDL_INIT_HAPTIC SDL_INIT_GAMECONTROLLER)))

;;graphics stuff
(def 'SDL_PIXELFORMAT_ARGB8888 372645892) 
(def 'SDL_TEXTUREACCESS_STREAMING 1)

;;event stuff

(def 'SDL_KEYDOWN (hex 300))
(def 'SDL_KEYUP (hex 301))

(def 'SDL_MOUSEMOTION (hex 400))
(def 'SDL_MOUSEBUTTONDOWN (hex 401))
(def 'SDL_MOUSEBUTTONUP (hex 402))
(def 'SDL_MOUSEWHEEL (hex 403))

;;functions

(de sdl-init (params)
   (native `*SDLlib "SDL_Init" 'I params) )

(de sdl-was-init (flags)
   (native `*SDLlib "SDL_WasInit" 'N flags))

(de sdl-show-window (win)
   (native `*SDLlib "SDL_ShowWindow") 'N win )

(de sdl-create-window-and-renderer (width height)
   ;SDL_Window window
   (setq sdl-window (native `*SDLlib "SDL_CreateWindow" 'N "PicoLisp SDL2" 0 0 width height 0))
   (setq sdl-renderer (native `*SDLlib "SDL_CreateRenderer" 'N sdl-window 0 0))
   (sdl-show-window sdl-window))

(de sdl-destroy-renderer (renderer)
   (native `*SDLlib "SDL_DestroyRenderer" 'N renderer) )

(de sdl-destroy-window (window)
   (native `*SDLlib "SDL_DestroyWindow" 'N window) )

(de sdl-quit ()
   (native `*SDLlib "SDL_Quit" 'N))

(de sdl-delay (val)
   (native `*SDLlib "SDL_Delay" 'N val))

(de sdl-render-clear (renderer)
   (native `*SDLlib "SDL_RenderClear" 'N renderer) )

(de sdl-create-texture (renderer width height)
   (native `*SDLlib "SDL_CreateTexture" 'N renderer SDL_PIXELFORMAT_ARGB8888 SDL_TEXTUREACCESS_STREAMING width height) )

(de sdl-update-texture (texture width height pixels pitch)
    (native `*SDLlib "SDL_UpdateTexture" 'N texture (list NIL (16) (cons 0 4) (cons 0 4) (cons width 4) (cons height 4)) pixels pitch))
    #(native `*SDLlib "SDL_UpdateTexture" 'N texture NIL pixels pitch))

(de sdl-render-copy (renderer tex width0 height0 width1 height1 )
   #(native `*SDLlib "SDL_RenderCopy" 'N renderer tex NIL NIL))
   (native `*SDLlib "SDL_RenderCopy" 'N renderer tex
      (list NIL (16) (cons 0 4) (cons 0 4) (cons width0 4) (cons height0 4))
      (list NIL (16) (cons 0 4) (cons 0 4) (cons width1 4) (cons height1 4))))

(de sdl-render-present (renderer)
   (native `*SDLlib "SDL_RenderPresent" 'N renderer) )

(de sdl-destroy-texture (tex)
   (native `*SDLlib "SDL_DestroyTexture" 'N tex))

(de sdl-poll-event (event)
   (native `*SDLlib "SDL_PollEvent" 'N event))

(de sdl-set-render-draw-color (renderer r g b a)
	(native `*SDLlib "SDL_SetRenderDrawColor" 'N renderer r g b a))

(de sdl-render-draw-point (renderer x y)
	(native `*SDLlib "SDL_RenderDrawPoint" 'N renderer x y))

