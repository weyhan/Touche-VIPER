//
//  NetworkInfo.swift
//  Touche-VIPER
//
//  Created by weyhan.
//  Copyright © 2020 eccentricdeveloper. All rights reserved.
//

import Foundation
import SystemConfiguration.CaptiveNetwork

typealias NetworkInfoType = [CFString: Any]

func getWiFiSsid() -> String? {
    var ssid: String?
    if let interfaceInfo = currentNetworkInfo() {
        ssid = interfaceInfo[kCNNetworkInfoKeySSID] as? String
    }

    return ssid
}

func currentNetworkInfo() -> NetworkInfoType? {
    var networkInfo: NetworkInfoType?
    if let interfaces = CNCopySupportedInterfaces() as Array? {
        for interface in interfaces {
            if let interfaceInfo = CNCopyCurrentNetworkInfo(interface as! CFString) as? NetworkInfoType {
                networkInfo = interfaceInfo
            }
        }
    }
    return networkInfo
}
