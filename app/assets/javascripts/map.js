$(document).ready(function() {
     L.mapbox.accessToken = 'pk.eyJ1IjoiZHNrdWFuZyIsImEiOiIwMmNiYjYyNjhiZjZhZTY3YmM2MGJlYzRlZTk5OGU5MiJ9.BCDqhKft-Nvohw6VM_8AWQ';
     var map = L.mapbox.map('map', 'dskuang.cieeivryr0257s0kqr17y3nct')
     .setView([37.8, -96], 4);

     $.ajax({
        dataType: 'json',
        url: '/lists',
        success: function(data) {
          map.featureLayer.setGeoJSON(data.features);
        }
      })


});
