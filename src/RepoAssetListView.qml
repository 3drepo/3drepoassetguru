/**
*  Copyright (C) 2017 3D Repo Ltd
*
*  This program is free software: you can redistribute it and/or modify
*  it under the terms of the GNU Affero General Public License as
*  published by the Free Software Foundation, either version 3 of the
*  License, or (at your option) any later version.
*
*  This program is distributed in the hope that it will be useful,
*  but WITHOUT ANY WARRANTY; without even the implied warranty of
*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*  GNU Affero General Public License for more details.
*
*  You should have received a copy of the GNU Affero General Public License
*  along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.0

import repo 1.0

ListView {
    id: assetListView
    focus: true
    currentIndex: -1
    snapMode: ListView.SnapToItem

    header: Rectangle {
        width: assetListView.width
        height: 64
        color: "white"
        z: 2

        CheckBox {
            id: headerCheckBox
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 10
            onCheckedChanged: {
                console.log(assetListView.visible)
            }
        }

        TextField {
            id: searchField
            placeholderText: qsTr("Search assets")
            anchors.verticalCenter : parent.verticalCenter
            anchors.left: headerCheckBox.right
            anchors.right: searchButton.left
            topPadding: 20
            leftPadding: 10
            rightPadding: 10
            focus: true
            background: Rectangle {
                color: "transparent"
                border.width: 0
            }
            onTextChanged: {
                filterTagCode(text)
            }
        }

        ToolButton {
            id: searchButton
            anchors.right: parent.right
            anchors.verticalCenter : parent.verticalCenter
            anchors.rightMargin: 0
            implicitWidth: 84
            implicitHeight: 84
            contentItem: Image {
                Material.theme: Material.Dark
                fillMode: Image.Pad
                horizontalAlignment: Image.AlignHCenter
                verticalAlignment: Image.AlignVCenter
                source: searchField.text.length > 0 ? "image://materialicons/clear/#FF757575" : "image://materialicons/search/#FF757575"
                sourceSize.width: 32
                sourceSize.height: 32
            }
            onClicked: {
                if (searchField.text.length > 0)
                    searchField.clear()
            }
        }

        Rectangle {
            implicitHeight: 1
            color: "#ddd"
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
        }
    }
    headerPositioning: ListView.OverlayHeader // ListView.PullBackHeader


    footer: Rectangle {
        width: assetListView.width
        height: 84
        color: "transparent"
        z: 2

        RoundButton {
            id: createButton
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.margins: 10
            Material.background: Material.accent
            Material.theme: Material.Light
            width: 74
            height: width
            contentItem: Image {
                fillMode: Image.Pad
                horizontalAlignment: Image.AlignHCenter
                verticalAlignment: Image.AlignVCenter
                source:  "image://materialicons/add"
                sourceSize.width: 32
                sourceSize.height: 32
            }
        }
    }
    footerPositioning: ListView.OverlayFooter // ListView.PullBackHeader

    model: RepoAssetFilterableModel {
        id: assetModel
    }

    delegate: RepoAssetListDelegate {
        highlighted: ListView.isCurrentItem
        onClicked: {
            assetListView.currentIndex = index
        }
    }

    ScrollIndicator.vertical: ScrollIndicator {}

    function filterGroup(group) {
        assetModel.filterGroup(group)
    }

    function filterTagCode(tagCode) {
        assetModel.filterTagCode(tagCode)
    }
}
