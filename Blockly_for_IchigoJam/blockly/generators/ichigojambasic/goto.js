Blockly.IchigoJamBASIC['goto'] = function(block) {
  var value_num = Blockly.IchigoJamBASIC.valueToCode(block, 'num', Blockly.IchigoJamBASIC.ORDER_ATOMIC);
  // TODO: Assemble IchigoJamBASIC into code variable.

  // 括弧を取り除く
  value_num = value_num.substr(1);
  value_num = value_num.substr(0,value_num.length-1);

  var code = "GOTO " + value_num + "\n";
  return code;
};
