<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
	<link rel="stylesheet" type="text/css" href="/css/home.css">
	<link href="https://fonts.googleapis.com/css?family=Baskervville|Roboto+Mono&display=swap" rel="stylesheet">
	
	<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
 	<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD9XuSocOU1HX2gzkpBUWfMxFp6b3uwiVU&callback=initMap" async defer></script>
    <script>
     class GoogleMap{
            constructor(){
                this.instance = this;
                this.key = 'AIzaSyD9XuSocOU1HX2gzkpBUWfMxFp6b3uwiVU'
            }

            geocode(location, name) {
                axios.get('https://maps.googleapis.com/maps/api/geocode/json', {
                    params: {
                        address: location,
                        key: 'AIzaSyD9XuSocOU1HX2gzkpBUWfMxFp6b3uwiVU'
                    }
                })
                .then((response) => {

                    //log full response
                    console.log(response);

                //geometry
                var lat = response.data.results[0].geometry.location.lat;
                var lng = response.data.results[0].geometry.location.lng;
                var marker = [
                    {
                        coords:{lat: lat, lng: lng },
                        content: '<h4>'+name+' Neighbors</h4><br><a class="text-primary" href="https://www.google.com/maps/dir///@37.8063244,-122.2767202,15z/data=!4m2!4m1!3e0">Get Directions</a>'
                    
                    }
                ]
                addMarker(marker[0])
                
            })
            .catch(function (error) {
                console.log(error);
            });
        };
        
    }

    function addMarker(props) {
        var marker = new google.maps.Marker({
            position: props.coords,
            map: map,
            icon:'http://maps.google.com/mapfiles/ms/icons/campground.png'
        });
        //Check for custom icon
        if (props.iconImage) {
            //Set icon image
            marker.setIcon(props.iconImage);
        }
        if (props.content) {
            var infoWindow = new google.maps.InfoWindow({
                content: props.content
            });

            marker.addListener('click', function () {
                infoWindow.open(map, marker);
            });
        }
    }
    var map;
    function initMap() {
        //Map options
        var options = {
            zoom: 13,
            center: { lat: 37.8043514, lng: -122.2711639 }
        }
        //New map
        map = new google.maps.Map(document.getElementById('map'), options);
    }

    var googMap = new GoogleMap();
    var places = ${data}
    for(var comm of places){
        console.log(comm.location)
        googMap.geocode(comm.location, comm.name)
    }

    
	</script>
	
        
	
<title>Resourcefull - Logged In Home Page</title>
</head>

<body>
	<div class="topOfPage">
		<img src="/img/logo.svg" alt="error" class="logo">
		<p class="title text-center">Keeping Neighbors Safe Where They Are</p>
		<div class="whiteLine"></div>
		<div class="navbar movenavbar"><a class="text-light" href="/resourcefull/home">HOME</a></div>
		<div class="navbar"><a class="text-light" href="/resourcefull/learnmore">GET INVOLVED</a></div>
		<div class="navbar"><a class="text-light" href="/resourcefull">ABOUT</a></div>
		<div class="navbar"><a class="text-light" href="/resourcefull/blog">BLOG</a></div>
		<div class="navbar"><a class="text-light" href="/resourcefull/learnmore">CONTACT</a></div>
		<div class="navbar"><a class="text-light" href="/resourcefull/signup">SIGN-UP</a></div>
		<div class="navbar"><a class="text-light" href="/resourcefull/login">LOGIN</a></div>
		<div class="navbar">
			<form id="logoutForm" method="POST" action="/logout">
        		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        		<input class="btn btn-link text-light" type="submit" value="LOGOUT" />
    		</form>
    	</div>
	</div>
	
	<p class="text-center welcome">Welcome <c:out value="${currentUser.first_name}"></c:out>!</p>
	<div class="middleOfPage row">
		<div class="col-6">			
			<table class="table">
					<thead class="thead-dark">
						<tr>
							<th scope="col" class="lead">Neighborhood</th>
							<th scope="col" class="lead"># of Neighbors</th>
							<th scope="col" class="lead"># of Pets</th>
							<th scope="col" class="lead">Action</th>
						</tr>
					</thead>
	
					<tbody>
					<c:forEach items="${communities}" var="community">
						<tr>
							<td class="tableText"><a href="/resourcefull/neighborhood/${community.id}"><c:out value="${community.name}"/></a></td>
							<td class="tableText"><c:out value="${community.residents}"/></td>
							<td class="tableText"><c:out value="${community.pets}"/></td>
							<td class="tableText"><a class="btn btn-outline-danger" href="/neighborhood/${community.id}/delete">Delete</a></td>
								
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<a class="btn btn-outline-secondary btn-lg ml-3" href="/resourcefull/add/neighborhood">Add a Neighborhood</a>
		</div>
				
		<div id="map" class="col-6"></div>
			<!-- end of row -->
	</div>
	
	
	

	


</body>
</html>