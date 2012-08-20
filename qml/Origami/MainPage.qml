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
            name: "price"
            query: "price/string()"
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

    FullBanner {
        id: banner
        z: 3
    }

    ListView {
        id: origamiList
        interactive: banner.opacity == 0

        header: Header {
            title: "Origami Zoo"
        }

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: adItem.visible ? adItem.top : parent.bottom
        anchors.top: parent.top

        model: figuresModel

        delegate: OrigamiDelegate {
            onDelegateClicked: {
                if (banner.opacity > 0)
                    return;
                if (price === "1") {
                    banner.show();
                } else {
                    figureView.figureName = name;
                    figureView.figureFolder = folder;
                    figureView.stepsCount = steps
                    pageStack.push(figureView);
                }
            }
        }
    }

    AdItem {
        id: adItem
        showText: false

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: 80
        reloadInterval: adInterface.networkAccessible ? 30 : 0
        scaleAd: true
        parameters: AdParameters {
            applicationId: "FRUCT_Origami_Zoo_OVI"
        }
        visible: adInterface.networkAccessible
    }
}
