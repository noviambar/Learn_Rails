// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";
import "@fortawesome/fontawesome-free"; // => https://ga.jspm.io/npm:@fortawesome/fontawesome-free@6.1.1/js/all.js
//= require jquery
//= require jquery_ujs
//= require_tree .
//= require_self
//= require turbolinks

$(document).ready(function () {
  // alert("tes");
});

$(document).on("turbolinks:load", function () {
  function add_fields(link, association, content) {
    var new_id = new Date().getTime();
    var regexp = new RegExp("new_" + association, "g");
    $(link).parent().append(content.replace(regexp, new_id));
  }

  function remove_fields(link, association, content) {
    $(link).prev("input[type=hidden]").val();
    $(link).closest("fieldset").hide();
    return event.preventDefault();
  }

  // $("form").on("click", ".remove_record", function (event) {
  //   $(this).prev("input[type=hidden]").val();
  //   $(this).closest("fieldset").hide();
  //   return event.preventDefault();
  // });

  // $(".add_fields").on("click", function (event) {
  //   console.log("test");
  //   var regexp, time;
  //   time = new Date().getTime();
  //   regexp = new RegExp($(this).data("id"), "g");
  //   $(".fields").append($(this).data("fields").replace(regexp, time));
  //   return event.preventDefault();
  // });
});
