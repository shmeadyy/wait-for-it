$(document).ready(function(){
  $("#guest-content").on("click", "div.cancel-button", Status.confirm)
  $("#guest-content").on("click", "div.confirm-button", Status.cancel)
})

var Status = {
  cancel: function() {
    var restaurant_id = $("#guest-content").data("restaurant-id")
    var id = $("#guest-content").data("id")
    $.ajax({
      url: "/restaurants/"+restaurant_id+"/reservations/"+id,
      type: "put",
      dataType: "json",
      data: { restaurant_id: restaurant_id, id: id, reservation: { status: "Cancelled" } }
    }).done(function(){
      $(".confirmation-message").removeClass("hidden")
      $("div.confirm-button").addClass("hidden")
      $("span.ha").html(" don't")
    }).fail(function(){
      $button = $("div.confirm-button")
      $button.removeClass("confirm-button").addClass("cancel-button")
      $button.find("span").html("cancel")
      $(".confirmation-message").removeClass("hidden")
      $(".confirmation-message").html("Please try again.")
    })
  },

  confirm: function() {
    var $cancelButton = $(this)
    $cancelButton.removeClass("cancel-button")
    $cancelButton.addClass("confirm-button")
    $cancelButton.find("span").html("confirm")
  }
}