//
//  Utilize.swift
//  iOS-Sample-App
//
//  Created by Rith on 27/9/21.
//

import Foundation
import UIKit

class AlertMessage {
    
    static let shared = AlertMessage()
    
    func showSuccess(message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Sucess", message: message, preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default) { (act) in
                alert.dismiss(animated: true, completion: nil)
            }
            alert.addAction(ok)
            let app = UIApplication.shared.delegate as! AppDelegate
            app.window?.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }
   
    func showAlert(message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default) { (act) in
                alert.dismiss(animated: true, completion: nil)
            }
            alert.addAction(ok)
            let app = UIApplication.shared.delegate as! AppDelegate
            app.window?.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }
}

class Loading {
    static let shared = Loading()
    var isLoading: Bool = false
    let loadingView: UIActivityIndicatorView = {
        let loading = UIActivityIndicatorView()
        loading.color = .white
        loading.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        return loading
      
    }()

    func showLoading() {
        DispatchQueue.main.async {
            let window = UIApplication.shared.keyWindow
            self.loadingView.translatesAutoresizingMaskIntoConstraints = false
            window?.addSubview(self.loadingView)
            self.loadingView.widthAnchor.constraint(equalTo: window!.widthAnchor).isActive = true
            self.loadingView.heightAnchor.constraint(equalTo: window!.heightAnchor).isActive = true
            self.loadingView.centerYAnchor.constraint(equalTo: window!.centerYAnchor).isActive = true
            self.loadingView.centerXAnchor.constraint(equalTo: window!.centerXAnchor).isActive = true
            self.loadingView.startAnimating()
            self.isLoading = true
        }
    }

    func hideLoading() {
        DispatchQueue.main.async {
            self.loadingView.stopAnimating()
            self.isLoading = false
        }
    }
}

class Validator {
    static func validateModel<T: Codable>(model: T, data: Data, fun: String, response: (T)->()) {
        do {
            let json = try JSONDecoder().decode(T.self, from: data)
            response(json)
        } catch let DecodingError.typeMismatch(type, context) {
            print(type)
            AlertMessage.shared.showAlert(message: context.showError(functionName: fun))
        } catch {
            print("error: ", error)
            AlertMessage.shared.showAlert(message: error.localizedDescription)
        }
    }
}

struct DeviceInformation {
    // Detect Device
    static let Timestamp: Double = NSDate().timeIntervalSince1970
    //static let Device_Type = UIDevice.current.modelName
    static let Device_Version = UIDevice.current.systemVersion
    static let Device_Id = UIDevice.current.identifierForVendor?.uuidString
    static let Device_OS = "IOS"
    static let Device_Serial = UIDevice.current.identifierForVendor
    //static let systemVersion = ProcessInfo.processInfo.operatingSystemVersion
}
