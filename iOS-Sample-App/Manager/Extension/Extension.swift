//
//  Extension.swift
//  iOS-Sample-App
//
//  Created by Rith on 27/9/21.
//

import Foundation
import UIKit

extension String {
    
    func localized(str: String) -> String {
        let path = Bundle.main.path(forResource: str, ofType: "lproj")
        let bundle = Bundle(path: path!)
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
    
    func isValidEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
    
    func getAlphaNumericValue() -> String{

      //  var yourString  = "123456789!@#$%^&*()AnyThingYouWant"

        let unsafeChars = CharacterSet.alphanumerics.inverted  // Remove the .inverted to get the opposite result.

        let data  = self.components(separatedBy: unsafeChars).joined(separator: "")

        return data
    }
    
    func strikeThrough() -> NSAttributedString {
        let attributeString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(
            NSAttributedString.Key.strikethroughStyle,
            value: NSUnderlineStyle.single.rawValue,
            range:NSMakeRange(0,attributeString.length))
        return attributeString
    }
    
    func isValidPassword() -> Bool {
        let passwordRegex = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=!?])(?=\\S+$).{6,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self)
    }
    
    var trim: String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).filter { !"\t".contains($0) }
    }
}

extension DecodingError.Context {
    func showError(functionName: String) -> String {
        return String(format: "%@ \n %@ : %@", functionName, self.codingPath.last?.stringValue ?? "", self.debugDescription)
    }
}

extension Encodable {
    func json() -> Any? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try! encoder.encode(self)
        return data.toJSON()
    }
}

extension Data {
    func toJSON() -> Any? {
        return try? JSONSerialization.jsonObject(with: self, options: .mutableContainers)
    }
    
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}

extension Dictionary {
    var json: String {
        let invalidJson = "Not a valid JSON"
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            return String(bytes: jsonData, encoding: String.Encoding.utf8) ?? invalidJson
        } catch {
            return invalidJson
        }
    }
}

extension UserDefaults {
    
    public subscript(key: String) -> Any? {
        get {
            return object(forKey: key)
        }
        set {
            set(newValue, forKey: key)
        }
    }
    
    public func object<T: Codable>(_ type: T.Type, with key: String, usingDecoder decoder: JSONDecoder = JSONDecoder()) -> T? {
        guard let data = self.value(forKey: key) as? Data else { return nil }
        return try? decoder.decode(type.self, from: data)
    }
    
    public func save<T: Codable>(object: T, forKey key: String, usingEncoder encoder: JSONEncoder = JSONEncoder()) {
        let data = try? encoder.encode(object)
        self.set(data, forKey: key)
    }
}

extension UIColor {
    
    static let mainColor = UIColor(hexString: "#E3B32F")
    static let backgroundColor = UIColor(hexString: "#E9F3FE")
    static let colorText  = UIColor(hexString: "#484848")
    static let colorIcon = UIColor(hexString: "#8C8B8B")
    static let colorHint = UIColor(hexString: "#AFADAD")
    static let colorLightBG = UIColor(hexString: "#EEEEEE")
    static let whiteBlur = UIColor(hexString: "#F6F6F6")
    
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

extension UITextField {
    
    func addLeftView(width: CGFloat, height: CGFloat) {
        let lefView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        self.leftView = lefView
        self.leftViewMode = .always
    }
    
    func addRightView(width: CGFloat, height: CGFloat) {
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        self.rightView = rightView
        self.rightViewMode = .always
    }
}

extension UIImageView {
  func setImageColor(color: UIColor) {
    let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
    self.image = templateImage
    self.tintColor = color
  }
}

extension UIButton {
    func setImageColor(imageName: String,color: UIColor) {
        let origImage = UIImage(named: imageName)
        self.setImage(origImage, for: .normal)
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        self.setImage(tintedImage, for: .normal)
        self.tintColor = color
    }
}

extension UIView {
    
    func shakeView() {
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.05
        shake.repeatCount = 2
        shake.autoreverses = true
        
        let fromPoint = CGPoint(x: center.x - 5, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        
        let toPoint = CGPoint(x: center.x + 5, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)
        
        shake.fromValue = fromValue
        shake.toValue = toValue
        
        layer.add(shake, forKey: "position")
    }
}

extension UIApplication {
    
    class func getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {

        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)

        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)

        } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
}

extension UIViewController {
    var className: String {
        NSStringFromClass(self.classForCoder).components(separatedBy: ".").last!
    }
}

extension UITableView {
    
    func scrollToBottom(){
        DispatchQueue.main.async {
            let indexPath = IndexPath(
                row: self.numberOfRows(inSection:
                     self.numberOfSections-1) - 1,
                section: self.numberOfSections - 1)
            if self.hasRowAtIndexPath(indexPath: indexPath) {
                self.scrollToRow(at: indexPath, at: .bottom, animated: true)
            }
        }
    }

    func scrollToTop() {
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: 0, section: 0)
            if self.hasRowAtIndexPath(indexPath: indexPath) {
            self.scrollToRow(at: indexPath, at: .top, animated: false)
            }
        }
    }

    func hasRowAtIndexPath(indexPath: IndexPath) -> Bool {
        return indexPath.section < self.numberOfSections && indexPath.row < self.numberOfRows(inSection: indexPath.section)
    }
}

extension Date {
    func addMinute(minutes: Double) -> Date {
         return addingTimeInterval(minutes * 60)
    }
    
    func addHours(hours: Double) -> Date {
        return addMinute(minutes: hours * 60)
    }
}
