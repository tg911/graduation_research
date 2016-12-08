Blockly.JavaScript['for'] = function(block) {
  var value_vara = Blockly.JavaScript.valueToCode(block, 'varA', Blockly.JavaScript.ORDER_ATOMIC);
  var value_varb = Blockly.JavaScript.valueToCode(block, 'varB', Blockly.JavaScript.ORDER_ATOMIC);
  var value_varc = Blockly.JavaScript.valueToCode(block, 'varC', Blockly.JavaScript.ORDER_ATOMIC);
  var statements_execute = Blockly.JavaScript.statementToCode(block, 'execute');
  // TODO: Assemble JavaScript into code variable.
  var code = '...;\n';
  return code;
};