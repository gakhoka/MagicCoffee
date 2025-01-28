//
//  OrdersTableViewCell.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 15.01.25.
//

import SwiftUI
import UIKit

class OrdersTableViewCell: UITableViewCell {
   
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.create(text: "24 june | 12: 30 | by 18:30", textColor: .gray, font: 12)
        return label
    }()
    
    private lazy var coffeCup: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "CoffeeCup")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .black
        return imageView
    }()
    
    private lazy var locationImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Location")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .black
        return imageView
    }()

    private let CoffeeName: UILabel = {
        let label = UILabel()
        label.create(text: "Americano", font: 14)
        return label
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.create(text: "Barcelona", font: 14)
        return label
    }()
    
    private let price: UILabel = {
        let label = UILabel()
        label.create(text: "Eur 5.93", font: 18)
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
    
    private func placeViews() {
        contentView.addSubview(dateLabel)
        contentView.addSubview(CoffeeName)
        contentView.addSubview(coffeCup)
        contentView.addSubview(locationImage)
        contentView.addSubview(locationLabel)
        contentView.addSubview(price)
    }

    private func setupConstraints() {
    
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            dateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            
            coffeCup.leftAnchor.constraint(equalTo: dateLabel.leftAnchor),
            coffeCup.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),

            CoffeeName.leftAnchor.constraint(equalTo: coffeCup.rightAnchor, constant: 10),
            CoffeeName.centerYAnchor.constraint(equalTo: coffeCup.centerYAnchor),
            
            locationImage.topAnchor.constraint(equalTo: coffeCup.bottomAnchor, constant: 10),
            locationImage.leftAnchor.constraint(equalTo: dateLabel.leftAnchor),
            
            locationLabel.centerYAnchor.constraint(equalTo: locationImage.centerYAnchor),
            locationLabel.leftAnchor.constraint(equalTo: locationImage.rightAnchor, constant: 10),
            locationImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            price.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -30),
            price.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15)
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

