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