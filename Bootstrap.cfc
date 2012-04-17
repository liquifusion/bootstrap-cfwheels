<cfcomponent mixin="controller" dependency="NestedErrorMessageOn">

	<!---
		8888888b.           888      888 d8b          
		888   Y88b          888      888 Y8P          
		888    888          888      888              
		888   d88P 888  888 88888b.  888 888  .d8888b 
		8888888P"  888  888 888 "88b 888 888 d88P"    
		888        888  888 888  888 888 888 888      
		888        Y88b 888 888 d88P 888 888 Y88b.    
		888         "Y88888 88888P"  888 888  "Y8888P 
	
	Public --->

	<cffunction name="init">
		<cfset this.version = "1.1.7">
		<cfreturn this>
	</cffunction>

	<!---
		8888888888                                              88888888888                
		888                                                         888                    
		888                                                         888                    
		8888888  .d88b.  888d888 88888b.d88b.                       888   8888b.   .d88b.  
		888     d88""88b 888P"   888 "888 "88b                      888      "88b d88P"88b 
		888     888  888 888     888  888  888      888888          888  .d888888 888  888 
		888     Y88..88P 888     888  888  888                      888  888  888 Y88b 888 
		888      "Y88P"  888     888  888  888                      888  "Y888888  "Y88888 
		                                                                               888 
		                                                                          Y8b d88P 
		                                                                           "Y88P"  
	Form - tag helpers --->

	<cffunction name="bSelectTag" returntype="string" hint="Bootstrap markup version of the standard Wheels `selectTag` form helper.">
		<cfscript>
			var loc = {
				formFieldArgs=$bootstrapFormFieldArgs(arguments)
			};
		</cfscript>
		<cfreturn selectTag(argumentCollection=loc.formFieldArgs)>
	</cffunction>

	<cffunction name="bSubmitTag" returntype="string" hint="Bootstrap markup version of the standard Wheels `submitTag` form helper.">
		<cfargument name="class" type="string" required="false" default="" hint="Space-delimited list of classes to apply to the submit button.">
		<cfargument name="isPrimary" type="boolean" required="false" default="false" hint="Whether or not to apply the `btn-primary` style to the button.">
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

	<cffunction name="bTextFieldTag" returntype="string" hint="Bootstrap markup version of the standard Wheels `textFieldTag` form helper.">
		<cfscript>
			var loc = {
				formFieldArgs=$bootstrapFormFieldArgs(arguments)
			};
		</cfscript>
		<cfreturn textFieldTag(argumentCollection=arguments)>
	</cffunction>

	<cffunction name="hStartFormTag" returntype="string" hint="Bootstrap markup version of the Wheels `startFormTag` form helper, except with the `form-horizontal` class applied for you.">
		<cfargument name="class" type="string" required="false" default="" hint="Space-delimited list of classes to apply to the form tag.">
		<cfscript>
			arguments.class = ListAppend(arguments.class, "form-horizontal", " ");
		</cfscript>
		<cfreturn startFormTag(argumentCollection=arguments)>
	</cffunction>

	<!---
		8888888888                                               .d88888b.  888       d8b                   888    
		888                                                     d88P" "Y88b 888       Y8P                   888    
		888                                                     888     888 888                             888    
		8888888  .d88b.  888d888 88888b.d88b.                   888     888 88888b.  8888  .d88b.   .d8888b 888888 
		888     d88""88b 888P"   888 "888 "88b                  888     888 888 "88b "888 d8P  Y8b d88P"    888    
		888     888  888 888     888  888  888      888888      888     888 888  888  888 88888888 888      888    
		888     Y88..88P 888     888  888  888                  Y88b. .d88P 888 d88P  888 Y8b.     Y88b.    Y88b.  
		888      "Y88P"  888     888  888  888                   "Y88888P"  88888P"   888  "Y8888   "Y8888P  "Y888 
		                                                                              888                          
		                                                                             d88P                          
		                                                                           888P"                           
	Form - object helpers --->

	<cffunction name="bCheckBox" returntype="string" hint="Bootstrap markup version of the Wheels `checkBox` form helper.">
		<cfscript>
			var loc = {};

			loc.field = checkBox(
				argumentCollection=arguments,
				labelPlacement="around",
				labelClass="checkbox"
			);

			loc.hasErrors = Evaluate($objectName(argumentCollection=arguments)).hasErrors(arguments.property);

			loc.field =
				'<div class="control-group #loc.hasErrors ? 'error': ''#">
					<label class="control-label"></label>
					<div class="controls">
						#loc.field#
					</div>
				</div>';
		</cfscript>
		<cfreturn loc.field>
	</cffunction>

	<cffunction name="bFileField" returntype="string" hint="Bootstrap markup version of the Wheels `fileField` form helper.">
		<cfscript>
			var loc = {
				formFieldArgs=$boostrapObjectFormFieldArgs(arguments)
			};
		</cfscript>
		<cfreturn fileField(argumentCollection=loc.formFieldArgs)>
	</cffunction>

	<cffunction name="bPasswordField" returntype="string" hint="Bootstrap markup version of the Wheels `passwordField` form helper.">
		<cfscript>
			var loc = {
				formFieldArgs=$boostrapObjectFormFieldArgs(arguments)
			};
		</cfscript>
		<cfreturn passwordField(argumentCollection=loc.formFieldArgs)>
	</cffunction>

	<cffunction name="bSelect" returntype="string" hint="Bootstrap markup version of the Wheels `select` form helper.">
		<cfscript>
			var loc = {
				formFieldArgs=$boostrapObjectFormFieldArgs(arguments)
			};
		</cfscript>
		<cfreturn select(argumentCollection=loc.formFieldArgs)>
	</cffunction>

	<cffunction name="bTextArea" returntype="string" hint="Boostrap markup version of the Wheels `textArea` form helper.">
		<cfscript>
			var loc = {
				formFieldArgs=$boostrapObjectFormFieldArgs(arguments)
			};
		</cfscript>
		<cfreturn textArea(argumentCollection=loc.formFieldArgs)>
	</cffunction>

	<cffunction name="bTextField" returntype="string" hint="Bootstrap markup version of the Wheels `textField` form helper.">
		<cfscript>
			var loc = {
				formFieldArgs=$boostrapObjectFormFieldArgs(arguments)
			};
		</cfscript>
		<cfreturn textField(argumentCollection=loc.formFieldArgs)>
	</cffunction>

	<cffunction name="bUneditableTextField" returntype="string" hint="Bootstrap helper for showing an uneditable text field.">
		<cfargument name="label" type="string" required="true" hint="Field label.">
		<cfargument name="value" type="string" required="true" hint="Value to display in box.">
		<cfargument name="class" type="string" required="false" default="" hint="Classes to apply to the box.">
		<cfscript>
			var loc = {};
			
			loc.field = '<div class="control-group">';
			loc.field &= '<label class="control-label">#h(arguments.label)#</label>';
			loc.field &= '<div class="controls"><span class="uneditable-input #h(arguments.class)#">#arguments.value#</span></div>';
			loc.field &= '</div>';
		</cfscript>
		<cfreturn loc.field>
	</cffunction>

	<!---
		888                                          888    
		888                                          888    
		888                                          888    
		888       8888b.  888  888  .d88b.  888  888 888888 
		888          "88b 888  888 d88""88b 888  888 888    
		888      .d888888 888  888 888  888 888  888 888    
		888      888  888 Y88b 888 Y88..88P Y88b 888 Y88b.  
		88888888 "Y888888  "Y88888  "Y88P"   "Y88888  "Y888 
		                       888                          
		                  Y8b d88P                          
		                   "Y88P"                           
	Layout helpers --->

	<cffunction name="bFlashMessages" returntype="string" hint="Bootstrap markup version of the Wheels `flashMessages` view helper.">
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

	<!---
		888b     d888 d8b                   
		8888b   d8888 Y8P                   
		88888b.d88888                       
		888Y88888P888 888 .d8888b   .d8888b 
		888 Y888P 888 888 88K      d88P"    
		888  Y8P  888 888 "Y8888b. 888      
		888   "   888 888      X88 Y88b.    
		888       888 888  88888P'  "Y8888P 

	Miscellaneous helpers --->

	<cffunction name="bPaginationLinks" returntype="string" hint="Bootstrap markup version of the Wheels `paginationLinks` view helper.">
		<cfscript>
			var loc = {};

			loc.paginationArgs = Duplicate(arguments);

			loc.paginationArgs.prepend = '<div class="pagination"><ul>';
			loc.paginationArgs.append = '</ul></div>';
			loc.paginationArgs.prependToPage = '<li>';
			loc.paginationArgs.appendToPage = '</li>'; 
			loc.paginationArgs.classForCurrent = "active";
			loc.paginationArgs.linkToCurrentPage = false;
			loc.paginationArgs.anchorDivider = "";
			loc.paginationArgs.linkToCurrentPage = true;

			loc.paginationLinks = paginationLinks(argumentCollection=loc.paginationArgs);
			loc.paginationLinks = Replace(loc.paginationLinks, '<li><a class="active"', '<li class="active"><a', "all");
		</cfscript>
		<cfreturn loc.paginationLinks>
	</cffunction>

	<!---
		8888888b.          d8b                   888            
		888   Y88b         Y8P                   888            
		888    888                               888            
		888   d88P 888d888 888 888  888  8888b.  888888 .d88b.  
		8888888P"  888P"   888 888  888     "88b 888   d8P  Y8b 
		888        888     888 Y88  88P .d888888 888   88888888 
		888        888     888  Y8bd8P  888  888 Y88b. Y8b.     
		888        888     888   Y88P   "Y888888  "Y888 "Y8888  

	Private --->

	<cffunction name="$bootstrapFormFieldArgs" returntype="struct" hint="Factors out common elements that need to be set to get form fields to be Bootstrap-friendly.">
		<cfargument name="fieldArgs" type="struct" required="true" hint="`arguments` scope passed to form helper.">
		<cfscript>
			var loc = {};

			if (!StructKeyExists(arguments.fieldArgs, "labelClass"))
				arguments.fieldArgs.labelClass = "";

			arguments.fieldArgs.labelPlacement = "before";
			arguments.fieldArgs.labelClass = ListAppend(arguments.fieldArgs.labelClass, "control-label", " ");
			arguments.fieldArgs.prepend = '<div class="controls">';
			arguments.fieldArgs.prependToLabel = '<div class="control-group">';
			arguments.fieldArgs.append = '</div></div>';
			arguments.fieldArgs.errorElement = "";
			arguments.fieldArgs.errorClass = "";

			// Prepend/appended text
			loc.hasPrependedText = StructKeyExists(arguments.fieldArgs, "prependedText") && Len(arguments.fieldArgs.prependedText);
			loc.hasAppendedText = StructKeyExists(arguments.fieldArgs, "appendedText") && Len(arguments.fieldArgs.appendedText);

			if (loc.hasPrependedText || loc.hasAppendedText)
			{
				loc.prependClass = loc.hasPrependedText ? 'input-prepend' : '';
				loc.appendClass = loc.hasAppendedText ? 'input-append' : '';
				arguments.fieldArgs.prepend &= '<div class="#loc.prependClass# #loc.appendClass#">';
				arguments.fieldArgs.append = '</div>' & arguments.fieldArgs.append;

				if (loc.hasPrependedText)
					arguments.fieldArgs.prepend &= '<span class="add-on">#arguments.fieldArgs.prependedText#</span>';

				if (loc.hasAppendedText)
					arguments.fieldArgs.append =
						'<span class="add-on">#arguments.fieldArgs.appendedText#</span>'
						& arguments.fieldArgs.append;
			}

			// Help block
			if (StructKeyExists(arguments.fieldArgs, "helpBlock") && Len(arguments.fieldArgs.helpBlock))
				arguments.fieldArgs.append = '<p class="help-block">#arguments.fieldArgs.helpBlock#</p>'
					& arguments.fieldArgs.append;

			// Remove arguments that will cause extra HTML attributes to be added
			StructDelete(arguments.fieldArgs, "helpBlock");
			StructDelete(arguments.fieldArgs, "prependedText");
			StructDelete(arguments.fieldArgs, "appendedText");
		</cfscript>
		<cfreturn arguments.fieldArgs>
	</cffunction>

	<cffunction name="$boostrapObjectFormFieldArgs" returntype="struct" hint="Factors out common elements that needs to be set to get object-based form fields to be Bootstrap-friendly.">
		<cfargument name="fieldArgs" type="struct" required="true" hint="`arguments` scope passed to form helper.">
		<cfscript>
			var loc = {};

			// Get basic settings from general form field helper
			arguments.fieldArgs = $bootstrapFormFieldArgs(arguments.fieldArgs);

			// Arguments needed for `errorMessageOn`
			loc.errorMessageOnArgs = {
				objectName=arguments.fieldArgs.objectName,
				property=arguments.fieldArgs.property,
				wrapperElement="span",
				class="help-inline"
			};
			if (StructKeyExists(arguments.fieldArgs, "association"))
				loc.errorMessageOnArgs.association = arguments.fieldArgs.association;
			if (StructKeyExists(arguments.fieldArgs, "position"))
				loc.errorMessageOnArgs.position = arguments.fieldArgs.position;

			// Error message
			if (Evaluate($objectName(argumentCollection=arguments.fieldArgs)).hasErrors(arguments.fieldArgs.property))
			{
				arguments.fieldArgs.prependToLabel = Replace(
					arguments.fieldArgs.prependToLabel,
					'<div class="control-group">',
					'<div class="control-group error">'
				);

				arguments.fieldArgs.append =
					' #errorMessageOn(argumentCollection=loc.errorMessageOnArgs)#'
					& arguments.fieldArgs.append;
			}
		</cfscript>
		<cfreturn arguments.fieldArgs>
	</cffunction>

</cfcomponent>