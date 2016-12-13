$(function(){
  $(".input-address").geocomplete({
    details: "form",
    types: ["geocode", "establishment"],
    detailsAttribute: "data-geo"
  });
})


