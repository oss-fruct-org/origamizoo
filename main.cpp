#include <QtGui/QApplication>
#include <QtDeclarative>
#include "qmlapplicationviewer/qmlapplicationviewer.h"

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QScopedPointer<QApplication> app(createApplication(argc, argv));

    QmlApplicationViewer viewer;

    QString appPath = QApplication::applicationDirPath();
    viewer.rootContext()->setContextProperty("applicationPath", appPath);

    viewer.setMainQmlFile(QString(DATAPREFIX).append("/qml/main.qml"));
//    viewer.setMainQmlFile(QString("qml/Origami/main.qml"));
    viewer.showExpanded();

    return app->exec();
}
