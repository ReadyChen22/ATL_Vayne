//
//  ListCell.swift
//  atl_vayne_ready
//
//  Created by BruceAppRD on 2023/3/13.
//

import UIKit
import Foundation

class ListCell: UITableViewCell {

    @IBOutlet var ivImg: UIImageView!
    @IBOutlet var lblLogin: UILabel!
    @IBOutlet var lblHtmlUrl: UILabel!
    @IBOutlet var lblMore: UILabel!
    
    private var viewModel: ListCellViewModel?
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setUp(viewModel: ListCellViewModel) {
        self.viewModel = viewModel
        self.lblLogin.text = viewModel.login
        self.lblHtmlUrl.text = viewModel.html_url
        self.lblMore.text = ToolBox.randomString(min: 100, max: 200)
        ToolBox.ivLoadUrl(iv: self.ivImg, url: viewModel.avatar_url, placeHolder: "iv_placeholder")
    }
}
