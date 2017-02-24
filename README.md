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
rippleColor | String | n/a | The color of the ripple effect of the button
backgroundColor | String | n/a | The color of the button background
style | int | 0 | The style of the button going from 0 to 3. The last two being FAB


## LICENSE

MIT.

