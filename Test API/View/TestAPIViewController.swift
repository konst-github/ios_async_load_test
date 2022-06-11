//
//  TestAPIViewController.swift
//  Test API
//

import UIKit

class TestAPIViewController: UIViewController {

	@IBOutlet weak var tableView: UITableView!

	lazy var viewModel: TestAPIViewModel = {
		let vm = TestAPIViewModel()
		return vm
	}()

	override func viewDidLoad() {
		super.viewDidLoad()

		tableView.dataSource = viewModel.dataSource
		tableView.rowHeight = 80.0
		viewModel.fetchData() {
			DispatchQueue.main.async {
				self.tableView.reloadData()
			}
		}
	}
}
