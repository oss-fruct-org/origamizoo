// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.0

Page {
    id: figurePage
    orientationLock: PageOrientation.LockPortrait
    tools: toolBarLayout
    property string figureName
    property string figureFolder
    property string stepsCount

    XmlListModel {
        id: stepModel
        source: "figures/" + figureFolder + "/figure.xml"
        query: "/figure/step"

        XmlRole {
            name: "number"
            query: "number/string()"
        }

        XmlRole {
            name: "image"
            query: "image/string()"
        }

        XmlRole {
            name: "description"
            query: "text/string()"
        }
    }

    Image {
        anchors.fill: parent
        source: "qrc:/qml/Origami/pic/paper.jpg"
    }

    StepHeader {
        id: stepHeader
        name: figureName
        steps: stepsCount
        currentStep: "1"
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
    }

    ListView {
        id: stepsView
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: stepHeader.bottom
        anchors.bottom: parent.bottom

        delegate: StepDelegate {}
        orientation: ListView.Horizontal
        model: stepModel
        snapMode: ListView.SnapOneItem
        highlightRangeMode: ListView.StrictlyEnforceRange

        onCurrentIndexChanged: {
            var item = stepModel.get(currentIndex);
            if (item !== undefined)
                stepHeader.currentStep = stepModel.get(currentIndex).number
        }

    }
}
