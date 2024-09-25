//
//  HeadlineNewsCell.swift
//  News
//
//  Created by Omar Mohamed on 29/12/2023.
//

import UIKit

class HeadlineNewsCell: UITableViewCell {

    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsDescription: UILabel!
    
    var headlineListCellViewModel: NewsCellViewModel? {
        didSet {
            newsTitle.text = headlineListCellViewModel?.title
            newsDescription.text = headlineListCellViewModel?.description
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
