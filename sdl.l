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
(def 'SDL_PIXELFORMAT_ARGB8888 372645892) ;; value taken via 	printf("SDL_PIXELFORMAT_ARGB8888 = %d\n", SDL_PIXELFORMAT_ARGB8888);
(def 'SDL_TEXTUREACCESS_STREAMING 1) ;; 	printf("SDL_TEXTUREACCESS_STREAMING= %d\n", SDL_TEXTUREACCESS_STREAMING);

;;event stuff

(def 'SDL_KEYDOWN (hex 300))
(def 'SDL_KEYUP (hex 301))

(def 'SDL_MOUSEMOTION (hex 400))
(def 'SDL_MOUSEBUTTONDOWN (hex 401))
(def 'SDL_MOUSEBUTTONUP (hex 402))
(def 'SDL_MOUSEWHEEL (hex 403))



(de sdl-poll-event (event)
   (native `*SDLlib "SDL_PollEvent" 'N event))

(de sdl-create-texture (renderer width height)
   (native `*SDLlib "SDL_CreateTexture" 'N renderer SDL_PIXELFORMAT_ARGB8888 SDL_TEXTUREACCESS_STREAMING width height) )


;;manipulate pixels in this way
;;(setq p (native "@" "malloc" 'N (* width height)))
;;loop over i from 0 to width*height*4
;;(struct (+ p i) 'N '(value . 8)) ;write, i iterates plus 4 NOT 1
;;(struct (+ p i) '(N))
;;pixels is then p
;;pitch is width * 4

(de sdl-update-texture (texture width height pixels pitch)
   (native `*SDLlib "SDL_UpdateTexture" 'N texture '(0 0 width height) pixels pitch))


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
   (setq sdl-renderer (native `*SDLlib "SDL_CreateRenderer" 'N sdl-window -1 0))
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

(de sdl-render-copy (renderer tex width0 height0 width1 height1 )
   (native `*SDLlib "SDL_RenderCopy" 'N renderer tex '(0 0 width0 height0) '(0 0 width1 height1)))

(de sdl-render-present (renderer)
   (native `*SDLlib "SDL_RenderPresent" 'N renderer) )

(de sdl-destroy-texture (tex)
   (native `*SDLlib "SDL_DestroyTexture" 'N tex))
