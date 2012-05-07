// open a single window
var window = Ti.UI.createWindow({
	backgroundColor:'white'
});
var label = Ti.UI.createLabel({
  text:'ODIN LOADING...',
  color:'#000000',
  top:20,
  left:0,
  right:0
});
window.add(label);
window.open();

var odin = require('com.foodonthetable.odin');
Ti.API.info("module is => " + odin);

var odinText = odin.getODIN();
var macAddrText = odin.getMacAddr();

label.text = odinText + "\n" + macAddrText;

Ti.API.info("ODIN = " + odinText);
Ti.API.info("MACADDR = " + macAddrText);

