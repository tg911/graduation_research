Blockly.JavaScript['input'] = function(block) {
  var variable_var1 = Blockly.JavaScript.variableDB_.getName(block.getFieldValue('var1'), Blockly.Variables.NAME_TYPE);
  var value_name = Blockly.JavaScript.valueToCode(block, 'NAME', Blockly.JavaScript.ORDER_ATOMIC);
  // TODO: Assemble JavaScript into code variable.
  var code = '...;\n';
  return code;
};