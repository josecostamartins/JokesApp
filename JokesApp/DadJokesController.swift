//
//  ViewController.swift
//  JokesApp
//
//  Created by Jose Augusto Costa Martins Jr on 07/12/21.
//

import UIKit

class DadJokesViewController: UIViewController {

    private var tableView: UITableView
    private let jokesViewModel: JokesViewModel
    private var jokesList: [Joke] = []

    init(jokesViewModel: JokesViewModel = DadJokesViewModel()) {
        self.tableView = UITableView()
        self.jokesViewModel = jokesViewModel
        super.init(nibName: nil, bundle: nil)
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
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
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
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if (cell == nil) {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
            cell?.textLabel?.numberOfLines = 0
            let item = jokesViewModel.jokesList[indexPath.row]
            cell?.textLabel?.text = item.joke
        }
        return cell ?? UITableViewCell()
    }
}

extension DadJokesViewController: JokesHandler {
    func didReceiveJokes() {
        tableView.reloadData()
    }
}
