import QtQuick 1.1
import com.nokia.meego 1.0

PageStackWindow {
    id: window

    ToolBarLayout {
        id: toolBarLayout
        ToolIcon {
            platformIconId: "toolbar-back"
            onClicked: window.pageStack.depth <= 1 ? Qt.quit() : window.pageStack.pop()
        }

        ToolIcon {
            platformIconId: "toolbar-content-ovi-music"
            onClicked: Qt.openUrlExternally("http://store.ovi.com/publisher/FRUCT/")
        }

        ToolIcon {
            platformIconId: "toolbar-view-menu"
            anchors.right: (parent === undefined) ? undefined : parent.right
            onClicked: (myMenu.status === DialogStatus.Closed) ? myMenu.open() : myMenu.close()
        }
    }

    Page {
        id: mainPage
        tools: toolBarLayout
        orientationLock: PageOrientation.LockPortrait

        Loader {
            id: mainLoader
            anchors.fill: parent
        }

        function load() {
            mainLoader.source = "MainPage.qml"
        }

        SequentialAnimation {
            id: activatingAnimation
            running: false
            NumberAnimation { target: mainPage; property: "opacity"; from: 0; to: 1; duration:500 }
        }
    }

    Menu {
        id: myMenu
        visualParent: pageStack

        MenuLayout {

            MenuItem {
                text: "Help"
                onClicked: {
                    myMenu.close();
                    helpPage.load();
                    pageStack.push(helpPage);
                }
            }

            MenuItem {
                text: "About"
                onClicked: {
                    myMenu.close();
                    aboutPage.load();
                    pageStack.push(aboutPage);
                }
            }
        }
    }

    Image {
        id: splashImage
        anchors.fill: parent
        source: "qrc:/qml/Origami/pic/splash.png"

        SequentialAnimation {
            id:splashanimation
            PauseAnimation { duration: 3000 }
            PropertyAnimation {
                target: splashImage
                duration: 700
                properties: "opacity"
                to: 0
            }
        }
    }

    Page {
        id: helpPage
        tools: toolBarLayout
        orientationLock: PageOrientation.LockPortrait

        Loader {
            id: helpLoader
            anchors.fill: parent
        }

        function load() {
            helpLoader.source = "HelpPage.qml"
        }
    }

    Page {
        id: aboutPage
        tools: toolBarLayout
        orientationLock: PageOrientation.LockPortrait

        Loader {
            id: aboutLoader
            anchors.fill: parent
        }

        function load() {
            aboutLoader.source = "AboutPage.qml"
        }
    }

    FontLoader {
        id: origamiFont
        source: "qrc:/qml/Origami/font/font.ttf"
    }

    Component.onCompleted: {
        splashanimation.start()
        mainPage.load()
        pageStack.push(mainPage)
    }
}
