Blockly.JavaScript['if'] = function(block) {
  var value_condition = Blockly.JavaScript.valueToCode(block, 'condition', Blockly.JavaScript.ORDER_ATOMIC);
  var statements_execute = Blockly.JavaScript.statementToCode(block, 'execute');
  // TODO: Assemble JavaScript into code variable.
  var code = '...;\n';
  return code;
};