module gfm.freeimage.freeimage;

import std.conv;
import std.string;
import derelict.freeimage.freeimage;
import derelict.util.exception;
import gfm.common.log;
import gfm.freeimage.exception;


final class FreeImage
{
    public
    {
        this(Log log, bool useExternalPlugins = false)
        {
            _log = log;

            try
            {
                DerelictFI.load();
            }
            catch(DerelictException e)
            {
                throw new FreeImageException(e.msg);
            }

            //FreeImage_Initialise(useExternalPlugins ? TRUE : FALSE); // documentation says it's useless
            _libInitialized = true;

            _log.infof("FreeImage %s initialized.", getVersion());
            _log.infof("%s.", getCopyrightMessage());
        }

        ~this()
        {
            close();
        }

        void close()
        {
            if (_libInitialized)
            {
                //FreeImage_DeInitialise(); // documentation says it's useless
                DerelictFI.unload();
                _libInitialized = false;
            }
        }

        string getVersion()
        {
            const(char)* versionZ = FreeImage_GetVersion();
            return to!string(versionZ);
        }

        string getCopyrightMessage()
        {
            const(char)* copyrightZ = FreeImage_GetCopyrightMessage();
            return to!string(copyrightZ);
        }
    }

    package
    {
        Log _log;
    }

    private
    {
        bool _libInitialized;
    }
}
