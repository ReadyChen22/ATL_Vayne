//
//  DetailVC.swift
//  atl_vayne_ready
//
//  Created by BruceAppRD on 2023/3/12.
//

import UIKit

class DetailVC: UIViewController {

    var login: String = ""
    
    @IBOutlet weak var ivImg: UIImageView!
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var lblLogin: UILabel!
    @IBOutlet weak var lblHtmlUrl: UILabel!
    
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblBlog: UILabel!
    @IBOutlet weak var lblAppendix: UILabel!

    let viewModel = DetailVCViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        bindViewModel()
        viewModel.prepareRequest(login: login)
    }
    
    func initView() {

    }
        
    func bindViewModel() {
        viewModel.onRequestEnd = { [weak self] user in
            DispatchQueue.main.async {
                ToolBox.ivLoadUrl(iv: self!.ivImg!, url: user.avatar_url, placeHolder: "iv_placeholder")
                self?.tfName.text = user.name
                self?.lblLogin.text = user.login
                self?.lblHtmlUrl.text = user.html_url
                
                self?.lblLocation.text = user.location
                self?.lblEmail.text = user.email
                self?.lblBlog.text = user.blog
                self?.lblAppendix.text = ToolBox.randomString(min: 200, max: 500)
            }
        }
    }

    @IBAction func actBack(_ sender: Any) {
        dismiss(animated: true)
    }
}

