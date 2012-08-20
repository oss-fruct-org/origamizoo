// import QtQuick1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.0
import "UIConstants.js" as UI

Item {
    id: delegate
    width: ListView.view.width
    height: 107

    signal delegateClicked

    Row {
        id: info
        anchors.fill: parent
        anchors.leftMargin: UI.DEFAULT_MARGIN
        anchors.rightMargin: UI.DEFAULT_MARGIN
        spacing: UI.DEFAULT_MARGIN

        Image {
            id: origamiIcon
            width: 100
            height: width
            source: "figures/" + folder + "/icon.svg"
            smooth: true
            clip: true
        }

        Column {
            id: infoColumn
            width: parent.width - origamiIcon.width - UI.DEFAULT_MARGIN
            spacing: 4

            Text {
                id: title
                width: parent.width
                wrapMode: Text.Wrap
                font.pixelSize: UI.FONT_DEFAULT
                color: UI.COLOR_FOREGROUND
                style: Text.Raised
                text: name
            }

            Row {
                spacing: 4

                Text {
                    id: origamiLevel
                    font.pixelSize: UI.FONT_LSMALL
                    font.weight: Font.Light
                    color: UI.COLOR_FOREGROUND
                    text: qsTr("Level: ")
                    elide: Text.ElideRight
                }

                Repeater {
                    model: level

                    Image {
                        id: star
                        source: "qrc:/qml/Origami/pic/star.svg"
                        width: 26
                        height: width
                    }
                }    
            }

            Text {
                id: origamiSteps
                font.pixelSize: UI.FONT_LSMALL
                font.weight: Font.Light
                color: UI.COLOR_FOREGROUND
                text: qsTr("Steps: "+ steps)
                elide: Text.ElideRight
            }
        }
    }

    Image {
        anchors.right: parent.right
        anchors.rightMargin: UI.DEFAULT_MARGIN
        anchors.verticalCenter: parent.verticalCenter
        source: "image://theme/icon-m-common-drilldown-arrow"
    }

    Divider {
        id: divider
        anchors.top: info.bottom
        margins: 8
    }

    MouseArea {
        anchors.fill: parent

        onClicked: delegateClicked()
    }
}
