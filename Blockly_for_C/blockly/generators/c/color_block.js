Blockly.C['color'] = function(block) {
  var colour_color = block.getFieldValue('color');
  // TODO: Assemble C into code variable.
  var code = '' + colour_color;
  // TODO: Change ORDER_NONE to the correct strength.
  return [code, Blockly.C.ORDER_ATOMIC];
};
