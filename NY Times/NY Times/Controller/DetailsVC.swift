//
//  DetailsVC.swift
//  NY Times
//
//  Created by Ghulam Murtaza on 18/07/2024.
//

import UIKit

class DetailsVC: BaseViewController {
    
    // MARK: - IBOUTLETS
     @IBOutlet private weak var _title:UILabel!
     @IBOutlet private weak var kTableView: UITableView!
    
    // MARK: - VARIABLES
    var results: ResultData? {
        didSet {
            DispatchQueue.main.async {
                self._title.text = self.results?.title
            }
        }
    }
}



// MARK: - LIFE CYELE
extension DetailsVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
    }
}


// MARK: - PRIVATE FUNCTIONS
extension DetailsVC {
    private func registerCell(){
        /*self.kTableView.register(UINib(nibName: "HomeCell",
         bundle: nil),forCellReuseIdentifier: "HomeCell")*/
        self.kTableView.register(cellType: ArticalDetailCell.self)
    }
}
//MARK: - TABLEVIEW DELEGATE & DATASOURCE
extension DetailsVC:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ArticalDetailCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        //if let object = self.results?[indexPath.row] {
        cell.bind(model: self.results ?? ResultData())
        //}
        return cell
    }
}
