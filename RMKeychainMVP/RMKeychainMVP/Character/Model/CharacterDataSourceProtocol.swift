//
//  CharacterDataSourceProtocol.swift
//  RMKeychainMVP
//
//  Created by Ибрагим Габибли on 14.01.2025.
//

import Foundation
import UIKit

protocol CharacterDataSourceProtocol: UITableViewDataSource {
    var characters: [Character] { get set }
}
