//
//  Constants.swift
//  NY Times
//
//  Created by Ghulam Murtaza on 11/07/2024.
//

import Foundation
struct Constants {
    struct KYES {
        
        static let APIKEYNYTIMES = "APIKEYNYTIMES"
        static let BASEURL = "BASEURL"
        
        // Get the BASE_URL
        static let API_KEY_NY_TIMES: String = {
            guard let baseURLProperty = Bundle.main.object(
                forInfoDictionaryKey: KYES.APIKEYNYTIMES
            ) as? String else {
                fatalError("BASE_URL not found")
            }
            return baseURLProperty
        }()   
    }
    
    struct ProductionServer {
        //static let baseURL   = "https://api.nytimes.com"
        static let baseURL:String = {
            guard let baseURLProperty = Bundle.main.object(
                forInfoDictionaryKey: KYES.BASEURL
            ) as? String else {
                fatalError("BASE_URL not found")
            }
            return baseURLProperty
        }()
    }
    
    struct EndPoints {
        //MARK: - MOST POPULAR
        static let ARTICALS = "https://\(Constants.ProductionServer.baseURL)/svc/mostpopular/v2/mostviewed/all-sections/7.json?api-key=\(Constants.KYES.API_KEY_NY_TIMES)"
        
    }
}


class ConstantsManager {
    enum Text{
        static let ErrorAlertTitle = "Error"
        static let OkAlertTitle = "Ok"
        static let CancelAlertTitle = "Cancel"
        static let NA   = "N/A"
    }
}
