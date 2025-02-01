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
    private var isOngoingSelected = true
    var viewModel = HistoryViewModel()
    
    private lazy var emptyOrderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins", size: 18)
        return label
    }()
    
    private lazy var emptyImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "slash")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.create(text: "History", font: 20)
        return label
    }()

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
                self?.emptyView()
            }
        }
    }
    
    private func setupUI() {
        setupButtons()
        emptyView()
        setupTitleLabel()
    }
    
    private func setupTitleLabel() {
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
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
            buttonStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
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
    
    private func setupEmptyView() {
        emptyOrderLabel.text = isOngoingSelected ? "No ongoing orders yet" : "No history of orders yet"

        view.addSubview(emptyImage)
        view.addSubview(emptyOrderLabel)
        NSLayoutConstraint.activate([
            emptyImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            emptyOrderLabel.topAnchor.constraint(equalTo: emptyImage.bottomAnchor, constant: 20),
            emptyOrderLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func emptyView() {
        if viewModel.ongoingOrder.isEmpty && viewModel.ordersHistory.isEmpty {
               setupEmptyView()
               tableView.removeFromSuperview()
           } else if isOngoingSelected && viewModel.ongoingOrder.isEmpty {
               setupEmptyView()
               tableView.removeFromSuperview()
           } else if !isOngoingSelected && viewModel.ordersHistory.isEmpty {
               setupEmptyView()
               tableView.removeFromSuperview()
           } else {
               emptyImage.removeFromSuperview()
               emptyOrderLabel.removeFromSuperview()
               if tableView.superview == nil {
                   setupTableView()
               }
           }
    }
   
    
    private func didTapOngoing() {
        isOngoingSelected = true
        updateTabSelection(selectedButton: ongoingButton, unselectedButton: historyButton)
        tableView.reloadData()
        emptyView()
    }
    
     private func didTapHistory() {
        isOngoingSelected = false
        updateTabSelection(selectedButton: historyButton, unselectedButton: ongoingButton)
         tableView.reloadData()
         emptyView()
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return isOngoingSelected ? viewModel.ongoingOrder.count : viewModel.ordersHistory.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let selectedOrders = isOngoingSelected ? viewModel.ongoingOrder : viewModel.ordersHistory
        return selectedOrders[section].coffee.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath) as? OrdersTableViewCell else {
            return UITableViewCell()
        }
        
        let selectedOrders = isOngoingSelected ? viewModel.ongoingOrder : viewModel.ordersHistory
        let order = selectedOrders[indexPath.section]
        let coffee = order.coffee[indexPath.row]
        
        cell.configure(with: coffee, isOngoing: isOngoingSelected, order: order)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .lightGrayBackground
        headerView.layer.cornerRadius = 10
        
        let selectedOrders = isOngoingSelected ? viewModel.ongoingOrder : viewModel.ordersHistory
        let order = selectedOrders[section]
        
        let amountLabel = UILabel()
        amountLabel.create(text: "\(order.coffeeAmount) coffees totally", font: 14)
        
        let priceLabel = UILabel()
        priceLabel.create(text: "Price $\(String(format: "%.2f", order.price))", font: 14)
        
        
        headerView.addSubview(amountLabel)
        headerView.addSubview(priceLabel)
        
        NSLayoutConstraint.activate([
            amountLabel.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 15),
            amountLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            priceLabel.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: -15),
            priceLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
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
