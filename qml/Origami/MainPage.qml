import QtQuick 1.1
import com.nokia.meego 1.0

Item {
    id: mainPage

    XmlListModel {
        id: figuresModel
        source: "figures/figures.xml"
        query: "/figures/figure"

        XmlRole {
            name: "name"
            query: "name/string()"
        }

        XmlRole {
            name: "folder"
            query: "folder/string()"
        }

        XmlRole {
            name: "level"
            query: "level/string()"
        }

        XmlRole {
            name: "steps"
            query: "steps/string()"
        }
    }

    FigureView {
        id: figureView
    }

    Image {
        anchors.fill: parent
        source: "qrc:/qml/Origami/pic/paper.jpg"
    }

    ListView {
        id: origamiList

        header: Header {
            title: "Origami Zoo"
        }

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.top: parent.top

        model: figuresModel

        delegate: OrigamiDelegate {
            onDelegateClicked: {
                figureView.figureName = name;
                figureView.figureFolder = folder;
                figureView.stepsCount = steps
                pageStack.push(figureView);
            }
        }
    }
}
