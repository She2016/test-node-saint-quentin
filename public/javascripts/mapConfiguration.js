if (localStorage.getItem('user_id')) {
    window.location = `/users/${localStorage.getItem('user_id')}`
}

$(window).resize(function () {
    $('#mapid').height($(window).height() - 160);
    $('#information1').height($(window).height() - 250);
});
$(window).trigger('resize');
var map = L.map('mapid').setView([49.846921, 3.287297], 14);
L.tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a>',
    subdomains: ['a', 'b', 'c']
}).addTo(map);
var myStyle = {
    radius: 10,
    fillColor: "#ff7800",
    color: "#000",
    weight: 1,
    opacity: 1,
    fillOpacity: 0.8
};
var maStyle = {
    radius: 13,
    fillColor: "green",
    color: "#000",
    weight: 1,
    opacity: 1,
    fillOpacity: 0.8
};
var mylabels = {
    background: "#fff",
};

var geojsonLayer = new L.GeoJSON.AJAX("/assets/geojson/schools.geo.json", {
    pointToLayer: function (feature, latlng) {
        return L.circleMarker(latlng, myStyle)
    },
    onEachFeature: function (feature, layer) {
        layer.bindTooltip(feature.properties.nom.toString());
        //bind click
        layer.on({
            click: whenClicked
        });
    }
}).addTo(map);

var geojsonLayer2 = new L.GeoJSON.AJAX("/assets/geojson/saintquentin.geo.json", {
    pointToLayer: function (feature, latlng) {
        if (feature.properties.nom == "La Manufacture") {
            var customPopup = `<div onclick="dosomething()"><b>${feature.properties.nom}</b><hr><img width='200' height='150' src='images/${feature.properties.image}'/></div>`;
        } else {
            var customPopup = `<div><b>${feature.properties.nom}</b><hr><img width='100' height='100' src='images/${feature.properties.image}'/></div>`;
        }
        // create popup contents
        // specify popup options
        var customOptions = {
            'maxWidth': '500',
            'className': 'custom',
            'autoClose': false,
            'closeOnClick': false,
            'autoPan': false
        }
        return L.circleMarker(latlng, maStyle).bindPopup(customPopup, customOptions).addTo(map).openPopup().closePopup();
    },
    onEachFeature: function (feature, layer) {
        //layer.bindTooltip();
        //bind click
        // layer.on({
        //     click: whenClicked
        // });
    }
}).addTo(map);
map.on('zoomend', function () {
    var zoom = map.getZoom();
    if (zoom < 15) {
        geojsonLayer.eachLayer(function (l) {
            if (l.getTooltip) {
                var toolTip = l.getTooltip();
                l.unbindTooltip().bindTooltip(toolTip, {
                    permanent: false
                })
            }
        });
        geojsonLayer2.eachLayer(function (l) {
            if (l.getTooltip) {
                var toolTip = l.getTooltip();
                l.unbindTooltip(toolTip);
            }
            var popUp = l.getPopup();
            l.closePopup(popUp);
        });
    } else if (zoom == 15) {
        //spliting();
        geojsonLayer.eachLayer(function (l) {
            if (l.getTooltip) {
                var toolTip = l.getTooltip();
                l.unbindTooltip().bindTooltip(toolTip, {
                    permanent: true,
                    direction: "top",
                    className: "mylabels"
                })
            }
        });
        geojsonLayer2.eachLayer(function (l) {
            l.bindTooltip(l.feature.properties.nom.toString(), {
                permanent: true,
                direction: "top",
                className: "mylabels"
            })
            var popUp = l.getPopup();
            l.closePopup(popUp);
        });
    } else if (zoom == 16) {
        geojsonLayer2.eachLayer(function (l) {
            if (l.getTooltip) {
                var toolTip = l.getTooltip();
                l.unbindTooltip(toolTip);
            }
            if (l.getPopup) {
                var popUp = l.getPopup();
                l.openPopup(popUp);
            }
        });
    }
})

function whenClicked(e) {
    var customPopup = "<h5 class='card-title'>" +
        e.target.feature.properties.nom + "</h5>";
    for (key in e.target.feature.properties) {
        if (key == "url") {
            customPopup += "<div> <b>" + capitalizeFirstLetter(key) + ":  </b><a target='_blank' href='" + e.target.feature.properties[key] + "'>See the 3D Model</a></div>";
        } else {
            customPopup += "<div> <b>" + capitalizeFirstLetter(key) + ":</b> " + e.target.feature.properties[key] + "</div>";
        }
    }
    customPopup += "</div></div>";
    $("#information1").html(customPopup);
}

function capitalizeFirstLetter(string) {
    var str = string.replace(/_/g, " ");
    return str.charAt(0).toUpperCase() + str.slice(1);
}

function dosomething() {
    var template = $('#figures').html();
    html = Mustache.render(template, {
        title: "Registeration",
    });
    $('#information1').html(html);
}

$('.close').on('click', function () {
    $("#information").css("display", "none");
});

function changeform() {
    var x = $("#regorlog").text();
    var html;
    var template = $('#template').html();
    if (x == 'Sign in') {
        html = Mustache.render(template, {
            title: "Log in",
            btn: "Log in",
            account: "Create an account",
            face: "Log in with Facebook",
            twitter: "Log in with Twitter",
            formid: "login"
        });
    } else {
        html = Mustache.render(template, {
            title: "Registeration",
            btn: "Register",
            account: "Sign in",
            face: "Register with Facebook",
            twitter: "Register in with Twitter",
            formid: "signup"
        });
    }
    $('#information1').html(html);
}

map.on('click', function (e) {
    //console.log(e.latlng);
    map.setView(e.latlng, 15);
});