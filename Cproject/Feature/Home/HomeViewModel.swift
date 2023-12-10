//
//  HomeViewModel.swift
//  Cproject
//
//  Created by jercy on 12/2/23.
//

import Combine
import Foundation

final class HomeViewModel {
    enum Action {
        case loadData
        case loadCoupon
        case getDataSuccess(HomeResponse)
        case getDataFailure(Error)
        case getCouponSuccess(Bool)
        case didTapCouponButton
    }
    final class State {
        struct CollectionViewModels {
            var bannerViewModels: [HomeBannerCollectionViewCellViewModel]?
            var horizontalProductViewModels: [HomeProductCollectionViewCellViewModel]?
            var verticalProductViewModels: [HomeProductCollectionViewCellViewModel]?
            var couponState: [HomeCouponButtonCollectionViewCellViewModel]?
            var separateLine1ViewModels: [HomeSpearateLineCollectionViewCellViewModel] = [HomeSpearateLineCollectionViewCellViewModel()]
            var separateLine2ViewModels: [HomeSpearateLineCollectionViewCellViewModel] = [HomeSpearateLineCollectionViewCellViewModel()]
            var themeViewModels: (headerViewModel: HomeThemeHeaderCollectionReusableViewModel, items: [HomeThemeCollectionViewCellViewModel])?
        }
        @Published var collectionViewModels: CollectionViewModels = CollectionViewModels()
    }
    private(set) var state: State = State()
    private var loadDataTask: Task<Void, Never>?
    private let couponDownloadedKey: String = "CouponDownloaded"
    
    func process(action: Action) {
        switch action {
        case .loadData:
            loadData()
        case .loadCoupon:
            loadCoupon()
        case let .getDataSuccess(response):
            transformResponses(response)
        case let .getDataFailure(error):
            print("network error: \(error)")
        case let .getCouponSuccess(isDownloded):
            Task { await transformCoupon(isDownloded) }
        case .didTapCouponButton:
            downloadCoupon()
        }
    }
    
    deinit {
        loadDataTask?.cancel()
    }
}

extension HomeViewModel {
    private func loadData() {
        loadDataTask = Task {
            do {
                let response = try await NetworkService.shared.getHomeData()
                process(action: .getDataSuccess(response))
            } catch {
                process(action: .getDataFailure(error))
            }
        }
    }
    
    private func loadCoupon() {
        let couponState: Bool = UserDefaults.standard.bool(forKey: couponDownloadedKey)
        process(action: .getCouponSuccess(couponState))
    }
    
    private func transformResponses(_ response: HomeResponse) {
        Task { await transformBanner(response) }
        Task { await transformHorizontalProduct(response) }
        Task { await transformVerticalProuct(response) }
        Task { await transformTheme(response) }
    }
    
    @MainActor
    private func transformBanner(_ response: HomeResponse) async {
        state.collectionViewModels.bannerViewModels = response.banners.map {
            HomeBannerCollectionViewCellViewModel(bannerImageUrl: $0.imageUrl)
        }
    }
    
    @MainActor
    private func transformHorizontalProduct(_ response: HomeResponse) async {
        state.collectionViewModels.horizontalProductViewModels = productToHomeProductCollectionViewCellViewModel(response.horizontalProducts)
    }
    
    @MainActor
    private func transformVerticalProuct(_ response: HomeResponse) async {
        state.collectionViewModels.verticalProductViewModels = productToHomeProductCollectionViewCellViewModel(response.verticalProducts)
    }
    
    @MainActor
    private func transformTheme(_ response: HomeResponse) async {
        let items = response.themes.map {
            HomeThemeCollectionViewCellViewModel(themeImageUrl: $0.imageUrl)
        }
        state.collectionViewModels.themeViewModels = (HomeThemeHeaderCollectionReusableViewModel(headerText: "테마관"), items)
    }
    
    private func productToHomeProductCollectionViewCellViewModel(_ product: [Product]) -> [HomeProductCollectionViewCellViewModel] {
        return product.map {
            HomeProductCollectionViewCellViewModel(imageUrlString: $0.imageUrl,
                                                   title: $0.title,
                                                   reasonDiscountString: $0.discount,
                                                   originalPrice: $0.originalPrice.moneyString,
                                                   discountPrice: $0.discountPrice.moneyString)
        }
    }
    
    @MainActor
    private func transformCoupon(_ isDownloded: Bool) async {
        state.collectionViewModels.couponState = [.init(state: isDownloded ? .disable : .enable)]
    }
    
    private func downloadCoupon() {
        UserDefaults.standard.setValue(true, forKey: couponDownloadedKey)
        process(action: .loadCoupon)
    }
}
