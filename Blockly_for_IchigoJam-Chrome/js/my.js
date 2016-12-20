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

var setStatus = function(s) {
  document.getElementById("status").innerText = s;
  document.getElementById("btn").innerText = s == "connected" ? "disconnect" : "connect";
};

var conid = -1;
var t = null;

// var setLineNumber = function(e) {
//   var contentsTag = document.getElementById("content_ichigojambasic").getElementsByTagName("span");
//   var code = "";
//   // htmlのタグの中身を取り出す
//   var getContents = function(e) {
//     for (var i = 0; i < contentsTag.length; i++){
//       code += contentsTag[i].innerText;
//     }
//   };
//   getContents();
//
//   var newLineCharNum = (code.match(/\n/g)||[]).length;
//
//   var contentsTag2 = document.getElementById("content_ichigojambasic");
//   var lineNum = 10;
//
//   for (var i = 0; i <= newLineCharNum; i++){
//     var spanNode = document.createElement('span');
//     var textNode = document.createTextNode(lineNum + " ");
//     spanNode.appendChild(textNode);
//     if(i == 0) ? contentsTag2.insertBefore(spanNode,contentsTag2.firstChild); :
//     contentsTag2.appendChild(spanNode);
//     lineNum += 10;
//   }
// };

// var setLineNumber = function(e) {
//   var contentsTag = document.getElementById("content_ichigojambasic").getElementsByTagName("span");
//   var lineNum = 10;
//   for (var i = 0; i < contentsTag.length; i++){
//     if (i == 0){
//       contentsTag[i].innerText = lineNum + " " + contentsTag[i].innerText;
//       lineNum += 10;
//     }
//     console.log("i:" + i)
//     if ((contentsTag[i].innerText.match(/\r/g)||[]).length != 0){
//
//       console.log("contentsTag[" + i + "]:" + contentsTag[i].innerText)
//       // contentsTag[i-1].innerText = contentsTag[i-1].innerText + "\n";
//       // contentsTag[i].innerText = (lineNum + " " + contentsTag[i].innerText).replace(/\n/,"");
//       contentsTag[i].innerText = lineNum + " " + contentsTag[i].innerText;
//       // contentsTag[i].insertBefore(lineNum, contentsTag[i].firstChild)
//       lineNum += 10;
//     }
//   }
// };

var setLineNumber = function(e) {
  var contentsTag = document.getElementById("content_ichigojambasic").getElementsByTagName("span");
  var lineNum = 10;
  var code = "";
  for (var i = 0; i < contentsTag.length; i++){
    code += contentsTag[i].innerText;
  }
  // console.log(code)
  var sliceCode = code.split('');
  // console.log(sliceCode)
  // console.log(sliceCode.length)
  for (var i = 0; i < sliceCode.length; i++) {
    if (i == 0) {
      sliceCode.splice(i, 0, lineNum, " ");
      sliceCode.length += 2;
      lineNum += 10;
    }
    if (sliceCode[i] == "\n") {
      sliceCode.splice(i+1, 0, lineNum, " ");
      sliceCode.length += 2;
      lineNum += 10;
    }
  }
  code = sliceCode.join("");
  console.log(sliceCode)
  // console.log("finalcode:" + code);

  document.getElementById("content_ichigojambasic").innerText = code;
};

var sendToIchigoJam = function(e) {
  console.log("sendToIchigoJam")
  if (conid == -1)
  return;
  // var contentsTag = document.getElementById("content_ichigojambasic").getElementsByTagName("span");
  // var code = "";
  // htmlのタグの中身を取り出す
  // var getContents = function(e) {
  //   for (var i = 0; i < contentsTag.length; i++){
  //     code += contentsTag[i].innerText;
  //   }
  // };
  // getContents();

  var contentsTag = document.getElementById("content_ichigojambasic");
  var sliceCode = contentsTag.innerText.split('');
  // console.log(code)
  // console.log(code.length)
  var buffer = new ArrayBuffer(sliceCode.length + 1);
  // console.log("buffer:" + buffer)
  var view = new Uint8Array(buffer);
  // console.log("viewBefore:" + view)
  console.log(sliceCode)
  // var newLineCount = 0;
  // 文字をキャラクターコードに変換
  for (var i = 0; i < sliceCode.length; i++) {
    view[i] = sliceCode[i].charCodeAt(0);
    // if (view[i] == 10) newLineCount++;
    if (view[i] == 10) {
      console.log("view:" + view)
      view[i] = 1310; // IchigoJamの改行コードはCR+LFなのでCR(13)＋LF(10)?
      console.log("view:" + view)
    }
  }
  console.log("viewAfter:" + view)
  chrome.serial.send(conid, buffer, function(info) {
    console.log("send: " + info.bytesSent);
    chrome.serial.flush(conid, function(res) {
      console.log("flush: " + res);
    });
  });

};

// var sendKey = function(n) {
//   console.log("sendKey(n):" + n)
//   if (conid == -1)
//   return;
//   var abuf = new ArrayBuffer(1);
//   // console.log("abuf:" + abuf)
//   var buf = new Uint8Array(abuf);
//   // console.log("buf:" + buf)
//   buf[0] = n;
//   // console.log("buf[0]:" + buf[0])
//   chrome.serial.send(conid, abuf, function(info) {
//     // console.log("send: " + info.bytesSent);
//     chrome.serial.flush(conid, function(res) {
//       // console.log("flush: " + res);
//     });
//   });
// };

// var sendToIchigoJam = function(e) {
//   console.log("sendToIchigoJam")
//   if (conid == -1)
//   return;
//
//   var contentsTag = document.getElementById("content_ichigojambasic");
//   var sliceCode = contentsTag.innerText.split('');
//   // console.log(code)
//   // console.log(code.length)
//   var buffer = new ArrayBuffer(sliceCode.length);
//   // console.log("buffer:" + buffer)
//   var view = new Uint8Array(buffer);
//   // console.log("viewBefore:" + view)
//   console.log(sliceCode)
//   // var newLineCount = 0;
//   // 文字をキャラクターコードに変換
//   for (var i = 0; i < sliceCode.length; i++) {
//     view[i] = sliceCode[i].charCodeAt(0);
//     if (view[i] == 10) {
//       view[i] = 1310;
//     }
//   }
//   console.log("viewAfter:" + view)
//   while (view.length != 0) {
//     console.log("view[0]:" + view[0])
//     sendKey(view[0]);
//     view = view.slice(1);
//     console.log("view.length:" + view.length)
//   }
// };

var open = function(port) {
  chrome.serial.connect(port, { bitrate: 115200 }, function(info) {
    //	console.log("info: " + info);
    conid = info.connectionId;
    console.log("connectionId: " + conid);
    if (conid == -1) {
      setStatus("connect err");
      return;
    }
    setStatus("connected");
  });
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
    var connect = function() {
      if (conid != -1) {
        chrome.serial.disconnect(conid, function(res) {
          console.log("disconnec: " + res);
          setStatus("Idle");
        });
        conid = -1;
        return;
      }
      open(portsel.value);
    };
    portsel.onchange = connect;
    document.getElementById("btn").onclick = connect;
  });
  document.getElementById("send").onclick = sendToIchigoJam;
  document.getElementById("tab_ichigojambasic").onclick = setLineNumber;
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
