<cfcomponent mixin="controller" dependency="NestedErrorMessageOn">

	<cffunction name="init">
		<cfset this.version = "1.1.7">
		<cfreturn this>
	</cffunction>

	<cffunction name="hStartFormTag" returntype="string" hint="">
		<cfargument name="class" type="string" required="false" default="" hint="">
		<cfscript>
			arguments.class = ListAppend(arguments.class, "form-horizontal", " ");
		</cfscript>
		<cfreturn startFormTag(argumentCollection=arguments)>
	</cffunction>

	<cffunction name="hFileField" returntype="string" hint="">
		<cfscript>
			var loc = {
				formFieldArguments=$bootstrapFormFieldArguments(arguments)
			};
		</cfscript>
		<cfreturn fileField(argumentCollection=loc.formFieldArguments)>
	</cffunction>

	<cffunction name="hSelect" returntype="string" hint="">
		<cfscript>
			var loc = {
				formFieldArguments=$bootstrapFormFieldArguments(arguments)
			};
		</cfscript>
		<cfreturn select(argumentCollection=loc.formFieldArguments)>
	</cffunction>

	<cffunction name="hTextField" returntype="string" hint="">
		<cfscript>
			var loc = {
				formFieldArguments=$bootstrapFormFieldArguments(arguments)
			};
		</cfscript>
		<cfreturn textField(argumentCollection=loc.formFieldArguments)>
	</cffunction>

	<cffunction name="hTextArea" returntype="string" hint="">
		<cfscript>
			var loc = {
				formFieldArguments=$bootstrapFormFieldArguments(arguments)
			};
		</cfscript>
		<cfreturn textArea(argumentCollection=loc.formFieldArguments)>
	</cffunction>

	<cffunction name="hPasswordField" returntype="string" hint="">
		<cfscript>
			var loc = {
				formFieldArguments=$bootstrapFormFieldArguments(arguments)
			};
		</cfscript>
		<cfreturn passwordField(argumentCollection=loc.formFieldArguments)>
	</cffunction>

	<cffunction name="hUneditableTextField" returntype="string" hint="">
		<cfargument name="label" type="string" required="true" hint="">
		<cfargument name="value" type="string" required="true" hint="">
		<cfargument name="class" type="string" required="false" default="" hint="">
		<cfscript>
			var loc = {};
			
			loc.field = '<div class="control-group">';
			loc.field &= '<label class="control-label">#h(arguments.label)#</label>';
			loc.field &= '<div class="controls"><span class="uneditable-input #h(arguments.class)#">#arguments.value#</span></div>';
			loc.field &= '</div>';
		</cfscript>
		<cfreturn loc.field>
	</cffunction>

	<cffunction name="bSubmitTag" returntype="string" hint="">
		<cfargument name="class" type="string" required="false" default="" hint="">
		<cfargument name="isPrimary" type="boolean" required="false" default="false" hint="">
		<cfscript>
			var loc = {
				coreSubmitTag=core.submitTag,
				class=ListAppend(arguments.class, "btn", " "),
				isPrimary=arguments.isPrimary
			};

			StructDelete(arguments, "isPrimary");
			StructDelete(arguments, "class");

			if (loc.isPrimary)
				loc.class = ListAppend(loc.class, "btn-primary", " ");

			loc.submitTag = loc.coreSubmitTag(argumentCollection=arguments);
			loc.submitTag = ReplaceNoCase(loc.submitTag, '<input', '<input class="#loc.class#"');
		</cfscript>
		<cfreturn loc.submitTag>
	</cffunction>

	<cffunction name="bFlashMessages" returntype="string" hint="">
		<cfscript>
			var loc = {
				flash=flash(),
				flashKeyList=StructKeyList(flash()),
				flashMessages=""
			};

			if (flashCount())
			{
				for (loc.i = 1; loc.i <= flashCount(); loc.i++)
				{
					loc.flashKey = ListGetAt(loc.flashKeyList, loc.i);

					loc.flashMessages &=
						'<div class="alert alert-#LCase(loc.flashKey)# fade in">
							<a class="close" data-dismiss="alert" href="##" title="Dismiss">&times;</a>
							#h(flash(loc.flashKey))#
						</div>';
				}
			}
		</cfscript>
		<cfreturn loc.flashMessages>
	</cffunction>

	<cffunction name="$bootstrapFormFieldArguments" returntype="struct" hint="Factors out common elements that need to be set to get form fields to be Bootstrap-friendly.">
		<cfargument name="fieldArguments" type="struct" required="true" hint="`arguments` scope passed to form helper.">
		<cfscript>
			var loc = {};

			if (!StructKeyExists(arguments.fieldArguments, "labelClass"))
				arguments.fieldArguments.labelClass = "";

			arguments.fieldArguments.labelClass = ListAppend(arguments.fieldArguments.labelClass, "control-label", " ");
			arguments.fieldArguments.prepend = '<div class="controls">';
			arguments.fieldArguments.append = '</div></div>';
			arguments.fieldArguments.errorElement = "";
			arguments.fieldArguments.errorClass = "";

			// Arguments needed for `errorMessageOn`
			loc.errorMessageOnArgs = {
				objectName=arguments.fieldArguments.objectName,
				property=arguments.fieldArguments.property
			};
			if (StructKeyExists(arguments.fieldArguments, "association"))
				loc.errorMessageOnArgs.association = arguments.fieldArguments.association;
			if (StructKeyExists(arguments.fieldArguments, "position"))
				loc.errorMessageOnArgs.position = arguments.fieldArguments.position;

			// Help block
			if (StructKeyExists(arguments.fieldArguments, "helpBlock") && Len(arguments.fieldArguments.helpBlock))
				arguments.fieldArguments.append = '<p class="help-block">#arguments.fieldArguments.helpBlock#</p>'
					& arguments.fieldArguments.append;

			// Error message
			if (Evaluate($objectName(argumentCollection=arguments.fieldArguments)).hasErrors(arguments.fieldArguments.property))
			{
				arguments.fieldArguments.prependToLabel = '<div class="control-group error">';
				arguments.fieldArguments.append =
					' #errorMessageOn(argumentCollection=loc.errorMessageOnArgs)#'
					& arguments.fieldArguments.append;
			}
		</cfscript>
		<cfreturn arguments.fieldArguments>
	</cffunction>

</cfcomponent>