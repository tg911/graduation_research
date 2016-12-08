Blockly.JavaScript['variable'] = function(block) {
  var variable_var1 = Blockly.JavaScript.variableDB_.getName(block.getFieldValue('var1'), Blockly.Variables.NAME_TYPE);
  // TODO: Assemble JavaScript into code variable.
  var code = '...';
  // TODO: Change ORDER_NONE to the correct strength.
  return [code, Blockly.JavaScript.ORDER_NONE];
};