//
//  MyOrderViewController.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 16.01.25.
//

import UIKit
import SwiftUI

class MyOrderViewController: UIViewController {
    
    var viewModel: OrderViewModel
    
    init(viewModel: OrderViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let leftBarButton = UIButton()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MyOrderTableViewCell.self, forCellReuseIdentifier: "CurrentOrder")
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private lazy var myOrderLabel: UILabel = {
        let label = UILabel()
        label.create(text: "My order",font: 24)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    private func setupUI() {
        placeViews()
        setupConstraints()
        leftBarButtonConfig()
    }
    
    private func leftBarButtonConfig() {
        
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "arrow.left", withConfiguration: UIImage.SymbolConfiguration(scale: .large))
        config.imagePadding = 2
        leftBarButton.configuration = config
        leftBarButton.translatesAutoresizingMaskIntoConstraints = false
        leftBarButton.scalesLargeContentImage = true
        leftBarButton.tintColor = .black
        leftBarButton.addAction(UIAction(handler: { [weak self] action in
            self?.navigateBack()
        }), for: .touchUpInside)
    }
    
    private func navigateBack() {
        navigationController?.popViewController(animated: true)
    }
    
    private func placeViews() {
        view.addSubview(myOrderLabel)
        view.addSubview(tableView)
        view.addSubview(leftBarButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            leftBarButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            leftBarButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            
            myOrderLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            myOrderLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            
            tableView.leftAnchor.constraint(equalTo: myOrderLabel.leftAnchor),
            tableView.topAnchor.constraint(equalTo: myOrderLabel.bottomAnchor, constant: 30),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30)
        ])
    }
}

extension MyOrderViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.coffeeCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CurrentOrder", for: indexPath) as? MyOrderTableViewCell {
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        var actions = [UIContextualAction]()

        let delete = UIContextualAction(style: .normal, title: nil) { [weak self] (contextualAction, view, completion) in
            guard self == self else { return }

            completion(true)
        }

        delete.image = UIImage(named: "TrashCan")?.addBackgroundCircle(.lightRed)
        delete.backgroundColor = .systemBackground
        actions.append(delete)

        let config = UISwipeActionsConfiguration(actions: actions)
        config.performsFirstActionWithFullSwipe = false

        return config
    }
}


struct MyOrderviewControllerRepresentable: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = MyOrderViewController
    
    
    func makeUIViewController(context: Context) -> MyOrderViewController {
        MyOrderViewController(viewModel: OrderViewModel())
    }
    
    func updateUIViewController(_ uiViewController: MyOrderViewController, context: Context) {
        
    }
}

struct MyOrderviewController_Previews: PreviewProvider {
    static var previews: some View {
        MyOrderviewControllerRepresentable()
    }
}
