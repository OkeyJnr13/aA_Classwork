/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, { enumerable: true, get: getter });
/******/ 		}
/******/ 	};
/******/
/******/ 	// define __esModule on exports
/******/ 	__webpack_require__.r = function(exports) {
/******/ 		if(typeof Symbol !== 'undefined' && Symbol.toStringTag) {
/******/ 			Object.defineProperty(exports, Symbol.toStringTag, { value: 'Module' });
/******/ 		}
/******/ 		Object.defineProperty(exports, '__esModule', { value: true });
/******/ 	};
/******/
/******/ 	// create a fake namespace object
/******/ 	// mode & 1: value is a module id, require it
/******/ 	// mode & 2: merge all properties of value into the ns
/******/ 	// mode & 4: return value when already ns object
/******/ 	// mode & 8|1: behave like require
/******/ 	__webpack_require__.t = function(value, mode) {
/******/ 		if(mode & 1) value = __webpack_require__(value);
/******/ 		if(mode & 8) return value;
/******/ 		if((mode & 4) && typeof value === 'object' && value && value.__esModule) return value;
/******/ 		var ns = Object.create(null);
/******/ 		__webpack_require__.r(ns);
/******/ 		Object.defineProperty(ns, 'default', { enumerable: true, value: value });
/******/ 		if(mode & 2 && typeof value != 'string') for(var key in value) __webpack_require__.d(ns, key, function(key) { return value[key]; }.bind(null, key));
/******/ 		return ns;
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";
/******/
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = "./frontend/twitter.js");
/******/ })
/************************************************************************/
/******/ ({

/***/ "./frontend/api_util.js":
/*!******************************!*\
  !*** ./frontend/api_util.js ***!
  \******************************/
/*! no static exports found */
/***/ (function(module, exports) {

// a POJO that holds all ajax requests
const APIUtil = {
  followUser: userId => {
    // this = followtoggle instance because of the bind
    return $.ajax({
      // users/:user_id/follow
      url: `/users/${userId}/follow`,
      method: "POST", // method defaults to GET
      dataType: "JSON"
    });
  },
  unfollowUser: userId => {
    return $.ajax({
      // users/:user_id/follow
      url: `/users/${userId}/follow`,
      method: "DELETE", // method defaults to GET
      dataType: "JSON"
    });
  }
}

module.exports = APIUtil;

/***/ }),

/***/ "./frontend/follow_toggle.js":
/*!***********************************!*\
  !*** ./frontend/follow_toggle.js ***!
  \***********************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

const APIUtil = __webpack_require__ (/*! ./api_util */ "./frontend/api_util.js");

class FollowToggle {
  constructor(el) {
    // el is the toggle button for following
    this.$el = $(el);
    // this.userId = this.$el.attr('data-user-id');
    this.userId = this.$el.data('user-id');
    // this.followState = this.$el.attr('data-initial-follow-state');
    this.followState = this.$el.data('initial-follow-state');
    this.render();
    this.handleClick();
  }

  render() {
    if (this.followState === "unfollowed"){
      this.$el.html("Follow!"); //can use either this or this.$el.text("Follow!")
    } else {
      this.$el.html("Unfollow!");
    }

    // if (this.followState === "unfollowing"){
    //   this.$el.html("Follow!"); //can use either this or this.$el.text("Follow!")
    // } else {
    //   this.$el.html("Unfollow!");
    // }
  }

  handleClick() {
    // create an event handler that handles the moment a user presses a follow button
    // add handler on follow toggle button
    this.$el.on("click", (event) => {
      event.preventDefault();
      if (this.followState === "unfollowed") {
        APIUtil.followUser(this.userId).then(this.toggleFollow.bind(this)).fail(this.failureCallback); 
        // this.$el.prop('disabled', true);
      } else {
        APIUtil.unfollowUser(this.userId).then(this.toggleFollow.bind(this)).fail(this.failureCallback);
        // this.$el.prop('disabled', true);
      }
    });
  }

  toggleFollow() {
    if (this.followState === "unfollowed") {
      this.followState = "followed";
    } else {
      this.followState = "unfollowed";
    }
    // this.$el.prop()
    this.render();
  }

  failureCallback() {
    alert("ajax request denied");
  }
}

// new FollowToggle(".followToggle"); // pass in selector
// DOM document.getByElementClass('.element')
// jQuery $('.element');

module.exports = FollowToggle;

/***/ }),

/***/ "./frontend/twitter.js":
/*!*****************************!*\
  !*** ./frontend/twitter.js ***!
  \*****************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

const FollowToggle = __webpack_require__ (/*! ./follow_toggle */ "./frontend/follow_toggle.js");

// run following code when document is ready
// $(callBack) this runs callback after document is loaded completely

$(() => {
  // Define callback within anonymous func
  let $followButton = $("button.follow-toggle");
  // console.log($followButton instanceof $);
  $followButton.each((index, el) => {
    // el is a DOM
    // console.log(el);
    // $followButton.eq(index)
    new FollowToggle(el); // works either way using el or this refer to the same element
    // new FollowToggle(this);
  });
});


/***/ })

/******/ });
//# sourceMappingURL=bundle.js.map