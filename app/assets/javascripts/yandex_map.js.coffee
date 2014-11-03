
init = ->
    myMap = new ymaps.Map 'map', {
            center: [55.76, 37.64], 
            zoom: 10, 
            controls: ['fullscreenControl', 'geolocationControl', 'searchControl', 'typeSelector', 'zoomControl', 'rulerControl']
        }
    # Отключаем некоторые включенные по умолчанию поведения:
    # - rightMouseButtonMagnifier - увеличение области, выделенной
    #   правой кнопкой мыши.
    # myMap.behaviors.disable ['rightMouseButtonMagnifier']
    
    # Включим редактор маршрутов behavior.RouteEditor
    #   see https://tech.yandex.ru/maps/doc/jsapi/2.1/ref/reference/behavior.RouteEditor-docpage/
    # myMap.behaviors.enable 'routeEditor'

    addRouteButton = new ymaps.control.Button {
            data: {
                content: "Добавить маршрут"
            },
            options: {
                maxWidth: 150,
                float: 'left'
            }
        }

    createPlacemark = (e) ->
        myMap.geoObjects.add new ymaps.GeoObject {
                geometry: {
                    type: "Point",
                    coordinates: e.get('coords')
                }
            } 
        
        return 

    addRouteButtonSelect = ->
        myMap.behaviors.disable ['dblClickZoom']
        myMap.events.add 'click', createPlacemark            
        
        return
    addRouteButtonDeselect = ->
        myMap.events.remove 'click', createPlacemark
        myMap.behaviors.enable 'dblClickZoom'
        
        return    

    addRouteButton.events.add 'select', addRouteButtonSelect
    addRouteButton.events.add 'deselect', addRouteButtonDeselect 

    myMap.controls.add addRouteButton

    return

ymaps.ready(init)
    