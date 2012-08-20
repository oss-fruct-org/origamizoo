// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.0
import "UIConstants.js" as UI

Item {

    width: ListView.view.width
    height: ListView.view.height
    property string stepNumber: number

    function parseDescription() {
        var spaceIndex = description.indexOf(' ');
        return description.slice(spaceIndex, description.length).trim()
    }

    function parseStep() {
        return description.split(' ')[0]
    }

    Image {
        id: stepImage
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -64
        sourceSize.width: parent.width
        smooth: true
        fillMode: Image.PreserveAspectFit
        height: 467
        anchors.margins: 10
        source: "figures/" + figureView.figureFolder + "/" + image
    }

    Text {
        id: stepText
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 6
        wrapMode: Text.Wrap
        font.pixelSize: UI.FONT_DEFAULT
        font.weight: Font.Light
        text: description
        horizontalAlignment: Text.AlignLeft
        visible: (number != "Final")
    }

    Text {
        id: finalText
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 16
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        wrapMode: Text.Wrap
        font.family: origamiFont.name
        font.pixelSize: 64
        font.weight: Font.Light
        text: "Finished<br/>" + figureName + "!"
        horizontalAlignment: Text.AlignHCenter
        visible: (number == "Final")
    }
}
