//
//  TagCell.swift
//  TagsFlowLayout
//
//  Created by Alexander Rubtsov on 13.06.2022.
//

import UIKit

class TagCell: UICollectionViewCell {

    // MARK: - Private properties

    private var label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.backgroundColor = .systemGray5
        contentView.layer.cornerRadius = 16
        contentView.layer.borderColor = UIColor.systemGray3.cgColor
        contentView.layer.borderWidth = 1

        contentView.addSubview(label)

        label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6).isActive = true
        label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6).isActive = true
        label.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        label.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16).isActive = true

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with categoryModel: Tag) {
        label.text = categoryModel.name
    }
}

