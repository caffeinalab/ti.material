<!-- <img src="logo.jpg" /> -->

#### Module to port [Google Material Design](http://www.google.com/design/spec/material-design/introduction.html) to Titanium, specifically iOS!
Thanks to [FPT Software](http://www.fpt-software.com/) for developing a great [library](https://github.com/fpt-software/Material-Controls-For-iOS) that made this possible.

UI elements supported by the native library vs. ti.material

UI | Original | ti.material
--- | ---| --- | ----
MDButton | [x] | [x]
MDTableViewCell | [x] | []
MDProgress | [x] | [x]
MDSlider | [x] | []
MDSwitch | [x] | [x]
MDTabBar | [x] | []
MDTabBarViewController | [x] | []
MDTextField | [x] | [x]
MDSnackbar | [x] | []
MDToast | [x] | [x]
MDDatePicker | [x] | [x]
MDTimePicker | [x] | [x]

<image src="https://www.dropbox.com/s/ehfrjdybp0tzqak/Simulator%20Screen%20Shot%2024%20Feb%202017%2C%2012.23.02%20PM.png?dl=0">

<image src="https://www.dropbox.com/s/tppq3n6h041aoeo/Simulator%20Screen%20Shot%2024%20Feb%202017%2C%2012.28.00%20PM.png?dl=0">

## Install the module

Unzip the latest release in your module directory and add to tiapp modules, or just type:

```

```

Initialize it as below

```
var Material = require("ti.material");
```

## MDButton

Creating a button is very straightforward. 

```
var button = Material.createButton({});
```

The button accepts the following list of properties:

### Properties

Property | Type | Default | Description
--- | --- | --- | ----
title | String | App Title | The title to show in the notification center.
color | String | n/a | The color of the button title
touchFeedbackColor | String | n/a | The color of the ripple effect of the button
backgroundColor | String | n/a | The color of the button background
style | int | 0 | The style of the button going from 0 to 3. The last two being FAB
font | font object | system font | The font of the button title
enabled | Bool | true | Determines whether the element is enabled or not
opacity | float | 1.0 | Opacity of the element
rotated | Bool | false | Sets the rotation status of the FAB (style 3) button
imageNormal | String | null | The image instead of the title for a FAB button in the not rotated state
imageRotated | String | null | Same as above but for the rotated state of the button

### Events

Inherited from titanium:

- touchstart
- touchend
- touchmove
- touchcancel
- click
- dblclick

new:

- rotationstarted
- rotationcompleted

## LICENSE

MIT.

