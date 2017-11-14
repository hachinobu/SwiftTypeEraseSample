//
//  ViewController.swift
//  SwiftTypeEraseSample
//
//  Created by Takahiro Nishinobu on 2017/11/14.
//  Copyright © 2017年 hachinobu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func tappedAllItemListButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "ItemListTableViewController") as! ItemListTableViewController
        view.title = "全投稿"
        let request = QiitaAPI.GetItemsRequest(page: 1, perPage: 20)
        let typeEraseRequest = TypeEraseQiitaRequest(request: request)
        view.request = typeEraseRequest
        navigationController?.pushViewController(view, animated: true)
    }
    
    @IBAction func tappedUserItemListButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "ItemListTableViewController") as! ItemListTableViewController
        view.title = "ユーザー投稿"
        let request = QiitaAPI.GetUserItemsRequest(userId: "hachinobu", page: 1, perPage: 20)
        let typeEraseRequest = TypeEraseQiitaRequest(request: request)
        view.request = typeEraseRequest
        navigationController?.pushViewController(view, animated: true)
    }
    
}

