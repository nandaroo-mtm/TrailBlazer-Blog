$(function () {
  $("#post_image").on("change", function (event) {
    console.log('post_image')
    var files = event.target.files;
    var image = files[0];
    var reader = new FileReader();
    reader.onload = function (file) {
      console.log('post_image')
      $(".img_prev").attr("src", file.target.result);
    };
    reader.readAsDataURL(image);
  });

});
