# Bootstrap CFWheels Plugin

Experimental plugin that adds an API for working with Twitter Bootstrap.

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

### Object Form Helpers

These form helpers also place error messages in-line using `errorMessageOn`.

  * `hStartFormTag`
  * `hFileField`
  * `hSelect`
  * `hTextField`
  * `hTextArea`
  * `hPasswordField`
  * `hUneditableTextField`

### Other Form Helpers

  * `bSubmitTag`

### View Helpers

  * `bFlashMessages`

## Dependencies

You must install the [Nested errorMessageOn][1] plugin for this plugin to work.

[1]: https://github.com/liquifusion/cfwheels-nested-errorMessageOn