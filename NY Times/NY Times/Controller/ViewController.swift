//
//  ViewController.swift
//  NY Times
//
//  Created by Ghulam Murtaza on 11/07/2024.
//

import UIKit

class ViewController: BaseViewController {
    
    //MARK: - IBOUTLETS
    @IBOutlet weak var kTableView: UITableView!
    
    //MARK: - VARITABLES
    var results: [ResultData]? {
        didSet {
            DispatchQueue.main.async {
                self.kTableView.reloadData()
            }
        }
    }
}

//MARK: - LIFE CYCLE
extension ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        getMostPoularArticals()
    }
}


//MARK: - PRIVATE FUNCTION
extension ViewController {
    private func registerCell(){
        /*self.kTableView.register(UINib(nibName: "HomeCell",
         bundle: nil),forCellReuseIdentifier: "HomeCell")*/
        self.kTableView.register(cellType: ArticalCell.self)
    }
}


//MARK: - TABLEVIEW DELEGATE & DATASOURCE
extension ViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ArticalCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        if let object = self.results?[indexPath.row] {
            cell.bind(model: object)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let object = self.results?[indexPath.row] {
            //let detailsVC = main
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DetailsVC") as? DetailsVC
            vc?.results = object
            self.navigationController?.pushViewController(vc!, animated: true)
            
        }
    }
}

//MARK: - APIS
extension ViewController {
    func getMostPoularArticals()  {
        let parameterManager = ParameterManager(url: Constants.EndPoints.ARTICALS, body: nil, method: .get)
        apiHander.request(modelType: MostPopularModel.self, type: parameterManager) { [weak self] response in
            guard let storngSelf = self else { return }
            switch response {
            case .success(let products):
                storngSelf.results = products.results
            case .failure(let error):
                //print("error \(error.localizedDescription)")
                storngSelf.showAlert(title: ConstantsManager.Text.ErrorAlertTitle, message: error.localizedDescription, btnTitle: ConstantsManager.Text.OkAlertTitle)
            }
        }
    }
}
