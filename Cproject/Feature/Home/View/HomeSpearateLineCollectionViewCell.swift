//
//  HomeSpearateLineCollectionViewCell.swift
//  Cproject
//
//  Created by jercy on 12/2/23.
//

import UIKit

struct HomeSpearateLineCollectionViewCellViewModel: Hashable {
}

final class HomeSpearateLineCollectionViewCell: UICollectionViewCell {
    static let reusableId: String = "HomeSpearateLineCollectionViewCell"
    func setViewModel(_ viewModel: HomeSpearateLineCollectionViewCellViewModel) {
        contentView.backgroundColor = CPColor.UIKit.gray1
    }
}

extension HomeSpearateLineCollectionViewCell {
    static func separateLineLayout() -> NSCollectionLayoutSection {
        let itemSize: NSCollectionLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item: NSCollectionLayoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize: NSCollectionLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(11))
        let group: NSCollectionLayoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section: NSCollectionLayoutSection = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        section.contentInsets = .init(top: 20, leading: 0, bottom: 0, trailing: 0)
        return section
    }
}
