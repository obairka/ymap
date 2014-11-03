class RouteMaker
    constructor: (@map, @addRouteButton) ->
        @addRouteButton.events.add 'select', this.addRouteButtonSelect, this
        @addRouteButton.events.add 'deselect', this.addRouteButtonDeselect, this
        @map.controls.add @addRouteButton        



    addRouteButtonSelect : ->
        @init()
        @map.behaviors.disable ['dblClickZoom']
        @map.events.add 'click', this.mapClickHandler, this    
        return
    addRouteButtonDeselect : ->
        @map.events.remove 'click', this.mapClickHandler, this
        @map.behaviors.enable 'dblClickZoom'        
        @end()
        return    

    init: ->
        @route = new ymaps.GeoObjectCollection {

            },
            {
                draggable: true
            }
        @map.geoObjects.add(@route)
        return
    end: ->
        # send object @route
        coords = []
        @route.each (point) -> coords.push point.geometry.getCoordinates();
        alert "JSON = #{JSON.stringify coords}"
        #$.ajax {
        #        url: "routes/new",
        #        dataType: 'json',
        #        data: { 'coords': @coords}, 
        #        success: (msg) ->
        #    }
        return

    mapClickHandler: (e)->
        placemark = @createPlacemark e.get 'coords' 
        @route.add placemark
        return 

    createPlacemark: (coords) ->
        if @route.getLength() is 0 
            hint = 'start'
            icon = 'islands#redIcon'

        placemark = new ymaps.GeoObject {
                geometry: {
                    type: "Point",
                    coordinates: coords
                },
                properties: {
                    hintContent: hint
                },            
            },
            {
                preset: icon
                draggable: true
            }


mapInit = ->
    myMap = new ymaps.Map 'map', {
            center: [55.76, 37.64], 
            zoom: 10, 
            controls: ['fullscreenControl', 'geolocationControl', 'searchControl', 'typeSelector', 'zoomControl', 'rulerControl']
        }
    
    addRouteButton = new ymaps.control.Button {
            data: {
                content: "Добавить маршрут"
            },
            options: {
                maxWidth: 150,
                float: 'left'
            }
        }


    addRouteButton = new ymaps.control.Button {
            data: {
                content: "Добавить маршрут"
            },
            options: {
                maxWidth: 150,
                float: 'left'
            }
        }
    
    routeMaker = new RouteMaker myMap, addRouteButton

    return

ymaps.ready(mapInit)
    