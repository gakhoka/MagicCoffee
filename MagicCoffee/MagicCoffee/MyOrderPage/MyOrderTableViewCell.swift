//
//  MyOrderTableViewCell.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 16.01.25.
//

import UIKit
import SwiftUI

class MyOrderTableViewCell: UITableViewCell {

    private lazy var grayView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var coffeCup: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "latte")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .black
        return imageView
    }()
    
    private let coffeeName: UILabel = {
        let label = UILabel()
        label.create(text: "Americano", font: 16)
        return label
    }()
    
    private let coffeeDescription: UILabel = {
        let label = UILabel()
        label.create(text: "single | iced | medium | full ice",textColor: .systemGray, font: 12)
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        return label
    }()
    
    private let price: UILabel = {
        let label = UILabel()
        label.create(text: "Eur 5.93", font: 18)
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        return label
    }()
    
    private let amountLabel: UILabel = {
        let label = UILabel()
        label.create(text: "x1", textColor: .gray)
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        contentView.layer.cornerRadius = 20
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
        contentView.addSubview(grayView)
        grayView.addSubview(coffeeName)
        grayView.addSubview(coffeCup)
        grayView.addSubview(amountLabel)
        grayView.addSubview(coffeeDescription)
        grayView.addSubview(price)
    }

    private func setupConstraints() {

        NSLayoutConstraint.activate([
            
            grayView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            grayView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            grayView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            grayView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),

            coffeCup.leftAnchor.constraint(equalTo: grayView.leftAnchor, constant: 5),
            coffeCup.topAnchor.constraint(equalTo: grayView.topAnchor, constant: 20),
            coffeCup.bottomAnchor.constraint(equalTo: grayView.bottomAnchor, constant: -30),
            coffeeName.topAnchor.constraint(equalTo: grayView.topAnchor, constant: 16),
            coffeeName.leftAnchor.constraint(equalTo: coffeCup.rightAnchor, constant: 8),
            
            coffeeDescription.topAnchor.constraint(equalTo: coffeeName.bottomAnchor, constant: 10),
            coffeeDescription.leftAnchor.constraint(equalTo: coffeeName.leftAnchor),
            coffeeDescription.widthAnchor.constraint(equalToConstant: 150),
            
            amountLabel.topAnchor.constraint(equalTo: coffeeDescription.bottomAnchor, constant: 10),
            amountLabel.leftAnchor.constraint(equalTo: coffeeName.leftAnchor),
            amountLabel.bottomAnchor.constraint(equalTo: grayView.bottomAnchor, constant: -10),
            
            price.rightAnchor.constraint(equalTo: grayView.rightAnchor, constant: -10),
            price.topAnchor.constraint(equalTo: grayView.topAnchor, constant: 30),
            price.widthAnchor.constraint(equalToConstant: 50)

        ])
    }
}


struct MyOrderTableViewCellPreview: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let cell = MyOrderTableViewCell(style: .default, reuseIdentifier: nil)
        return cell.contentView
    }

    func updateUIView(_ uiView: UIView, context: Context) {
    }
}

struct MyOrderTableViewCell_Previews: PreviewProvider {
    static var previews: some View {
        MyOrderTableViewCellPreview()
            .frame(width: 375, height: 160)
            .previewLayout(.sizeThatFits)
    }
}

