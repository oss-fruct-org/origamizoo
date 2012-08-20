// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.0
import "UIConstants.js" as UI
import "constants.js" as ExtrasConstants

Item {

    Image {
        anchors.fill: parent
        source: "qrc:/qml/Origami/pic/paper.jpg"
    }

    Flickable {
        anchors.fill: parent
        contentHeight: col.height + 2 * UI.DEFAULT_MARGIN

        Column {
            id: col
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 16
            spacing: 10

            Text {
                font.family: origamiFont.name
                font.pixelSize: 84
                wrapMode: Text.Wrap
                width: parent.width
                text: "Origami Zoo"
                horizontalAlignment: Text.AlignHCenter
                color: UI.COLOR_FOREGROUND
            }

            Item {
                id: icon
                width: parent.width
                height: aboutiIcon.height

                Image {
                    id: aboutiIcon
                    anchors.centerIn: parent
                    source: "qrc:/qml/Origami/pic/about_icon.png"
                    smooth: true
                    sourceSize.width: 256
                    sourceSize.height: 210
                }
            }

            Text {
                font.pixelSize: 30
                font.weight: Font.DemiBold
                wrapMode: Text.Wrap
                width: parent.width
                text: "version 1.0.0"
                horizontalAlignment: Text.AlignHCenter
                color: UI.COLOR_FOREGROUND
            }

            Text {
                font.pixelSize: 22
                width: parent.width
                wrapMode: Text.Wrap
                horizontalAlignment: Text.AlignHCenter
                text: "Copyright 2012 " + "<font>&copy;</font>" + " Mobile and Wireless Systems Lab " +
                      "of IT-park of Petrozavodsk State University (member of FRUCT association)."
                color: UI.COLOR_FOREGROUND
            }

            Text {
                font.pixelSize: 22
                width: parent.width
                wrapMode: Text.Wrap
                horizontalAlignment: Text.AlignHCenter
                text: "Project is supported by <b>ENPI Karelia KA-179</b> grant. " +
                      "Main developer is Anna Samoryadova."
                color: UI.COLOR_FOREGROUND
            }

            Text {
                font.pixelSize: 22
                width: parent.width
                wrapMode: Text.Wrap
                horizontalAlignment: Text.AlignHCenter
                text: "Thanks <a style='color:#006abe' href='http://www.origami-fun.com/'>Origami Fun</a> project for origami diagrams."
                color: UI.COLOR_FOREGROUND
                onLinkActivated: Qt.openUrlExternally(link)
            }

            Text {
                font.pixelSize: 22
                width: parent.width
                wrapMode: Text.Wrap
                horizontalAlignment: Text.AlignHCenter
                text: "More information you can find on <a style='color:#006abe' href='http://oss.fruct.org/projects/origami/'>http://oss.fruct.org/projects/origami/</a>."
                color: UI.COLOR_FOREGROUND
                onLinkActivated: Qt.openUrlExternally(link)
            }
        }
    }
}
