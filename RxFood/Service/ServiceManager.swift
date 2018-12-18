//
//  ServiceManager.swift
//  RxFood
//
//  Created by Hira on 12/18/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import Foundation
import Alamofire

class ServiceManager: Alamofire.SessionManager {
    static let sharedManager: ServiceManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        configuration.timeoutIntervalForRequest = 20 // as seconds, you can set your request timeout
        configuration.timeoutIntervalForResource = 20 // as seconds, you can set your resource timeout
        configuration.requestCachePolicy = .useProtocolCachePolicy
        return ServiceManager(configuration: configuration)
    }()
}
