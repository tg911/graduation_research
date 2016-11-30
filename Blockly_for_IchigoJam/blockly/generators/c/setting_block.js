Blockly.C['foreground_setting'] = function(block) {
  var value_foreground = Blockly.C.valueToCode(block, 'foreground', Blockly.C.ORDER_ATOMIC);
  // TODO: Assemble C into code variable.
  var code = 'document.getElementById("header").style.color =  "' + value_foreground + '"\n';
  return code;
};
