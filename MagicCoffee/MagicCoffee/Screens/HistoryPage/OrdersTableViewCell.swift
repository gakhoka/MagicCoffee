//
//  OrdersTableViewCell.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 15.01.25.
//

import SwiftUI
import UIKit

class OrdersTableViewCell: UITableViewCell {
    
    var coffee: Coffee?
    var order: Order?
   
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.create(text: "", textColor: .gray, font: 14)
        return label
    }()
    
    private lazy var coffeCup: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "cupofcoffee")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .black
        return imageView
    }()
    
    private lazy var desctiptionImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "description")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .black
        return imageView
    }()

    private let coffeeName: UILabel = {
        let label = UILabel()
        label.create(text: "aosfd")
        label.font = UIFont.systemFont(ofSize: 19)
        return label
    }()
    
    private let sizeLabel: UILabel = {
        let label = UILabel()
        label.create(text: "", font: 16)
        return label
    }()
    
    private let price: UILabel = {
        let label = UILabel()
        label.create(text: "", font: 18)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    
    private func setupUI() {
        placeViews()
        setupConstraints()
    }
    
    func configure(with coffee: Coffee) {
        coffeeName.text = coffee.name
        price.text = "\(String(format: "%.2f", coffee.price)) $"
        sizeLabel.text = coffee.size.rawValue
        dateLabel.text = coffee.prepTime.formatToDay()
    }
    
    func configureDate() {}
    
    private func placeViews() {
        contentView.addSubview(dateLabel)
        contentView.addSubview(coffeeName)
        contentView.addSubview(coffeCup)
        contentView.addSubview(desctiptionImage)
        contentView.addSubview(sizeLabel)
        contentView.addSubview(price)
    }

    private func setupConstraints() {
    
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            dateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            
            coffeCup.leftAnchor.constraint(equalTo: dateLabel.leftAnchor),
            coffeCup.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 20),
            coffeCup.heightAnchor.constraint(equalToConstant: 25),
            coffeCup.widthAnchor.constraint(equalToConstant: 25),

            coffeeName.leftAnchor.constraint(equalTo: coffeCup.rightAnchor, constant: 10),
            coffeeName.centerYAnchor.constraint(equalTo: coffeCup.centerYAnchor),
            
            desctiptionImage.topAnchor.constraint(equalTo: coffeCup.bottomAnchor, constant: 20),
            desctiptionImage.leftAnchor.constraint(equalTo: dateLabel.leftAnchor, constant: 3),
            desctiptionImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30),
            desctiptionImage.heightAnchor.constraint(equalToConstant: 20),
            desctiptionImage.widthAnchor.constraint(equalToConstant: 20),
            
            sizeLabel.centerYAnchor.constraint(equalTo: desctiptionImage.centerYAnchor),
            sizeLabel.leftAnchor.constraint(equalTo: desctiptionImage.rightAnchor, constant: 10),

            
            
            price.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            price.centerYAnchor.constraint(equalTo: coffeeName.centerYAnchor)
        ])
    }
}


struct OrdersTableViewCellPreview: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let cell = OrdersTableViewCell(style: .default, reuseIdentifier: nil)
        return cell.contentView
    }

    func updateUIView(_ uiView: UIView, context: Context) {
    }
}

struct OrdersTableViewCell_Previews: PreviewProvider {
    static var previews: some View {
        OrdersTableViewCellPreview()
            .frame(width: 375, height: 80)
            .previewLayout(.sizeThatFits)
    }
}

