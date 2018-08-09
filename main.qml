import QtQuick 2.9
import QtQuick.Window 2.2

import CppBackend 1.0

Window {
    visible: true
    width: 800
    height: 800
    title: qsTr("QTesseract")

    Tesseract{
        id: tes
    }

    Connections{
        target: tes
        onTesseractChanged:{
            canv.requestPaint()
        }
    }

    Canvas{
        id: canv
        anchors.fill: parent

        readonly property int d: 20
        onPaint: {
            var ctx = getContext("2d")
            ctx.reset();
            ctx.fillStyle = "black"
            ctx.beginPath();


            for(var i = 0; i < (tes.is4D() ? 16 : 8); i++){
                var point = tes.getPoint(i);
                ctx.ellipse(point.x-d/2, point.y-d/2,d,d)
            }
            ctx.fill()
            ctx.closePath()
            for(var j= 0; j < (tes.is4D() ? 16 : 8); j++){
                var nn = tes.getNearest(j);
                for( var k = 0; k < (tes.is4D() ? 4 : 3); k++){
                    ctx.beginPath();
                    var startPos =  tes.getPoint(j);
                    var endPos = tes.getPoint(nn[k])
                    ctx.moveTo(startPos.x, startPos.y)
                    ctx.lineTo(endPos.x, endPos.y)
                    ctx.stroke()
                }
            }
        }
    }
}
