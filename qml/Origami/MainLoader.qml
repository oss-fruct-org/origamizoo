import QtQuick 1.1
import com.nokia.meego 1.0

Rectangle {
    id: main
    width: 640
    height: 360
    state: "splash"
    color: "transparent"

    Loader {
        id: loader
        anchors.fill: parent
        visible: loader.source != ""
    }

    states: [
        State {
            name: "main"
            PropertyChanges {
                target: loader
                source: "main.qml"
            }
        },
        State {
            name: "splash"
            PropertyChanges {
                target: loader
                source: "SplashScreen.qml"
            }
        }
    ]
}
