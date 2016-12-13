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
// 謎マージンを消す
(window.onload = function() {
 margin_off();
})();

// value input fieldsの括弧を消す
// var brackets_off = function(e) {
// 予定
// };

// ブロックの彩度を変更
// Blockly.HSV_SATURATION = 1.00;
// Blockly.HSV_VALUE = 1.00;
