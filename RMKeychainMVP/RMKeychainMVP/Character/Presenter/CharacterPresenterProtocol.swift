//
//  CharacterPresenterProtocol.swift
//  RMKeychainMVP
//
//  Created by Ибрагим Габибли on 14.01.2025.
//

import Foundation
import UIKit

protocol CharacterPresenterProtocol: AnyObject {
    init(view: CharacterViewProtocol,
         networkManager: NetworkManagerProtocol,
         storageManager: StorageManagerProtocol
    )

    func viewDidLoad()

    func loadImage(for character: Character, completion: @escaping (UIImage?) -> Void)
}
