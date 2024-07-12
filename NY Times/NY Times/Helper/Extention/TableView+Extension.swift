//
//  TableView+Extension.swift
//  NY Times
//
//  Created by Ghulam Murtaza on 12/07/2024.
//

import Foundation
import UIKit

protocol ReusableCell {
    static var reuseIdentifier: String { get }
}

extension ReusableCell where Self: UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableView {
    
    func register<T: UITableViewCell & ReusableCell>(cellType: T.Type) {
        let nib = UINib(nibName: T.reuseIdentifier, bundle: nil)
        register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell & ReusableCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Failed to dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        cell.selectionStyle = .none
        
        return cell
    }
}
