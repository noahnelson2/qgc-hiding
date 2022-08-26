/****************************************************************************
 *
 * (c) 2009-2020 QGROUNDCONTROL PROJECT <http://www.qgroundcontrol.org>
 *
 * QGroundControl is licensed according to the terms in the file
 * COPYING.md in the root of the source code directory.
 *
 ****************************************************************************/

import QtQuick                      2.12
import QtQuick.Controls             2.12
import QtQuick.Layouts              1.11

import QGroundControl               1.0
import QGroundControl.Controls      1.0
import QGroundControl.ScreenTools   1.0
import "."                          1.0

// Label control whichs pop up a flight mode change menu when clicked
// Any changes made here should also be reflected in MainRootWindow.qml
QGCLabel {
    id:     _root

    property var    currentVehicle:         QGroundControl.multiVehicleManager.activeVehicle //look at this file to see how it's refrenced
    property real   mouseAreaLeftMargin:    0
    property string accessType:             CustomAPMAirframeComponent.accessType //PasswordSettings.currentAccessType
    //property string accessType: QGroundControl.corePlugin.accessType

    //property PasswordSettings currentAccessType: QGroundControl.corePlugin.accessType

//    function receive(value){
//        accessType = value
//    }


    Menu {
        id: flightModesMenu
        //MenuItem {
            //enabled: true
            //onTriggered: {
               // flightModeMenuItemComponent.updateFlightModesMenu()
           // }
        //}
    }

    Component {
        id: flightModeMenuItemComponent

        MenuItem {
            enabled: true
            onTriggered: {
                //flightModeMenuItemComponent.updateFlightModesMenu()
                currentVehicle.flightMode = text
            }
        }
    }


//    QGCButton {
//        width:      ScreenTools.defaultFontPixelWidth * 10
//        text:       qsTr("Submit")
//        enabled:    passcodeField.text !== ""
//        //property string accessType: ""

//    }

//    QGCTextField {
//        id:                     passcodeField
//        Layout.preferredWidth:  _secondColumnWidth
//        Layout.fillWidth:       true
//        text:                   ""
//    }

    property var flightModesMenuItems: []


    function updateFlightModesMenu() {
        //accessType = PasscodeManager.submitPasscode(passcodeField.text)
        //accessType = CustomCorePlugin.getAccessType()
        //accessType = AccessType.accessTypeString(AccessTypeConfig.getInitialUserAccessType())


        if (currentVehicle && currentVehicle.flightModeSetAvailable) {
            var i;
            for (i = 0; i < flightModesMenuItems.length; i++) {
                flightModesMenu.removeItem(flightModesMenuItems[i])
            }
            flightModesMenuItems.length = 0
            for (i = 0; i < currentVehicle.flightModes.length; i++) {
                var menuItem = flightModeMenuItemComponent.createObject(null, { "text": currentVehicle.flightModes[i] })
                if (accessType == "Basic") {
                    if (currentVehicle.flightModes[i] === "Stabilize" || currentVehicle.flightModes[i] === "Altitude Hold" ||
                            currentVehicle.flightModes[i] === "Auto" || currentVehicle.flightModes[i] === "Loiter" ||
                            currentVehicle.flightModes[i] === "RTL" || currentVehicle.flightModes[i] === "Circle" ||
                            currentVehicle.flightModes[i] === "Land" || currentVehicle.flightModes[i] === "Position Hold" ||
                            currentVehicle.flightModes[i] === "Brake" || currentVehicle.flightModes[i] === "Smart RTL") {
                        flightModesMenuItems.push(menuItem)
                        flightModesMenu.insertItem(i, menuItem)
                    }
                }
                else if (accessType == "Expert") {
                    if (currentVehicle.flightModes[i] === "Stabilize" || currentVehicle.flightModes[i] === "Altitude Hold" ||
                            currentVehicle.flightModes[i] === "Auto" || currentVehicle.flightModes[i] === "Loiter" ||
                            currentVehicle.flightModes[i] === "RTL" || currentVehicle.flightModes[i] === "Circle" ||
                            currentVehicle.flightModes[i] === "Land" || currentVehicle.flightModes[i] === "Position Hold" ||
                            currentVehicle.flightModes[i] === "Brake" || currentVehicle.flightModes[i] === "Smart RTL" ||
                            currentVehicle.flightModes[i] === "Drift" || currentVehicle.flightModes[i] === "Guided"||
                            currentVehicle.flightModes[i] === "Acro") {
                        flightModesMenuItems.push(menuItem)
                        flightModesMenu.insertItem(i, menuItem)
                    }
                }
                else if (accessType == "Factory") {
                    flightModesMenuItems.push(menuItem)
                    flightModesMenu.insertItem(i, menuItem)
                }
                else{
                    console.log(accessType)
                }
            }
        }
    }


    Component.onCompleted: {
        _root.updateFlightModesMenu()
    }
    //Menu.onCompleted: _root.updateFlightModesMenu()

    Connections {
        target:                 QGroundControl.multiVehicleManager
        onActiveVehicleChanged: _root.updateFlightModesMenu()
    }

    MouseArea {
        id:                 mouseArea
        visible:            currentVehicle && currentVehicle.flightModeSetAvailable
        anchors.leftMargin: mouseAreaLeftMargin
        anchors.fill:       parent
        onClicked: {
            //CustomCorePlugin.setAccessType("Expert")
            //_root.updateFlightModesMenu()
//            if (currentVehicle && currentVehicle.flightModeSetAvailable) {
//                var i;
//                for (i = 0; i < flightModesMenuItems.length; i++) {
//                    flightModesMenu.removeItem(flightModesMenuItems[i])
//                }
//                flightModesMenuItems.length = 0
//                for (i = 0; i < currentVehicle.flightModes.length; i++) {
//                    var menuItem = flightModeMenuItemComponent.createObject(null, { "text": currentVehicle.flightModes[i] })
//                    if (accessType == "Basic") {
//                        if (currentVehicle.flightModes[i] === "Stabilize" || currentVehicle.flightModes[i] === "Altitude Hold" ||
//                                currentVehicle.flightModes[i] === "Auto" || currentVehicle.flightModes[i] === "Loiter" ||
//                                currentVehicle.flightModes[i] === "RTL" || currentVehicle.flightModes[i] === "Circle" ||
//                                currentVehicle.flightModes[i] === "Land" || currentVehicle.flightModes[i] === "Position Hold" ||
//                                currentVehicle.flightModes[i] === "Brake" || currentVehicle.flightModes[i] === "Smart RTL") {
//                            flightModesMenuItems.push(menuItem)
//                            flightModesMenu.insertItem(i, menuItem)
//                            flightModesMenu.popup((_root.width - flightModesMenu.width) / 2, _root.height)

//                        }
//                    }
//                    else if (accessType == "Expert") {
//                        if (currentVehicle.flightModes[i] === "Stabilize" || currentVehicle.flightModes[i] === "Altitude Hold" ||
//                                currentVehicle.flightModes[i] === "Auto" || currentVehicle.flightModes[i] === "Loiter" ||
//                                currentVehicle.flightModes[i] === "RTL" || currentVehicle.flightModes[i] === "Circle" ||
//                                currentVehicle.flightModes[i] === "Land" || currentVehicle.flightModes[i] === "Position Hold" ||
//                                currentVehicle.flightModes[i] === "Brake" || currentVehicle.flightModes[i] === "Smart RTL" ||
//                                currentVehicle.flightModes[i] === "Drift" || currentVehicle.flightModes[i] === "Guided"||
//                                currentVehicle.flightModes[i] === "Acro") {
//                            flightModesMenuItems.push(menuItem)
//                            flightModesMenu.insertItem(i, menuItem)
//                            flightModesMenu.popup((_root.width - flightModesMenu.width) / 2, _root.height)

//                        }
//                    }
//                    else if (accessType == "Factory") {
//                        flightModesMenuItems.push(menuItem)
//                        flightModesMenu.insertItem(i, menuItem)
//                        flightModesMenu.popup((_root.width - flightModesMenu.width) / 2, _root.height)

//                    }
//                }
//            }
            //accessType = CustomCorePlugin.getAccessType()

            flightModesMenu.popup((_root.width - flightModesMenu.width) / 2, _root.height)

        }
    }
}
