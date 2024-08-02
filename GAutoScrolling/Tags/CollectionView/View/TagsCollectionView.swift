//
//  TagsCollectionView.swift
//  TagsFlowLayout
//
//  Created by Alexander Rubtsov on 13.06.2022.
//

import UIKit

protocol TagsCollectionViewDelegate: AnyObject {
    func tagSelected()
    func categoryTypeChanged()
}

struct Tag {
    let name: String
}

class TagsCollectionView: UICollectionView {

    // MARK: - Properties

    var tags: [Tag] = [] {
        didSet {
            reloadData()
        }
    }

    weak var tagsViewdelegate: TagsCollectionViewDelegate?

    private let tagCell = TagCell()

    init() {
        let layout = HorizontalTagsFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)

        super.init(frame: .zero, collectionViewLayout: layout)

        register(TagCell.self, forCellWithReuseIdentifier: "cell")

        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false

        delegate = self
        dataSource = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TagsCollectionView: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? TagCell else {
            return UICollectionViewCell()
        }

        let categoryTag = tags[indexPath.item]
        cell.configure(with: categoryTag)

        return cell
    }
}

extension TagsCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("cell \(indexPath.item) tapped")
    }
}

extension TagsCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        tagCell.configure(with: tags[indexPath.item])
        return CGSize(width: tagCell.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).width, height: 32.0)
    }
}

