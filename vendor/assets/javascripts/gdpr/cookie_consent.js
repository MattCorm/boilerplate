/* global Cookies, gtag */
//= require js.cookie
window.cookieConsent = {

    init: function () {
        'use strict';
        this.cookieBanner = document.querySelector('.js-gdpr__cookie_consent');
        this.cookieConsentOkButton = document.querySelector('.js-gdpr__cookie_consent__buttons__ok');
        this.cookieConsentKoButton = document.querySelector('.js-gdpr__cookie_consent__buttons__ko');
        this.displayAgain = document.querySelector('.js-gdpr__cookie_consent__display_again');
        this.bindActions();
        this.manageBannerDisplay();
    },

    bindActions: function () {
        'use strict';
        var that = this;
        if (this.cookieConsentOkButton) {
            this.cookieConsentOkButton.addEventListener('click', function () {
                that.setCookieAcceptance(true);
            });
        }
        if (this.cookieConsentKoButton) {
            this.cookieConsentKoButton.addEventListener('click', function () {
                that.setCookieAcceptance(false);
            });
        }
        if (this.displayAgain) {
            this.displayAgain.addEventListener('click', function (e) {
                e.preventDefault();
                e.stopPropagation();
                that.displayBanner(true);
            });
        }
    },

    manageBannerDisplay: function () {
        'use strict';
        var value;
        value = Cookies.get('gdpr.cookie_consent.ok');
        console.log(value);
        if (value == undefined) {
            this.displayBanner(true);
        }
    },

    displayBanner: function (display) {
        'use strict';
        if (display) {
            this.cookieBanner.style.display = 'block';
        } else {
            this.cookieBanner.style.display = 'none';
        }
    },

    setCookieAcceptance: function (value) {
        'use strict';
        Cookies.set('gdpr.cookie_consent.ok', value, { path: '/', expires: 365 });
        this.displayBanner(false);
        if (value) {
            if (window.gtag !== undefined) {
                gtag('consent', 'update', {
                    'ad_storage': 'granted',
                    'analytics_storage': 'granted'
                });
            }
        }
    },

    invoke: function () {
        'use strict';
        return {
            init: this.init.bind(this)
        };
    }
}.invoke();

document.addEventListener('DOMContentLoaded', function () {
    'use strict';
    window.cookieConsent.init();
});
