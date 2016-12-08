Blockly.IchigoJamBASIC['led'] = function(block) {
  var dropdown_led = block.getFieldValue('led');
  // TODO: Assemble JavaScript into code variable.
  var code = 'hello'
  console.log("hello IchigoJam")
  return [code,Blockly.IchigoJamBASIC.ORDER_ATOMIC];
};
