//
//  DataListNewVC.swift
//  Assignment
//
//  Created by Bhagyadhar Sahoo on 22/06/25.
//

import UIKit
import UIKit
import Foundation
import CoreData

final class DataListNewVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private var viewModel = DataListViewModel()
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        viewModel.onDataUpdate = { [weak self] in
            self?.tableView.reloadData()
        }
       
        viewModel.loadItems()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let item = viewModel.items[indexPath.row]
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = item.dataColor ?? "N/A"
        return cell
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let item = viewModel.items[indexPath.row]

        let delete = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
            self.viewModel.deleteItem(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
     
        let update = UIContextualAction(style: .normal, title: "Update") { _, _, _ in
            let alert = UIAlertController(title: "Edit", message: "Update item name", preferredStyle: .alert)
            alert.addTextField { $0.text = item.name }

            alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { _ in
                if let newName = alert.textFields?.first?.text, !newName.isEmpty {
                    self.viewModel.updateItem(at: indexPath.row, newName: newName)
                    tableView.reloadRows(at: [indexPath], with: .automatic)
                } else {
                    print("Validation: Name cannot be empty")
                }
            }))

            self.present(alert, animated: true)
        }

        return UISwipeActionsConfiguration(actions: [delete, update])
    }
}
