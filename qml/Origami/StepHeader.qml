// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import "UIConstants.js" as UI

Rectangle {
    id: header
    height: 80
    width: parent.width
    color: "#4791d6"

    property string name: ""
    property string steps: ""
    property string currentStep: ""

    Text {
        id: figureName
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: 3
        anchors.left: parent.left
        anchors.margins: (width >= 255) ? 6 : UI.DEFAULT_MARGIN
        elide: Text.ElideRight
        font.family: origamiFont.name
        text: name
        font.pixelSize: 58
        color: "white"
        smooth: true
    }

    Text {
        id: stepsText
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.margins: (figureName.width >= 255) ? 6 : UI.DEFAULT_MARGIN
        elide: Text.ElideRight
        text: (currentStep != "Final") ? currentStep + "/" + steps : ""
        font.pixelSize: 42
        font.weight: Font.Light
        color: "white"
        smooth: true
    }
}
