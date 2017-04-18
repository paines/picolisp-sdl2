(default
   *SDLlib "libSDL2-2.0.so.0")

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
