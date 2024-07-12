//
//  MostPopularViewModel.swift
//  NY Times
//
//  Created by Ghulam Murtaza on 11/07/2024.
//

import Foundation

class MostPopularViewModel
{
    var apiHander:APIManager
    init(apiHander: APIManager = APIManager()) {
        self.apiHander = apiHander
    }
    
    func getMostPoularArticals<T: Codable>(modelType: T.Type, type: ParameterManager,completion: @escaping ResultHandler<T>)  {
        
        let parameterManager = ParameterManager(url: Constants.EndPoints.ARTICALS, body: nil, method: .get)
        
        apiHander.request(modelType: MostPopularModel.self, type: parameterManager) { response in
            switch response {
            case .success(let products):
                print("products \(products.results?.count)")
                //self.products = products
                //self.eventHandler?(.dataLoaded)
            case .failure(let error):
                //self.eventHandler?(.error(error))
                print("error \(error.localizedDescription)")
            }
        }
        
        
        /*apiHander.request(
                   modelType: MostPopularModel.self,
                   type: ProductEndPoint.products) { response in
                       switch response {
                       case .success(let products):
                           self.products = products
                           self.eventHandler?(.dataLoaded)
                       case .failure(let error):
                           self.eventHandler?(.error(error))
                       }
                   }*/
    }
}
