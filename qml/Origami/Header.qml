// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import "UIConstants.js" as UI

Rectangle {
    id: header
    height: 80
    width: parent.width
    color: "#4791d6"

    property string title: ""
    property bool isSubtitle: true

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

    Text {
        id: freeText
        anchors.left: titleText.right
        anchors.bottom: titleText.bottom
        anchors.leftMargin: 12
        text: "free"
        font.family: origamiFont.name
        font.pixelSize: 52
        font.weight: Font.Normal
        color: "#f83f24"
        smooth: true
        visible: isSubtitle
    }
}
