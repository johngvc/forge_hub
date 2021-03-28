const map = () => {
  mapboxgl.accessToken = 'pk.eyJ1IjoicGVkcm9jYXIiLCJhIjoiY2tsMHlhNGJjMHZrODJudDRnM3lscWFlcSJ9.gygRquN-O01BVwzFgD98WA';
  let map = new mapboxgl.Map({
       container: 'map', // container ID
       style: 'mapbox://styles/mapbox/streets-v11', // style URL
       center: [-46.7102453, -23.6095137], // starting position [lng, lat]
       zoom: 5 // starting zoom
                                 });
  new mapboxgl.Marker({
        color: "#ff0000",
        draggable: false
       }).setLngLat([-46.7102453, -23.6095137]).addTo(map);
  
  // new mapboxgl.Marker({
  //       color: "#AAA",
  //       draggable: false
  //      }).setLngLat([-46.6813623, -23.5918814]).addTo(map);
  
  //new mapboxgl.Marker({
      //  color: "#FFF",
      //  draggable: false
      //  }).setLngLat([-51.5119204, -20.8967688]).addTo(map);
  
  //new mapboxgl.Marker({
      //  color: "#000",
      //  draggable: false
      //  }).setLngLat([-44.1041392,-19.9026615]).addTo(map);
}

export {map}