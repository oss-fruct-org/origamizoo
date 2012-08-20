// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle {
    id: banner
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.verticalCenter: parent.verticalCenter
    color: "black"
    opacity: 0
    radius: 10
    anchors.margins: 16
    border.width: 1
    border.color: "grey"
    height: 320

    function show () {
        popupShowAnim.start()
    }

    function hide () {
        popupHideAnim.start()
    }

    Column {
        id: col
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -6
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 10

        Text {
            width: parent.width
            wrapMode: Text.Wrap
            smooth: true
            font.family: origamiFont.name
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 42
            color: "white"
            text: "6 figures is not enough?!<br/>" +
                  " You can buy full version of 'Orizami Zoo' with 16 figures and no ads."
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 60

            Button {
                title: "SKIP"
                onButtonClicked: {
                    hide()
                }
            }

            Button {
                title: "BUY"
                isAcceptStyle: true

                onButtonClicked: { Qt.openUrlExternally("http://store.ovi.com/content/282050"); hide(); }
            }
        }
    }

    SequentialAnimation {
        id: popupShowAnim
        running: false
        NumberAnimation { target: banner; property: "opacity"; from: 0; to: 0.7; duration: 500 }
    }

    SequentialAnimation {
        id: popupHideAnim
        running: false
        NumberAnimation { target: banner; property: "opacity"; from: 0.7; to: 0; duration: 500 }
    }
}
