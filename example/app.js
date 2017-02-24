// This is a test harness for your module
// You should do something interesting in this harness
// to test out the module and to provide instructions
// to users on how to use it by example.


// open a single window
var win = Ti.UI.createWindow({
	backgroundColor:'white'
});
win.open();

// TODO: write your module tests here
var Material = require('ti.material');

Ti.API.info("module is => " + Material);

var content = Ti.UI.createView({
	width: Ti.UI.FILL,
	height: Ti.UI.FILL,
	layout: "vertical"
});


function addButton() {
	var ob = Material.createButton({
		width: 65,
		height: 65,
		backgroundColor: "#AA34CF", 
		touchFeedbackColor: "orange", 
		title: "Add",
		color: "white",
		style: 3,
		font: {
			fontSize: 12,
			fontWeight: "bold"
		},
		top: 50
	});

	ob.addEventListener("click", function(e) {
		Ti.API.debug("Material button, clicked: ", e);
	});

	ob.addEventListener("rotationCompleted", function(e) {
		Ti.API.debug("Material button, clicked: ", e);
	});

	content.add(ob);

}

function addTextField() {
	var ob = Material.createTextField({
		width: 200, 
		height: 80,
		
		backgroundColor: "grey",
		color: "black",
		hintColor: "black",
		errorColor: "red",
		
		label: "Team Mobile",
		data: ["ani", "andrea", "flavio"],
		hint: "This is da hint",

		fullWidth: false,
		enabled: true,
		floatingLabel: true,
		
		//style: 0,
		textFont: {
			fontSize: 12
		},
		labelFont: {
			fontSize: 11
		},
		maxCharacterCount: 10,
		bottom: 15,
		top: 15
	});

	ob.addEventListener("change", function(e) {
		Ti.API.debug(e);
	});

	content.add(ob);
}



function addProgress() {
	var progress = Material.createProgressBar({
		height: 50,
		width: 50,
		value: 0.4,
		tintColor: "orange",
		trackTintColor: "#AA34CF",
		progressType: 1,
		progressStyle: 1,
		top: 15,
		bottom: 15
	});

	content.add(progress);
}

function addSwitch() {
	var switch_c = Material.createSwitch({
		top: 0,
		height: 100,
		width: 50,
		trackOnColor: "#C93D64",
		trackOffColor: "orange",
		thumbOnColor: "orange",
		thumbOffColor: "#C93D64"
	});

	switch_c.addEventListener("change", function(e) {
		Ti.API.debug(e);
	});

	content.add(switch_c);
}

addButton();
addTextField();
addProgress();
addSwitch();

win.add(content);
