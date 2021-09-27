//
//  ContentSizedCollectionView.swift
//  iOS-Sample-App
//
//  Created by Rith on 27/9/21.
//

import Foundation
import UIKit

class ContentSizedCollectionView: UICollectionView {
    override var contentSize:CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: collectionViewLayout.collectionViewContentSize.height)
    }
}
