//
//  StretchyHeader.swift
//  iOS-Sample-App
//
//  Created by Rith on 27/9/21.
//

import Foundation
import UIKit
final class StretchyHeader: UIView {
    
    var imageViewHeight = NSLayoutConstraint()
    var imageViewButtom = NSLayoutConstraint()
    var constainerView = UIView()
    var constainerViewHeight = NSLayoutConstraint()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createViews()
        setViewConstraints()
    }
    
    let imageView: UIImageView = {
        let img = UIImageView()
        img.clipsToBounds = true
        img.contentMode = .scaleAspectFill
        img.layer.cornerRadius = 30
       // img.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        return img
    }()
    
    func createViews() {
        addSubview(constainerView)
        constainerView.addSubview(imageView)
    }
    
    func setViewConstraints() {
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalTo: constainerView.widthAnchor),
            centerYAnchor.constraint(equalTo: constainerView.centerYAnchor),
            heightAnchor.constraint(equalTo: constainerView.heightAnchor)
        ])
        constainerView.translatesAutoresizingMaskIntoConstraints = false
        constainerView.widthAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
        constainerViewHeight = constainerView.heightAnchor.constraint(equalTo: self.heightAnchor)
        constainerViewHeight.isActive = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageViewButtom = imageView.bottomAnchor.constraint(equalTo: constainerView.bottomAnchor)
        imageViewButtom.isActive = true
        imageViewHeight = imageView.heightAnchor.constraint(equalTo: constainerView.heightAnchor)
        imageViewHeight.isActive = true
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        constainerViewHeight.constant = scrollView.contentInset.top
        let offsetY = -(scrollView.contentOffset.y + scrollView.contentInset.top)
        constainerView.clipsToBounds = offsetY <= 0
        imageViewButtom.constant = offsetY >= 0 ? 0 : -offsetY / 2
        imageViewHeight.constant = max(offsetY + scrollView.contentInset.top, scrollView.contentInset.top)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
