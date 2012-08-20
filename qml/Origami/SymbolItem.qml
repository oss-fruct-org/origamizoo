// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.0
import "UIConstants.js" as UI
import "constants.js" as ExtrasConstants

Item {
    width: parent.width
    height: symbolRow.height

    property alias imageWidth: symbolIcon.sourceSize.width
    property alias imageHeight: symbolIcon.height
    property alias imageSource: symbolIcon.source
    property alias meaning: symbolText.text

    Row {
        id: symbolRow
        spacing: UI.DEFAULT_MARGIN
        width: parent.width

        Image {
            id: symbolIcon
            fillMode: Image.PreserveAspectFit
            width: sourceSize.width
            height: 64
            smooth: true
            sourceSize.width: parent.width / 2 - UI.DEFAULT_MARGIN
        }

        Text {
            id: symbolText
            font.pixelSize: UI.FONT_DEFAULT
            anchors.verticalCenter: symbolIcon.verticalCenter
            width: parent.width - symbolIcon.width - symbolRow.spacing
            wrapMode: Text.Wrap
            horizontalAlignment: Text.AlignLeft
            color: UI.COLOR_FOREGROUND
        }
    }
}
