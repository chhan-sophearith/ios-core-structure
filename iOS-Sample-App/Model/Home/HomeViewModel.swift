//
//  HomeViewModel.swift
//  iOS-Sample-App
//
//  Created by Rith on 27/9/21.
//

import Foundation

protocol GetPostDelegate {
    func getPostResult(data: [Post])
}

class HomeViewModel {
    
    var delegate: GetPostDelegate?
    
    func getList() {
        ApiManager.shared.getList { data in
            Validator.validateModel(model: [Post()].self, data: data, fun: "get List") { res in
                self.delegate?.getPostResult(data: res)
            }
        }
    }
}
