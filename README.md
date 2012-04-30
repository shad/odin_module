ODIN (Module for Titanium)
===========================================

Apple is removing support for UDID on the iPhone.  Open Device Identification
Number (ODIN) is replacement identifier required by some ad networks as
a replacement.  ODIN is basically a sha hash of the MAC Address.

For more information, please see: http://www.odinmobile.org/

This module simply wraps up ODIN generation into a titanium module.

NOTE: This was built with Titanium 1.7.0 and has not been tested against
any other version.


INSTALL
-------

Place the module zip (com.fott.odin-iphone-0.1.zip) your modules directory (I
typically unzip it there, but I'm not sure that's actually required).

Register your module with your application by editing `tiapp.xml` and adding
your module.  Example:

    <modules>
      <module version="0.1">com.fott.odin</module>
    </modules>



USING YOUR MODULE IN CODE
-------------------------

To use your module in code, you will need to require it. 

Example:

    var odin_module = require('com.fott.odin');
    var odin = odin_module.getODIN();

NOTE (Fair Warning)
-------------------
This code is provided AS IS.  Feel free to fork and modify it to your heart's
content.  I'm happy to answer questions, but will likely not be actively
maintaining this project.
