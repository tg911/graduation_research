chrome.app.runtime.onLaunched.addListener(function() {
  chrome.app.window.create('app/index.html', {
    'bounds': {
      'width': 1024,
      'height': 768
    },
    id: "blockly-picaxe", // Even an empty string is sufficient.
    singleton: true
  });
});

function setStorage(data, callback){
  chrome.storage.local.set(data, callback);
}

function getStorage(keys, callback) {
  chrome.storage.local.get(keys, callback);
}
