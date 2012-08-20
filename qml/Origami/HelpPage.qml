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

    Header {
        id: helpHeader
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        title: "Symbols"
        z: 2
    }

    Flickable {
        anchors.top: helpHeader.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        contentHeight: col.height + 2 * UI.DEFAULT_MARGIN

        Column {
            id: col
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.margins: 16
            spacing: 10

            SymbolItem {
                imageSource: "symbols/gray_line.svg"
                meaning: "Crease line"
            }

            SymbolItem {
                imageSource: "symbols/dotted.svg"
                meaning: "Valley fold"
            }

            SymbolItem {
                imageSource: "symbols/fold.svg"
                meaning: "Fold in this direction"
            }

            SymbolItem {
                imageSource: "symbols/fold_unfold.svg"
                meaning: "Fold and unfold"
            }

            SymbolItem {
                imageSource: "symbols/mountain_fold.svg"
                meaning: "Mountain fold"
                imageHeight: 120
            }

            SymbolItem {
                imageSource: "symbols/rotate.svg"
                meaning: "Turn over"
            }

            SymbolItem {
                imageSource: "symbols/rotate90.svg"
                meaning: "Rotate"
            }

            SymbolItem {
                imageSource: "symbols/air.png"
                imageHeight: 75
                meaning: "Blow up"
            }

            SymbolItem {
                imageSource: "symbols/scissors.svg"
                meaning: "Cut"
            }
        }
    }
}
