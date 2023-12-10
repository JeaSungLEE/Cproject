//
//  HomeThemeHeaderCollectionReusableView.swift
//  Cproject
//
//  Created by jercy on 12/2/23.
//

import UIKit

struct HomeThemeHeaderCollectionReusableViewModel {
    var headerText: String
}

final class HomeThemeHeaderCollectionReusableView: UICollectionReusableView {
    static let reusableId: String = "HomeThemeHeaderCollectionReusableView"
    @IBOutlet weak var themeHeaderLabel: UILabel!
    
    func setViewModel(_ viewModel: HomeThemeHeaderCollectionReusableViewModel) {
        themeHeaderLabel.text = viewModel.headerText
    }
}
