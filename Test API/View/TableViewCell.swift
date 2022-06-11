//
//  TableViewCell.swift
//  Test API
//

import UIKit

class TableViewCell: UITableViewCell {

	@IBOutlet weak var labelTitle: UILabel!
	@IBOutlet weak var labelSubtitle: UILabel!
	@IBOutlet weak var iconView: UIImageView!
	@IBOutlet weak var spinnerView: UIActivityIndicatorView!

	public func update(title: String? , subtitle: String? , image: UIImage?) {
		self.labelTitle.text = title
		self.labelSubtitle.text = subtitle

		self.iconView.image = image

		let hasImage = image != nil
		self.spinnerView.isHidden = hasImage
		self.iconView.isHidden = !hasImage
		hasImage ? self.spinnerView.stopAnimating() : self.spinnerView.startAnimating()
	}
}
