#include <QtGui/QApplication>
#include <QtDeclarative>
#include "qmlapplicationviewer/qmlapplicationviewer.h"
#include "inneractiveplugin.h"

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QScopedPointer<QApplication> app(createApplication(argc, argv));

    QmlApplicationViewer viewer;

    inneractivePlugin::initializeEngine(viewer.engine());

    QString appPath = QApplication::applicationDirPath();
    viewer.rootContext()->setContextProperty("applicationPath", appPath);

    viewer.setMainQmlFile(QString(DATAPREFIX).append("/qml/main.qml"));
//    viewer.setMainQmlFile(QString("../../../qml/Origami/main.qml"));
    viewer.showExpanded();

    return app->exec();
}
