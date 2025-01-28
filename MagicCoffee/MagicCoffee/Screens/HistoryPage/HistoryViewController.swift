//
//  HistoryViewController.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 15.01.25.
//


import SwiftUI
import UIKit

class HistoryViewController: UIViewController {

    
    private var underlineLeadingConstraint: NSLayoutConstraint!
    
    var viewModel = HistoryViewModel()

    private lazy var ongoingButton: UIButton = {
        let button = UIButton(type: .system)
        button.create(title: "On going")
        button.titleLabel?.font = UIFont(name: "Poppins", size: 16)
        button.addAction(UIAction(handler: { [weak self] action in
            self?.didTapOngoing()
        }), for: .touchUpInside)
        return button
    }()
    
    private lazy var  historyButton: UIButton = {
        let button = UIButton(type: .system)
        button.create(title: "History")
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont(name: "Poppins", size: 16)
        button.addAction(UIAction(handler: { [weak self] action in
            self?.didTapHistory()
        }), for: .touchUpInside)
        return button
    }()
    
    private lazy var grayUnderLineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray5
        return view
    }()
    
    private lazy var underlineView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(OrdersTableViewCell.self, forCellReuseIdentifier: "OrderCell")
        return tableView
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
        updateViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchOrders()
    }
    
    func updateViewModel() {
        viewModel.updateCoffees = { [weak self] in
            DispatchQueue.main.async { [weak self] in                self?.tableView.reloadData()
            }
        }
    }
    
    private func setupUI() {
        setupButtons()
        setupTableView()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: ongoingButton.bottomAnchor, constant: 30),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40)
        ])
    }
    
    private func setupButtons() {
        
        let buttonStack = UIStackView(arrangedSubviews: [ongoingButton, historyButton])
        buttonStack.axis = .horizontal
        buttonStack.distribution = .fillEqually
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonStack)
        view.addSubview(underlineView)
        view.addSubview(grayUnderLineView)
        
        NSLayoutConstraint.activate([
            buttonStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            buttonStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 70),
            buttonStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -70),
            buttonStack.heightAnchor.constraint(equalToConstant: 50),
            
            underlineView.heightAnchor.constraint(equalToConstant: 2),
            underlineView.bottomAnchor.constraint(equalTo: buttonStack.bottomAnchor),
            underlineView.widthAnchor.constraint(equalTo: ongoingButton.widthAnchor),
           
            
            grayUnderLineView.bottomAnchor.constraint(equalTo: underlineView.bottomAnchor, constant: 1),
            grayUnderLineView.heightAnchor.constraint(equalToConstant: 1),
            grayUnderLineView.leftAnchor.constraint(equalTo: view.leftAnchor),
            grayUnderLineView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        
        underlineLeadingConstraint = underlineView.leadingAnchor.constraint(equalTo: ongoingButton.leadingAnchor)
        underlineLeadingConstraint.isActive = true
    }
   
    
    private func didTapOngoing() {
        updateTabSelection(selectedButton: ongoingButton, unselectedButton: historyButton)
    }
    
     private func didTapHistory() {
        updateTabSelection(selectedButton: historyButton, unselectedButton: ongoingButton)
    }
    
    private func updateTabSelection(selectedButton: UIButton, unselectedButton: UIButton) {
        selectedButton.setTitleColor(.black, for: .normal)
        unselectedButton.setTitleColor(.gray, for: .normal)
        
        UIView.animate(withDuration: 0.3) {
            self.underlineLeadingConstraint.constant = selectedButton.frame.origin.x
            self.view.layoutIfNeeded()
        }
    }
}


extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        viewModel.coffeeHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath) as? OrdersTableViewCell {
            let selectedCoffee = viewModel.coffeeHistory[indexPath.row]
            cell.configure(with: selectedCoffee)
            cell.coffee = selectedCoffee
            return cell
            
        }
        return UITableViewCell()
    }
}










struct HistoryviewControllerRepresentable: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = HistoryViewController
    
    
    func makeUIViewController(context: Context) -> HistoryViewController {
        HistoryViewController()
    }
    
    func updateUIViewController(_ uiViewController: HistoryViewController, context: Context) {
        
    }
}

struct HistoryviewController_Previews: PreviewProvider {
    static var previews: some View {
        HistoryviewControllerRepresentable()
    }
}
