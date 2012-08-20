TARGET = Origami-Zoo-free
TEMPLATE = app

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

QT += declarative

# Add dependency to Symbian components
CONFIG += qt-components

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp \
	qmlapplicationviewer/qmlapplicationviewer.cpp

HEADERS += qmlapplicationviewer/qmlapplicationviewer.h

OTHER_FILES = \
    qml/Origami/*.js \
    qml/Origami/*.qml \
    qml/Origami/FullBanner.qml

unix {
    #VARIABLES
    isEmpty(PREFIX) {
        PREFIX = $$[QT_INSTALL_PREFIX]
    }
}
message(prefix is $$PREFIX)

# integrate inneractiveAdQML
include(component/component.pri)

# prefix for search shared files
DATAPREFIX=$$PREFIX/share
DEFINES += DATAPREFIX=\\\"$$DATAPREFIX\\\"
message(dataprefix is $$DATAPREFIX)

BINDIR = $$PREFIX/bin
DATADIR =$$PREFIX/share

target.path = $$BINDIR
INSTALLS += target

# enable booster
CONFIG += qdeclarative-boostable
QMAKE_CXXFLAGS += -fPIC -fvisibility=hidden -fvisibility-inlines-hidden
QMAKE_LFLAGS += -pie -rdynamic

qml.path = $$DATADIR/qml
qml.files += $${OTHER_FILES}
INSTALLS += qml

figures.path = $$DATADIR/qml
figures.files += qml/Origami/figures
INSTALLS += figures

symbols.path = $$DATADIR/qml
symbols.files += qml/Origami/symbols
INSTALLS += symbols

# desktop file
desktop.path = /usr/share/applications
desktop.files = $${TARGET}.desktop
INSTALLS += desktop

contains(MEEGO_EDITION,harmattan):{
    pixmapmeego.path = /usr/share/icons/hicolor/80x80/apps
    pixmapmeego.files += $${TARGET}80.png
    INSTALLS += pixmapmeego
}

RESOURCES += \
    res.qrc
