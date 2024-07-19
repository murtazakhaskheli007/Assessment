//
//  ArticalDetailCell.swift
//  NY Times
//
//  Created by Ghulam Murtaza on 19/07/2024.
//

import UIKit

class ArticalDetailCell: UITableViewCell, ReusableCell {
    
    @IBOutlet weak var _thumb:CustomImageView!
    @IBOutlet weak var _author:UILabel!
    @IBOutlet weak var _section:UILabel!
    @IBOutlet weak var _title:UILabel!
    @IBOutlet weak var _subTitle:UILabel!
    @IBOutlet weak var _category:UILabel!
    @IBOutlet weak var _date:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bind(model:ResultData) {
        _title.text = model.title ?? ConstantsManager.Text.NA
        _subTitle.text = model.abstract ?? ConstantsManager.Text.NA
        _date.text = model.publishedDate ?? ConstantsManager.Text.NA
        _author.text = "\(model.byline ?? ConstantsManager.Text.NA)"
        _section.text = "\(model.section ?? ConstantsManager.Text.NA)"
        
        guard
            let media = model.media,
            let firstMedia = media.first,
            let mediaMetadata = firstMedia.mediaMetadata,
            let firstElement = mediaMetadata.first,
            let urlString = firstElement.url
            //let imageURL = URL(string: urlString)
        else {
            return
        }
        
        _thumb.downloadImageFrom(urlString: urlString)
    }
}
