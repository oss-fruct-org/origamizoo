import QtQuick 1.1

Rectangle {
    property string title
    property bool isAcceptStyle: false
    signal buttonClicked()

    width: 110
    height: 50
    radius: 5
    color: isAcceptStyle ? "#055dde" : "black"
    border.width: 1
    border.color: "gray"

    Text {
        id: buttonText
        font.pixelSize: 26
        color: "white"
        text: title
        anchors.centerIn: parent
    }

    MouseArea {
        anchors.fill: parent
        onClicked: buttonClicked()
    }
}
