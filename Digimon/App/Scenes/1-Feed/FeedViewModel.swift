//
//  FeedViewModel.swift
//  Digimon
//
//  Created by Diggo Silva on 23/04/25.
//

import Foundation

enum FeedViewControllerStates {
    case loading
    case loaded
    case error
}

protocol FeedViewModelProtocol {
    func numberOfItemsInSection() -> Int
    func cellForItem(at indexPath: IndexPath) -> Digimon
    func fetchDigimons()
    func getDigimons() -> [Digimon]
    func observeState(_ observer: @escaping (FeedViewControllerStates) -> Void)
    func observeLoadingText(_ observer: @escaping (String) -> Void)
}

class FeedViewModel: FeedViewModelProtocol {
    private var state: Bindable<FeedViewControllerStates> = Bindable(value: .loading)
    
    private var loadingText: Bindable<String> = Bindable(value: "Carregando...")
    private var loadingTexts = ["Carregando", "Carregando.", "Carregando..", "Carregando..."]
    private var loadingTextsIndex = 0
    private var loadingTimer: Timer?
    
    private var digimons: [Digimon] = []
    private var page = 0
    private var isLoading = false
    private var hasMorePage = true
    
    private let service: ServiceProtocol
    
    init(service: ServiceProtocol = Service()) {
        self.service = service
    }
    
    func numberOfItemsInSection() -> Int {
        return digimons.count
    }
    
    func cellForItem(at indexPath: IndexPath) -> Digimon {
        return digimons[indexPath.item]
    }
    
    func fetchDigimons() {
        guard !isLoading, hasMorePage else { return }
        
        isLoading = true
        state.value = .loading
        startLoadingAnimation()
        
        self.service.getDigimons(page: page) { [weak self] result in
            guard let self = self else { return }
            isLoading = false
            
            switch result {
            case .success(let newDigimons):
                if newDigimons.isEmpty {
                    hasMorePage = false
                    return
                }
                
                hasMorePage = true
                page += 1
                digimons = newDigimons + self.digimons
                self.state.value = .loaded
                
            case .failure:
                self.state.value = .error
            }
            self.stopLoadingAnimation()
        }
    }
    
    func getDigimons() -> [Digimon] {
        return digimons
    }
    
    func startLoadingAnimation() {
        stopLoadingAnimation()
        
        loadingTextsIndex = 0
        loadingTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.loadingText.value = self.loadingTexts[self.loadingTextsIndex]
            self.loadingTextsIndex = (self.loadingTextsIndex + 1) % self.loadingTexts.count
        }
    }
    
    func stopLoadingAnimation() {
        loadingTimer?.invalidate()
        loadingTimer = nil
    }
    
    func observeState(_ observer: @escaping(FeedViewControllerStates) -> Void) {
        state.bind(observer: observer)
    }
    
    func observeLoadingText(_ observer: @escaping(String) -> Void) {
        loadingText.bind(observer: observer)
    }
}
