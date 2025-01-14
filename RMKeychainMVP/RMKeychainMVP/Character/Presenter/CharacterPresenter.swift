//
//  CharacterPresenter.swift
//  RMKeychainMVP
//
//  Created by Ибрагим Габибли on 14.01.2025.
//

import Foundation
import UIKit

final class CharacterPresenter: CharacterPresenterProtocol {
    private weak var view: CharacterViewProtocol?
    private let networkManager: NetworkManagerProtocol
    private let storageManager: StorageManagerProtocol

    private var characters = [Character]()

    init(view: CharacterViewProtocol,
         networkManager: NetworkManagerProtocol,
         storageManager: StorageManagerProtocol
    ) {
        self.view = view
        self.networkManager = networkManager
        self.storageManager = storageManager
    }

    func viewDidLoad() {
        getCharacters()
    }

    private func getCharacters() {
        if let savedCharacters = storageManager.loadCharacters() {
            characters = savedCharacters
            view?.updateCharacters(characters)
            return
        }

        networkManager.getCharacters { [weak self] result in
            guard let self else {
                return
            }

            switch result {
            case .success(let character):
                DispatchQueue.main.async {
                    self.characters = character
                    self.view?.updateCharacters(self.characters)
                    self.storageManager.saveCharacters(character)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.view?.showError(error.localizedDescription)
                }
            }
        }
    }

    func loadImage(for character: Character, completion: @escaping (UIImage?) -> Void) {
        networkManager.loadImage(from: character.image, completion: completion)
    }
}
