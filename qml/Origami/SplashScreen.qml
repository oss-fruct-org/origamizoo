import QtQuick 1.1
import com.nokia.meego 1.0

Item {
    id: splashScreenContainer
    anchors.fill: parent

    // image source is kept as an property alias, so that it can be set from outside
    property string imageSource: "qrc:/qml/Origami/pic/splash_landscape.png"

    // signal emits when splashscreen animation completes
    signal splashScreenCompleted()
    Image {
        id: splashImage
        source: imageSource
        anchors.fill: splashScreenContainer // do specify the size and position
    }

    // simple QML animation to give a good user experience
    SequentialAnimation {
        id:splashanimation
        PauseAnimation { duration: 3000 }
        PropertyAnimation {
            target: splashImage
            duration: 700
            properties: "opacity"
            to: 0
        }
        onCompleted: {
            splashScreenContainer.splashScreenCompleted()
        }
    }

    //starts the splashScreen
    Component.onCompleted: splashanimation.start()
    onSplashScreenCompleted: main.state = 'main'
}
