module gfm.sdl2.surface;

import derelict.sdl2.sdl;

import gfm.sdl2.sdl;
import gfm.sdl2.exception;
import gfm.math.smallvector;


final class SDL2Surface
{
    public
    {
        enum Owned
        {
            NO, YES
        }

        this(SDL2 sdl2, SDL_Surface* surface, Owned owned)
        {
            assert(surface !is null);
            _sdl2 = sdl2;
            _surface = surface;
            _owned = owned;
        }      

        void close()
        {
            if (_surface !is null)
            {
                if (_owned == Owned.YES)
                    SDL_FreeSurface(_surface);
                _surface = null;
            }
        }


        ~this()
        {
            close();
        }

        @property int width() const
        {
            return _surface.w;
        }

        @property int height() const
        {
            return _surface.h;
        }

        ubyte* pixels()
        {
            return cast(ubyte*) _surface.pixels;
        }
    }

    package
    {
        SDL2 _sdl2;
        SDL_Surface* _surface;
        Owned _owned;
    }
}
