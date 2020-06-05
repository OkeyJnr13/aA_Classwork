const FollowToggle = require ('./follow_toggle');

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
