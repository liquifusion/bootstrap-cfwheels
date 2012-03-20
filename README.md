# Bootstrap CFWheels Plugin

Experimental plugin that adds an API for working with [Twitter Bootstrap][1].

## Setup

To get started with the limited number of methods made available (adding more as I work), add these configurations to
`config/settings.cfm`. These settings will more than likely move into the form helpers themselves because Bootstrap is
pretty darn opinionated on how the markup should work anyway.

	// Forms
	set(
		functionName="textField,passwordField,fileField,textArea,select,dateSelect,timeSelect,dateTimeSelect",
		prependToLabel='<div class="control-group">',
		append='</div>',
		labelPlacement="before",
		errorElement="div"
	);
	set(functionName="select", includeBlank="-- Select one --", errorElement="div");
	set(functionName="textArea", rows=5, cols=30);
	set(functionName="radioButton,checkBox,hasManyCheckBox", labelClass="checkbox", labelPlacement="around", errorElement="div");

## Methods

This is a list of methods available. So far, I've mainly been focusing on "horizontal" forms.

All methods have their "usual" arguments from the Wheels API, but additional arguments are listed below along with the
method names.

### Object Form Helpers

  * `hStartFormTag()`
  * `hFileField([ string helpBlock ])`
  * `hSelect([ string helpBlock ])`
  * `hTextField([ string helpBlock ])`
  * `hTextArea([ string helpBlock ])`
  * `hPasswordField([ string helpBlock ])`
  * `hUneditableTextField(string label, string value [, string class ])`

These form helpers also place error messages in-line using `errorMessageOn` and Bootstrap.

### Other Form Helpers

  * `bSubmitTag([ string class, boolean isPrimary ])`

### View Helpers

  * `bFlashMessages()`

## Dependencies

You must install the [Nested errorMessageOn][2] plugin for this plugin to work.

## Contributors

Created by [Chris Peters][4] with support from [Liquifusion Studios][2].

[1]: http://twitter.github.com/bootstrap/
[2]: https://github.com/liquifusion/cfwheels-nested-errorMessageOn
[3]: http://cfwheels.org/user/profile/1
[4]: http://liquifusion.com/