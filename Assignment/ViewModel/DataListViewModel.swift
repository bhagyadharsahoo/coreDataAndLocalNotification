//
//  DataListViewModel.swift
//  Assignment
//
//  Created by Bhagyadhar Sahoo on 22/06/25.
//

import Foundation

final class DataListViewModel {
    
    var items: [PhoneData] = []
    var onDataUpdate: (() -> Void)?
    
    func loadItems() {
        fetchAndStoreItems()
        items = CoreDataManager.shared.fetchItems()
    }

    private func fetchAndStoreItems() {
        guard let url = URL(string: "https://api.restful-api.dev/objects") else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("API Error: \(error.localizedDescription)")
                return
            }

            guard let data = data else { return }

            do {
                let decoder = JSONDecoder()
                let rawObjects = try decoder.decode(PhoneDataModel.self, from: data)

                DispatchQueue.main.async {
                    CoreDataManager.shared.saveItemN(data: rawObjects)
//                    
//                    for item in rawObjects {
//                        CoreDataManager.shared.saveItem(
//                            id: item.id ?? " ",
//                            name: item.name ?? " ",
//                            data: item.data ?? DataClass()
//                        )
//                    }
                    self.items = CoreDataManager.shared.fetchItems()
                    self.onDataUpdate?()
                }
            } catch {
                print("Decoding error: \(error.localizedDescription)")
            }
        }.resume()
    }

    func deleteItem(at index: Int) {
        let item = items[index]
        CoreDataManager.shared.deleteItem(item)
        items.remove(at: index)
    }

    func updateItem(at index: Int, newName: String) {
        let item = items[index]
        CoreDataManager.shared.updateItem(item, newName: newName)
        items[index].name = newName
    }
}
