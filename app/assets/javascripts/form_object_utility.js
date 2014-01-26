/**
 * Created by davidwillis on 1/20/14.
 */
// Form Object Utility - for common functions
// Supports IE 4.0+ and NN 4.7+ browsers

function getInputObject(formName, objectName)
{
    var browserName = navigator.appName;
    if (browserName.indexOf("Microsoft") != -1 &&
        getInternetExplorerVersion() < 8.0)
    {
        return eval(formName+"."+objectName);
    }
    else
    {
        return eval("document.forms[formName]."+objectName);
    }
}

function getMultipleSelectListValues(formName, selectElementName)
{
    var browserName = navigator.appName;
    if (browserName.indexOf("Microsoft") != -1 &&
        getInternetExplorerVersion() < 8.0)
    {
        var selectObj = eval("document.forms['"+formName+"']."+selectElementName);
    }
    else
    {
        var selectObj = eval(formName+"."+selectElementName);
    }
    var selectedValues = "";
    for (i = 0; i < selectObj.length; i++)
    {
        var theOption = selectObj.options[i];
        if (theOption.selected)
        {
            selectedValues += theOption.value + ":";
        }
    }
    return selectedValues;
}

function getSelectListValue(formName, selectElementName) {
    var browserName = navigator.appName;
    if (browserName.indexOf("Microsoft") != -1 &&
        getInternetExplorerVersion() < 8.0)
    {
        var selectObj = eval(formName+"."+selectElementName);
        return selectObj.value;
    }
    else
    {
        var selectObj = eval("document.forms['"+formName+"']."+selectElementName);
        //return selectObj.options[selectObj.selectedIndex].value;
        return selectObj.value;
    }
}

function getSelectedItemText(selectId) {
    var x=document.getElementById(selectId);
    return x.options[x.selectedIndex].text;
}

function getRadioButtonValue(formName, radioButtonName) {
    var theElement = eval("document."+formName+"."+radioButtonName);
    numOfOptions = theElement.length;
    if(numOfOptions > 0) {
        for(i=0; i<numOfOptions; i++) {
            if(theElement[i].checked) return theElement[i].value;
        } // end-for
    } // end-if
}

function getDivObject(divID) {
    if(document.getElementById && document.getElementById(divID)) {
        return document.getElementById(divID).style;
    } else if (document.all && document.all(divID)) {
        return document.all(divID).style;
    } else if (document.layers && document.layers[divID]) {
        return document.layers[divID];
    } else {
        return false;
    }
}

function changeVisibility(objectId, visibility) {
    var styleObj = getDivObject(objectId);
    if (styleObj) {
        styleObj.visibility = visibility;
        return true;
    } else {
        return false;
    }
}

function resetSelectList(formName, selectElementName)
{
    var browserName = navigator.appName;
    if (browserName.indexOf("Microsoft") != -1 &&
        getInternetExplorerVersion() < 8.0)
    {
        var selectObj = eval(formName + "." + selectElementName);
        selectObj.selectedIndex = 0;
    }
    else
    {
        var selectObj = eval(formName+"."+selectElementName);
        selectObj.selectedIndex = 0;
    }
}

function invokeResultsPopup(formName) {
    window.open("", "MSI_Query_Results", "resizable=yes,status=yes,location=yes,menubar=yes,width=770,height=500,scrollbars=yes");
}

function openDirectionsWindow(queryJSP, selectId) {
    var queryValue = getSelectedItemText(selectId);
    window.open(queryJSP + "?QueryValue=" + queryValue,"Query_Directions","toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes,copyhistory=no,width=400,height=400");
}

function openDirectionsWindowDirect(queryJSP, queryName) {
    window.open(queryJSP + "?QueryValue=" + queryName,"Query_Directions","toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes,copyhistory=no,width=400,height=400");
}

function popupWindow(url, windowName, width, height) {
    window.open(url, windowName, "toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes,copyhistory=no,width=" + width + ",height=" + height);
}

function getInternetExplorerVersion()
    // Returns the version of Internet Explorer or a -1
    // (indicating the use of another browser).
{
    var rv = -1; // Return value assumes failure.
    if (navigator.appName == 'Microsoft Internet Explorer')
    {
        var ua = navigator.userAgent;
        var re = new RegExp("MSIE ([0-9]{1,}[\.0-9]{0,})");
        if (re.exec(ua) != null)
            rv = parseFloat( RegExp.$1 );
    }
    return rv;
}
