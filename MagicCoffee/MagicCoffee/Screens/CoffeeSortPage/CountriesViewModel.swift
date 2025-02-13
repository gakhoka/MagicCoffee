//
//  CountriesViewModel.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 13.02.25.
//

import FirebaseFirestore
import Foundation

class CountriesViewModel: ObservableObject {
    
    @Published var countries: [Country] = []

    func fetchCountries() {
        let dataBase = Firestore.firestore()
        let reference = dataBase.collection("Countries")
        
        reference.getDocuments { [weak self] snapshot, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let snapshot = snapshot else { return }
            
            var fetchedCountries: [Country] = []
            
            for document in snapshot.documents {
                let data = document.data()
                
                let name = data["name"] as? String ?? ""
                let cityNames = data["cities"] as? [String] ?? []
                let cities: [Country.City] = cityNames.map { Country.City(name: $0) }
                
                let country = Country(name: name, cities: cities)
                fetchedCountries.append(country)
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.countries = fetchedCountries
            }
        }
    }
}
