//
//  ItemListTableViewController.swift
//  SwiftTypeEraseSample
//
//  Created by Takahiro Nishinobu on 2017/11/14.
//  Copyright © 2017年 hachinobu. All rights reserved.
//

import UIKit
import APIKit

class ItemListTableViewController: UITableViewController {

    var request: TypeEraseQiitaRequest<[ItemEntity]>!
    
    //Error: Protocol 'QiitaRequest' can only be used as a generic constraint because it has Self or associated type requirements.
//    var request: QiitaRequest!
    
    private var items: [ItemEntity]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        fetchItem()
    }
    
    private func fetchItem() {
        
        Session.send(request) { [weak self] result in
            switch result {
            case .success(let items):
                self?.items = items
            case .failure(let error):
                print(error)
            }
        }
        
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.text = items?[indexPath.row].title
        return cell
    }

}
