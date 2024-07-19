//
//  BaseViewController.swift
//  NY Times
//
//  Created by Ghulam Murtaza on 12/07/2024.
//

import UIKit

class BaseViewController: UIViewController {

    var apiHander:APIManagerInterface
    init(apiHander: APIManagerInterface) {
        self.apiHander = apiHander
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.apiHander = APIManager()
        super.init(coder: coder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

//MARK: - IBActions
extension BaseViewController {
    @IBAction func pop(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}


//MARK: - BaseViewController
extension BaseViewController {
    func showAlert(title: String, message: String, btnTitle: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: btnTitle, style: .default) { (action) in
        }
        alertController.addAction(alertAction)
        DispatchQueue.main.async {
            self.present(alertController, animated: true)
        }
        
        //NavigationManager().navigationController().present(alertController, animated: true)
    }
}
