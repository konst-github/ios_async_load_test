//
//  TestAPIRow.swift
//  Test API
//

import UIKit

struct Row<T: RowMappable> {
	var object: T
	func tuple() -> RowTuple? { return (object.title, object.subtitle, object.image) }
}

typealias RowTuple = (title: String?, subtitle: String?, image: UIImage?)
