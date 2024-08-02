//
//  TagsFlowLayout.swift
//  TagsFlowLayout
//
//  Created by Alexander Rubtsov on 13.06.2022.
//

import UIKit

class HorizontalTagsFlowLayout: UICollectionViewFlowLayout {

    // MARK: - Properties

    override var collectionViewContentSize: CGSize {
        return contentSize
    }

    // MARK: - Private properties

    private var layoutAttributesCache: [UICollectionViewLayoutAttributes] = []
    private var contentSize: CGSize = CGSize.zero

    // MARK: - Functions

    override func prepare() {
        super.prepare()

        guard let collectionView = collectionView else {
            return
        }

        layoutAttributesCache = layoutAttributes()

        let itemHeight = layoutAttributesCache.first?.frame.height ?? 0.0
        let freeSpace = collectionView.frame.size.height - sectionInset.top + sectionInset.bottom
        let rowsCount = Int(freeSpace / itemHeight)
        var rowFrames = rowFrames(with: rowsCount, itemHeight: itemHeight)

        for attributes in layoutAttributesCache {
            var minimalRowFrame = rowFrames.first ?? .zero
            var minimalRowIndex = 0

            for (index, rowFrame) in rowFrames.enumerated() {
                if rowFrame.maxX < minimalRowFrame.maxX {
                    minimalRowFrame = rowFrame
                    minimalRowIndex = index
                }
            }

            attributes.frame.origin = CGPoint(x: minimalRowFrame.maxX, y: minimalRowFrame.minY)

            rowFrames[minimalRowIndex] = CGRect(x: minimalRowFrame.minX,
                                                y: minimalRowFrame.minY,
                                                width: minimalRowFrame.width + attributes.frame.width + minimumInteritemSpacing,
                                                height: minimalRowFrame.height)
        }

        var maximumContentWidth: CGFloat = 0.0
        for rowFrame in rowFrames {
            if rowFrame.maxX > maximumContentWidth {
                maximumContentWidth = rowFrame.maxX
            }
        }

        contentSize = CGSize(width: maximumContentWidth, height: collectionView.frame.size.height)
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return layoutAttributesCache.filter {
            return $0.frame.intersects(rect)
        }
    }

    override open func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return layoutAttributesCache[indexPath.item]
    }

    // MARK: - Private functions

    private func rowFrames(with count: Int, itemHeight: CGFloat) -> [CGRect] {
        var rowFrames: [CGRect] = []
        for index in 0..<count {
            let rect = CGRect(x: sectionInset.left,
                              y: (itemHeight * CGFloat(index)) + (minimumLineSpacing * CGFloat(index)) + sectionInset.top,
                              width: 0.0,
                              height: itemHeight + minimumLineSpacing)
            rowFrames.append(rect)
        }

        return rowFrames
    }

    private func layoutAttributes() -> [UICollectionViewLayoutAttributes] {
        var allAttributes: [UICollectionViewLayoutAttributes] = []

        guard let collectionView = collectionView,
              let delegate = collectionView.delegate as? UICollectionViewDelegateFlowLayout,
              collectionView.numberOfSections > 0 else {
            return allAttributes
        }

        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            let itemSize = delegate.collectionView?(collectionView, layout: self, sizeForItemAt: indexPath) ?? .zero
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = CGRect(x: 0.0, y: 0.0, width: itemSize.width, height: itemSize.height)
            attributes.zIndex = item
            allAttributes.append(attributes)
        }

        return allAttributes
    }
}

