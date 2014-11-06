// Production steps of ECMA-262, Edition 5, 15.4.4.14
// Reference: http://es5.github.io/#x15.4.4.14
if (!Array.prototype.indexOf) {
    Array.prototype.indexOf = function (searchElement, fromIndex) {
        var k;

        if (this == null) {
            throw new TypeError('"this" is null or not defined');
        }

        var o = Object(this);
        var len = o.length >>> 0;
        
        if (len === 0) {
            return -1;
        }
        
        var n = +fromIndex || 0;

        if (Math.abs(n) === Infinity) {
            n = 0;
        }

        if (n >= len) {
            return -1;
        }

        k = Math.max(n >= 0 ? n : len - Math.abs(n), 0);

        while (k < len) {
            if (k in o && o[k] === searchElement) {
                return k;
            }

            k++;
        }

        return -1;
    };
}

// PropertyValueControl
PropertyValueControl = function () {
    PropertyValueControl.initializeBase(this);

    this._comboBoxUnit_IndexChange_UnitException = null;
    this._comboBoxUnit_PrevUnitInException = null;
    this._radAjaxManagerClientId = null;
    this._btnUnitIndexChangedClientID = null;
    this._onClientBlurEventHandler = null;
    this._selectedControlClientId = null;
    this._selectedControlType = null;

    this._radTextBoxType = null;
    this._radNumericTextBoxType = null;
    this._yesNoRadioControlType = null;
    this._radDatePickerType = null;
    this._radComboBoxType = null;

    this._radTextBoxTextClientId = null;
    this._radNumericTextBoxClientId = null;
    this._yesNoRadioControlClientId = null;
    this._radDatePickerClientId = null;
    this._radComboBoxListClientId = null;

    this._attributeType = null;
    this._attributeTypeList = null;
    this._attributeTypeYesNo = null;
}

PropertyValueControl.prototype = {
    get_comboBoxUnit_IndexChange_UnitException: function () {
        return this._comboBoxUnit_IndexChange_UnitException;
    },

    set_comboBoxUnit_IndexChange_UnitException: function (value) {
        this._comboBoxUnit_IndexChange_UnitException = value;
    },

    get_comboBoxUnit_PrevUnitInException: function () {
        return this._comboBoxUnit_PrevUnitInException;
    },

    set_comboBoxUnit_PrevUnitInException: function (value) {
        this._comboBoxUnit_PrevUnitInException = value;
    },

    get_radAjaxManagerClientId: function () {
        return this._radAjaxManagerClientId;
    },

    set_radAjaxManagerClientId: function (value) {
        this._radAjaxManagerClientId = value;
    },

    get_btnUnitIndexChangedClientID: function () {
        return this._btnUnitIndexChangedClientID;
    },

    set_btnUnitIndexChangedClientID: function (value) {
        this._btnUnitIndexChangedClientID = value;
    },

    get_onClientBlurEventHandler: function () {
        return this._onClientBlurEventHandler;
    },

    set_onClientBlurEventHandler: function (value) {
        this._onClientBlurEventHandler = value;
    },

    get_selectedControlClientId: function () {
        return this._selectedControlClientId;
    },

    set_selectedControlClientId: function (value) {
        this._selectedControlClientId = value;
    },

    get_selectedControlType: function () {
        return this._selectedControlType;
    },

    set_selectedControlType: function (value) {
        this._selectedControlType = value;
    },

    get_radTextBoxType: function () {
        return this._radTextBoxType;
    },

    set_radTextBoxType: function (value) {
        this._radTextBoxType = value;
    },

    get_radNumericTextBoxType: function () {
        return this._radNumericTextBoxType;
    },

    set_radNumericTextBoxType: function (value) {
        this._radNumericTextBoxType = value;
    },

    get_yesNoRadioControlType: function () {
        return this._yesNoRadioControlType;
    },

    set_yesNoRadioControlType: function (value) {
        this._yesNoRadioControlType = value;
    },

    get_radDatePickerType: function () {
        return this._radDatePickerType;
    },

    set_radDatePickerType: function (value) {
        this._radDatePickerType = value;
    },

    get_radComboBoxType: function () {
        return this._radComboBoxType;
    },

    set_radComboBoxType: function (value) {
        this._radComboBoxType = value;
    },

    get_radTextBoxTextClientId: function () {
        return this._radTextBoxTextClientId;
    },

    set_radTextBoxTextClientId: function (value) {
        this._radTextBoxTextClientId = value;
    },

    get_radNumericTextBoxClientId: function () {
        return this._radNumericTextBoxClientId;
    },

    set_radNumericTextBoxClientId: function (value) {
        this._radNumericTextBoxClientId = value;
    },

    get_yesNoRadioControlClientId: function () {
        return this._yesNoRadioControlClientId;
    },

    set_yesNoRadioControlClientId: function (value) {
        this._yesNoRadioControlClientId = value;
    },

    get_radDatePickerClientId: function () {
        return this._radDatePickerClientId;
    },

    set_radDatePickerClientId: function (value) {
        this._radDatePickerClientId = value;
    },

    get_radComboBoxListClientId: function () {
        return this._radComboBoxListClientId;
    },

    set_radComboBoxListClientId: function (value) {
        this._radComboBoxListClientId = value;
    },

    get_attributeType: function () {
        return this._attributeType;
    },

    set_attributeType: function (value) {
        this._attributeType = value;
    },

    get_attributeTypeList: function () {
        return this._attributeTypeList;
    },

    set_attributeTypeList: function (value) {
        this._attributeTypeList = value;
    },

    get_attributeTypeYesNo: function () {
        return this._attributeTypeYesNo;
    },

    set_attributeTypeYesNo: function (value) {
        this._attributeTypeYesNo = value;
    },

    getStringValue: function () {
        if (this._attributeType == this._attributeTypeList) {
            var radComboBoxList = $find(this._radComboBoxListClientId);
            return radComboBoxList.get_text();
        } else {
            var radTextBoxText = $find(this._radTextBoxTextClientId);
            if (radTextBoxText) {
                return radTextBoxText.get_value();
            } else {
                return null;
            }
        }
    },

    getDoubleValue: function () {
        var radNumericTextBox = $find(this._radNumericTextBoxClientId);
        if (radNumericTextBox) {
            return radNumericTextBox.get_value();
        } else {
            return null;
        }
    },

    getIntegerValue: function () {
        if (this._attributeType == this._attributeTypeYesNo) {
            var yesNoRadioControl = $find(this._yesNoRadioControlClientId);
            return +yesNoRadioControl.getValue();
        } else {
            var radNumericTextBox = $find(this._radNumericTextBoxClientId);
            if (radNumericTextBox) {
                return parseInt(radNumericTextBox.get_value());
            } else {
                return null;
            }
        }
    },

    getDateTimeValue: function () {
        var radDatePicker = $find(this._radDatePickerClientId);
        if (radDatePicker) {
            var localDate = radDatePicker.get_selectedDate();
            var utcDate = new Date(Date.UTC(localDate.getFullYear(), localDate.getMonth(), localDate.getDate(), localDate.getHours(), localDate.getMinutes(), localDate.getSeconds()));
            return utcDate;
        } else {
            return null;
        }
    },

    comboBoxUnit_IndexChanging: function (e, a) {
        try {
            var value = e.get_itemData()[e.get_selectedIndex()].value;
            this._comboBoxUnit_PrevUnitInException = this._comboBoxUnit_IndexChange_UnitException.indexOf(value) > -1;
        } catch (e) {
            //console.log(e.message);
        } 
        
    },

    comboBoxUnit_IndexChanged: function (e, a) {
        var value = e.get_itemData()[e.get_selectedIndex()].value;
        if (this._comboBoxUnit_PrevUnitInException == true || this._comboBoxUnit_IndexChange_UnitException.indexOf(value) > -1) {
            var btn = window.$find(this._btnUnitIndexChangedClientID);
            btn.click();
        }
    },

    tryInvokeOnBlurEventHandler: function () {
        var onClientBlurEventHandler = this._onClientBlurEventHandler;
        if (onClientBlurEventHandler) {
            this.executeFunctionByName(onClientBlurEventHandler);
        }
    },

    executeFunctionByName: function (functionName) {
        var context = window;
        var args = [].slice.call(arguments).splice(2);
        var namespaces = functionName.split(".");
        var func = namespaces.pop();
        for (var i = 0; i < namespaces.length; i++) {
            context = context[namespaces[i]];
        }
        return context[func].apply(window, args);
    },

    setFocus: function () {
        switch (this._selectedControlType) {
            case this._radTextBoxType:
            case this._radNumericTextBoxType:
                var radTextBox = $find(this._selectedControlClientId);
                radTextBox.focus();
                break;

            case this._yesNoRadioControlType:
                var yesNoRadioControl = $find(this._selectedControlClientId);
                yesNoRadioControl.focus();
                break;

            case this._radDatePickerType:
                var radDatePicker = $find(this._selectedControlClientId);
                radDatePicker.get_dateInput().focus();
                break;

            case this._radComboBoxType:
                var radComboBox = $find(this._selectedControlClientId);
                var input = radComboBox.get_inputDomElement();
                input.focus();
                break;
        }
    }
}

PropertyValueControl.registerClass("PropertyValueControl", Sys.Component);
