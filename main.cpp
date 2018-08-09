#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "backend.h"

int main(int argc, char *argv[])
{
    qRegisterMetaType<QVector2D>("QVector2D");
    qRegisterMetaType<QList<QVector2D> > ("QList<QVector2D>");
    qRegisterMetaType<const double *>("const double *");

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    qmlRegisterType<Backend>("CppBackend",1,0,"Tesseract");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
