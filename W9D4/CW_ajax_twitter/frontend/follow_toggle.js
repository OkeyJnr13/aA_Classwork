const APIUtil = require ('./api_util');

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