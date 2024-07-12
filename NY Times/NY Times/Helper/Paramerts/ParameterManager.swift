//
//  ParameterManager.swift
//  NY Times
//
//  Created by Ghulam Murtaza on 12/07/2024.
//

import Foundation
import UIKit

struct ParameterManager {
    var url: String = ""
    var params: [String : Any]?
    var body: Encodable?
    var headers: [String : String]?
    var method: HTTPMethods
    var images: [UIImage]?
    var imageKey: String = ""
    init(url:String,
         body: Encodable?,
         params: [String : Any]? = [:],
         headers: [String : String]? = [:],
         method: HTTPMethods,
         images: [UIImage]? = nil,
         imageKey: String = "image") {
        
        
        self.url = url
        self.params = params
        self.headers = headers
        self.method = method
        self.images = images
        self.imageKey = imageKey
        self.body = body
    }
}
