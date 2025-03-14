//
//  ViewController.swift
//  RMKeychainMVP
//
//  Created by Ибрагим Габибли on 09.01.2025.
//

import UIKit
import SnapKit

final class CharacterViewController: UIViewController {
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        return tableView
    }()

    var presenter: CharacterPresenterProtocol?
    var tableViewDataSource: CharacterDataSourceProtocol?
    // Cannot be injected with initializer, because presenter also needs CharacterViewController for his initializer

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupViews()
        presenter?.viewDidLoad()
    }

    private func setupNavigationBar() {
        title = "Characters"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = .white
    }

    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(tableView)

        tableView.dataSource = tableViewDataSource
        tableView.delegate = self
        tableView.register(CharacterTableViewCell.self,
                           forCellReuseIdentifier: CharacterTableViewCell.id)

        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - CharacterViewProtocol
extension CharacterViewController: CharacterViewProtocol {
    func updateCharacters(_ characters: [Character]) {

        tableViewDataSource?.characters = characters
        tableView.reloadData()
    }

    func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - UITableViewDelegate
extension CharacterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        128
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
