module ui.idle;

import matrix;
import matrix.api;

extern(C) static int onIdle(void* data) nothrow
{
  import std.string : capitalize;

  import ui.main_window : mainWindow;

  static foreach (Method; Methods)
  {
    try
    {
      auto result = take!(mixin(Method ~ `!(Kind.Response)`), false)();
      if (result.status.ok)
      {
        mixin(`mainWindow.on` ~ result.responseType.capitalize ~ `Complete`)(result);
      }
    } catch (Throwable t) {}
  }

  if (!STATE.connected)
  {
    return 0;
  }

  return 1;
}
