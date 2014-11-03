class RouteMaker
    constructor: (@map) -> 

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
        

    init: ->
        @route = new ymaps.GeoObjectCollection {

            },
            {
                draggable: true
            }
        @map.geoObjects.add(@route)

    end: ->
        return

    mapClickHandler: (e)->
        placemark = this.createPlacemark e.get 'coords' 
        @route.add placemark
        return 


init = ->
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

    
    routeMaker = new RouteMaker myMap

    
    addRouteButtonSelect = ->
        routeMaker.init()
        myMap.behaviors.disable ['dblClickZoom']
        myMap.events.add 'click', routeMaker.mapClickHandler, routeMaker    
        return
    addRouteButtonDeselect = ->
        myMap.events.remove 'click', routeMaker.mapClickHandler, routeMaker       
        myMap.behaviors.enable 'dblClickZoom'        
        routeMaker.end()
        return    
    

    addRouteButton.events.add 'select', addRouteButtonSelect
    addRouteButton.events.add 'deselect',addRouteButtonDeselect

    myMap.controls.add addRouteButton

    return

ymaps.ready(init)
    