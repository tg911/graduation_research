define([
  "blocklylib"
  ,"../msg"
  ,"../constants"
  ,"../context-menus"
  ,"../io"
  ,"../colors"
  ,"../block-utils"
],function(BlocklyLib, msg, constants, contextMenus, io, colors, blockUtils){

var blockDefs = BlocklyLib.Blocks;

//see Block Factory app to create blocks https://blockly-demo.appspot.com/static/demos/blockfactory/index.html
blockDefs['picaxe_custom_outputon'] = {
  init: function() {
    this.setHelpUrl("http://www.example.com/command-details");
    this.setColour("#ff6600");
    this.appendDummyInput()
        .appendField("custom turn output")//or use Javascript to populate
        .appendField(new BlocklyLib.FieldDropdown(io.makeOutputPinList()), "PIN")
        .appendField(new BlocklyLib.FieldDropdown([["on", "1"], ["off", "0"]]), "VALUE");
    this.setInputsInline(true);
    this.setPreviousStatement(true, "null");
    this.setNextStatement(true, "null");
    this.setTooltip('');
    this.customContextMenu = contextMenus.customContextMenu;
    blockUtils.newBlock(this);
  },
  outputPins: "PIN"
};

});
