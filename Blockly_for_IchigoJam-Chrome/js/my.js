document.getElementById('languageMenu').setAttribute("style", "display:none");
var container = document.getElementById('content_area');
var margin_off = function(e) {
  var bBox = Code.getBBox_(container);
  for (var i = 0; i < Code.TABS_.length; i++) {
    var el = document.getElementById('content_' + Code.TABS_[i]);
    el.style.top = bBox.y + 'px';
    el.style.left = bBox.x + 'px';
    // Height and width need to be set, read back, then set again to
    // compensate for scrollbars.
    el.style.height = bBox.height + 'px';
    el.style.height = (2 * bBox.height - el.offsetHeight) + 'px';
    el.style.width = bBox.width + 'px';
    el.style.width = (2 * bBox.width - el.offsetWidth) + 'px';
  }
  // Make the 'Blocks' tab line up with the toolbox.
  if (Code.workspace && Code.workspace.toolbox_.width) {
    document.getElementById('tab_blocks').style.minWidth =
    (Code.workspace.toolbox_.width - 38) + 'px';
    // Account for the 19 pixel margin and on each side.
  }
};

window.onload = function() {
  margin_off();  // 謎マージンを消す
  chrome.serial.getDevices(function(ports) {
    console.log(ports.length);
    var portsel = document.getElementById("portsel");
    for (var i = ports.length - 1; i >= 0; i--) {
      var port = ports[i];
      console.log(port.path);
      var opt = document.createElement("option");
      opt.value = opt.innerText = port.path;
      portsel.appendChild(opt);
    }
  });
};

// ブロックの彩度を変更
// Blockly.HSV_SATURATION = 1.00;
// Blockly.HSV_VALUE = 1.00;

// IchigoJamBASIC以外の言語と実行ボタンと全消去ボタンを非表示に
// 全消去ボタンはconfirm()を使用しているが、ChromeAppsでは使用できないためどうするのか検討
document.getElementById('trashButton').setAttribute("style", "display:none");
document.getElementById('runButton').setAttribute("style", "display:none");
document.getElementById('tab_javascript').setAttribute("style", "display:none");
document.getElementById('tab_python').setAttribute("style", "display:none");
document.getElementById('tab_php').setAttribute("style", "display:none");
document.getElementById('tab_lua').setAttribute("style", "display:none");
document.getElementById('tab_dart').setAttribute("style", "display:none");
document.getElementById('tab_xml').setAttribute("style", "display:none");
