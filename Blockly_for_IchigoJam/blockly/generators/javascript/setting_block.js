Blockly.JavaScript['foreground_setting'] = function(block) {
  var value_foreground = Blockly.JavaScript.valueToCode(block, 'foreground', Blockly.JavaScript.ORDER_ATOMIC);
  // TODO: Assemble JavaScript into code variable.
  var code = 'document.getElementById("header").style.color =  "' + value_foreground + '"\n';
  return code;
};
