// YesNoRadioControl
YesNoRadioControl = function () {
    YesNoRadioControl.initializeBase(this);

    this._radButtonYesClientId = null;
    this._radButtonNoClientId = null;
    this._onClientBlurEventHandler = null;
}

YesNoRadioControl.prototype = {

    get_radButtonYesClientId: function () {
        return this._radButtonYesClientId;
    },

    set_radButtonYesClientId: function (value) {
        this._radButtonYesClientId = value;
    },

    get_radButtonNoClientId: function () {
        return this._radButtonNoClientId;
    },

    set_radButtonNoClientId: function (value) {
        this._radButtonNoClientId = value;
    },

    get_onClientBlurEventHandler: function () {
        return this._onClientBlurEventHandler;
    },

    set_onClientBlurEventHandler: function (value) {
        this._onClientBlurEventHandler = value;
    },

    timeoutId: null,

    initializeLogic: function () {
        var timeoutId = this.timeoutId;

        // Add events to 'Yes' button
        var radButton = window.$find(this._radButtonYesClientId);
        var radButtonWrapper = $(radButton.get_element()); //!
        var checkboxWrapper = radButtonWrapper.find(".rbToggleRadio, .rbToggleRadioChecked");

        checkboxWrapper.focus(function () {
            if (timeoutId) {
                clearTimeout(timeoutId);
            }
        });

        var tryInvokeOnBlurEventHandler = this.TryInvokeOnBlurEventHandler;
        var that = this;

        checkboxWrapper.blur(function () {
            timeoutId = setTimeout(function () {
                tryInvokeOnBlurEventHandler(that);
            }, 100);
        });

        // Add events to 'No' button
        radButton = window.$find(this._radButtonNoClientId);
        radButtonWrapper = $(radButton.get_element());
        checkboxWrapper = radButtonWrapper.find(".rbToggleRadio, .rbToggleRadioChecked");

        checkboxWrapper.focus(function () {
            if (timeoutId) {
                clearTimeout(timeoutId);
            }
        });

        checkboxWrapper.blur(function () {
            timeoutId = setTimeout(function () {
                tryInvokeOnBlurEventHandler(that);
            }, 100);
        });
    },

    TryInvokeOnBlurEventHandler: function (that) {
        var onClientBlurEventHandler = that._onClientBlurEventHandler;
        if (onClientBlurEventHandler) {
            that.executeFunctionByName(onClientBlurEventHandler);
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

    focus: function () {
        var radButton = window.$find(this._radButtonYesClientId);
        var radButtonWrapper = $(radButton.get_element());
        var checkboxWrapper = radButtonWrapper.find(".rbToggleRadio, .rbToggleRadioChecked");
        checkboxWrapper.focus();
    },

    getValue: function () {
        var radButtonYes = window.$find(this._radButtonYesClientId);
        return radButtonYes.get_checked();
    }
}

//try {
    YesNoRadioControl.registerClass("YesNoRadioControl", Sys.Component);
//} catch (e) {
//    console.log(e.message);
//} 
