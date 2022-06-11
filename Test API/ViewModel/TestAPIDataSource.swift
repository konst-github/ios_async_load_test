//
//  TestAPIDataSource.swift
//  Test API
//

import UIKit

class TestAPIDataSource : NSObject {

	var data: [Row<BaseObject>] = []

	fileprivate var tableCellId: String?

	init(tableCellId: String) {
		super.init()
		self.tableCellId = tableCellId
	}
}

extension TestAPIDataSource : UITableViewDataSource {

	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return data.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		let cell = tableView.dequeueReusableCell(withIdentifier: tableCellId ?? "", for: indexPath) as! TableViewCell

		/// Using tuple here to release TableViewCell from dependency from BaseObject objects
		/// and make it be aware only about Foundation/UIKit types
		let tuple = data[indexPath.row].tuple()
		cell.update(title: tuple?.title,
					subtitle: tuple?.subtitle,
					image: tuple?.image
		)
		return cell
	}
}
