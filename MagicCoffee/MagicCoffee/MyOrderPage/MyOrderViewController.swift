//
//  MyOrderViewController.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 16.01.25.
//

import UIKit
import SwiftUI

class MyOrderViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MyOrderTableViewCell.self, forCellReuseIdentifier: "CurrentOrder")
        return tableView
    }()
    
    private lazy var myOrderLabel: UILabel = {
        let label = UILabel()
        label.create(text: "My order",font: 24)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        placeViews()
        setupConstraints()
        leftBarButtonConfig()
    }
    
    private func leftBarButtonConfig() {
        configureLeftBarButton(icon: "arrow.left", action: { [weak self] in
            self?.navigateBack()
        })
    }
    
    private func navigateBack() {
       //todo
    }
    
    private func placeViews() {
        view.addSubview(myOrderLabel)
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
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
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CurrentOrder", for: indexPath) as? MyOrderTableViewCell {
            return cell
        }
        return UITableViewCell()
    }
}

struct MyOrderviewControllerRepresentable: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = MyOrderViewController
    
    
    func makeUIViewController(context: Context) -> MyOrderViewController {
        MyOrderViewController()
    }
    
    func updateUIViewController(_ uiViewController: MyOrderViewController, context: Context) {
        
    }
}

struct MyOrderviewController_Previews: PreviewProvider {
    static var previews: some View {
        MyOrderviewControllerRepresentable()
    }
}
