//
//  ViewController.swift
//  JokesApp
//
//  Created by Jose Augusto Costa Martins Jr on 07/12/21.
//

import UIKit

class DadJokesViewController: UIViewController {

    private struct Constants {
        static let cellIdentifier: String = "cell"
        static let spacing: CGFloat = 16
        static let labelHeight: CGFloat = 56
    }

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        return tableView
    }()
    private var errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var jokesViewModel: JokesViewModel
    private var jokesList: [Joke] = []

    init(jokesViewModel: JokesViewModel = DadJokesViewModel()) {
        self.jokesViewModel = jokesViewModel
        super.init(nibName: nil, bundle: nil)
        self.jokesViewModel.handler = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
        jokesViewModel.viewDidLoad()
    }

    private func setup() {
        view.addSubview(errorLabel)
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            //Error Label
            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            errorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.spacing),
            errorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.spacing),
            errorLabel.heightAnchor.constraint(equalToConstant: Constants.labelHeight),

            // Table View
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

    }
}

extension DadJokesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        jokesViewModel.jokesList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier)
        if (cell == nil) {
            cell = UITableViewCell(style: .default, reuseIdentifier: Constants.cellIdentifier)
            cell?.textLabel?.numberOfLines = 0
            let item = jokesViewModel.jokesList[indexPath.row]
            cell?.textLabel?.text = item.joke
        }
        return cell ?? UITableViewCell()
    }
}

extension DadJokesViewController: JokesHandler {
    func didReceiveError(error: String) {
        tableView.isHidden = true
        errorLabel.isHidden = false
        errorLabel.text = error
    }

    func didReceiveJokes() {
        errorLabel.isHidden = true
        tableView.isHidden = false
        tableView.reloadData()
    }
}
