
init = ->
    myMap = new ymaps.Map 'map', { center: [55.76, 37.64], zoom: 10}
    # Отключаем некоторые включенные по умолчанию поведения:
    # - rightMouseButtonMagnifier - увеличение области, выделенной
    #   правой кнопкой мыши.
    myMap.behaviors.disable ['rightMouseButtonMagnifier']
    # Включим редактор маршрутов behavior.RouteEditor
    #   see https://tech.yandex.ru/maps/doc/jsapi/2.1/ref/reference/behavior.RouteEditor-docpage/
    myMap.behaviors.enable 'routeEditor'
    return

ymaps.ready(init)
    