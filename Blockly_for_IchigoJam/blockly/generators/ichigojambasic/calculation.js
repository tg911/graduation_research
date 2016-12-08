Blockly.JavaScript['calculation'] = function(block) {
  var value_vara = Blockly.JavaScript.valueToCode(block, 'varA', Blockly.JavaScript.ORDER_ATOMIC);
  var dropdown_calculation = block.getFieldValue('calculation');
  var value_varb = Blockly.JavaScript.valueToCode(block, 'varB', Blockly.JavaScript.ORDER_ATOMIC);
  // TODO: Assemble JavaScript into code variable.
  var code = '...';
  // TODO: Change ORDER_NONE to the correct strength.
  return [code, Blockly.JavaScript.ORDER_NONE];
};