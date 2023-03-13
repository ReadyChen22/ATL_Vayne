//
//  ListVC.swift
//  atl_vayne_ready
//
//  Created by BruceAppRD on 2023/3/12.
//

import UIKit

class ListVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    let viewModel = ListVCViewModel()
    
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
        bindViewModel()
        viewModel.prepareRequest()
    }
    
    func initView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        refreshControl = UIRefreshControl()
        tableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(actRefresh), for: UIControl.Event.valueChanged)
    }
        
    func bindViewModel() {
        viewModel.onRequestEnd = { [weak self] in
            // 延遲個一秒。體感比較好
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                self?.refreshControl.endRefreshing()
                self?.tableView.reloadData()
            }
        }
    }
    
    // MARK: - action
    @IBAction func actTop(_ sender: Any) {
        if viewModel.listCellViewModels.count > 0 {
            let indexPath = IndexPath(row: 0, section: 0)
            tableView.scrollToRow(at: indexPath, at: .top, animated: false)
        }
    }
    
    // MARK: - pullDown
    var bBlockScrollTriggerAPI = false
    func pullDownReloadApi() {
        bBlockScrollTriggerAPI = true
        
        if viewModel.listCellViewModels.count > 0 {
            // 存在至少一筆，那就捲到頂
            let indexPath = IndexPath(row: 0, section: 0)
            tableView.scrollToRow(at: indexPath, at: .top, animated: false)
        }
        
        // showRefreshLoader
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            self.tableView.setContentOffset(CGPoint(x: 0, y: self.tableView.contentOffset.y - (self.refreshControl.frame.size.height)), animated: true)
            self.refreshControl.beginRefreshing()
            self.refreshControl.sendActions(for: .valueChanged) // 透過 sendAction 它，.valueChanged 會去推 actRefresh
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.bBlockScrollTriggerAPI = false
        }
    }
    
    @objc func actRefresh(){
        viewModel.prepareRequest()
    }
}

// MARK: - UITableViewDelegate
extension ListVC : UITableViewDelegate, UITableViewDataSource {
    
    // apearance
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
    // data
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.listCellViewModels.count
    }
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let each = viewModel.listCellViewModels[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! ListCell
        cell.setUp(viewModel: each)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let each = viewModel.listCellViewModels[indexPath.row]
        let sb = UIStoryboard(name: "Main", bundle: nil)
        if let vc = sb.instantiateViewController(withIdentifier :"DetailVC") as? DetailVC {
            vc.login = each.login
            self.present(vc, animated: true, completion: nil)
        }
    }
}
