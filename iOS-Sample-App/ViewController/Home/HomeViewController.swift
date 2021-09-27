//
//  HomeViewController.swift
//  iOS-Sample-App
//
//  Created by Rith on 27/9/21.
//

import UIKit

class HomeViewController: UIViewController, GetPostDelegate {
    
    let homeVM = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        homeVM.delegate = self
        getList()
    }
    
    func getPostResult(data: [Post]) {
        print("data -->:", data.json() as Any)
    }
    
    func getList() {
        homeVM.getList()
    }
}
