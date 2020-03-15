//
//  MapPinCalloutButton.swift
//  Touche-VIPER
//
//  Created by weyhan.
//  Copyright © 2020 eccentricdeveloper. All rights reserved.
//

import UIKit

enum MapPinCalloutButtonActionType {
    case remove
    case edit
}

class MapPinCalloutButton: UIButton {
    var action: MapPinCalloutButtonActionType?
}

