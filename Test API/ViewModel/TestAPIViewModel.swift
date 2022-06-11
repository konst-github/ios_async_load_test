//
//  TestAPIViewModel.swift
//  Test API
//

import UIKit

class TestAPIViewModel {

	private lazy var apiService: TestAPIService = {
		let apiService = TestAPIService()
		return apiService
	}()

	lazy var dataSource: TestAPIDataSource = {
		let dataSource = TestAPIDataSource(tableCellId: "TableViewCell")
		return dataSource
	}()

	public func fetchData(completion: @escaping () -> Void) {
		apiService.fetchRemoteData() { objects in
			self.dataSource.data = objects
			self.fetchImages(completion: completion)
		}
	}

	private func fetchImages(completion: @escaping () -> Void) {

		// Just a qiuck solution, without Operations, Rx etc
		for item in dataSource.data {

			guard let path = item.object.path else { continue }

			DispatchQueue.global().async {
				guard let url = URL(string: path) else { return }
				guard let data = try? Data(contentsOf: url) else { return }

				guard let image = UIImage(data: data) else { return }
				item.object.image = image
				completion()
			}

		}

		completion()
	}
}
