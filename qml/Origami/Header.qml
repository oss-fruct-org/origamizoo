// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import "UIConstants.js" as UI

Rectangle {
    id: header
    height: 80
    width: parent.width
    color: "#4791d6"

    property string title: ""

    Text {
        id: titleText
        anchors.left: parent.left
        anchors.leftMargin: 16
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: 3
        anchors.margins: UI.DEFAULT_MARGIN
        elide: Text.ElideRight
        text: title
        font.family: origamiFont.name
        font.pixelSize: 58
        font.weight: Font.Normal
        color: "white"
        smooth: true
    }
}
