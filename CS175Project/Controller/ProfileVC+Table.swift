//
//  ProfileVC+Table.swift
//  CS175Project
//
//  Created by Destiny Hochhalter Ruiz on 5/6/21.
//

import UIKit

extension ProfileVC: UITableViewDelegate, UITableViewDataSource {
    
    func showFilterTable(duration: TimeInterval = 0.15, completion: ((Bool) -> Void)? = nil) {
        filterTable.isHidden = false
        UIView.animate(withDuration: duration, delay: 0, options: .curveLinear) {
            //self.filterTableTopCon?.constant = 0
            self.gridCollectionTopCon?.constant = Constants.Sizes.GridCollection.gridCollectionHeight//300
            self.gridCollectionVw.reloadData()
            //print("height: \(Constants.Sizes.GridCollection.gridCollectionHeight)")
            self.view.layoutIfNeeded()
            // rotate arrow on horizontal x axis
           // self.selectedFilterOptionArrow.transform = CGAffineTransform(scaleX: -1, y: 1)
        } completion: { (success) in
            completion?(success)
        }
    }
    
    func hideFilterTable(duration: TimeInterval = 0, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: duration, delay: 0, options: .curveLinear) {
           // self.filterTableTopCon?.constant = -300
            self.gridCollectionTopCon?.constant = 0
            self.gridCollectionVw.reloadData()
            self.view.layoutIfNeeded()
            // rotate arrow on horizontal x axis
            //self.selectedFilterOptionArrow.transform = CGAffineTransform(scaleX: -1, y: 1)
        } completion: { (success) in
            self.filterTable.isHidden = true
            completion?(success)
        }
    }
    
    // call when tapping the arrow
    // to show or hide
    func toggleFilterTable() {
        if filterTable.isHidden {
            showFilterTable(duration: 0.15) { (success) in
                //
            }
        } else {
            hideFilterTable(duration: 0.15) { (success) in
                //
            }
        }
    }
    
    // number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == filterTable {
        let unselectedCount = filterOptionArr.getSelectedAndUnselectedOptions().unselected.count
        return unselectedCount
        } else {
            // collections table
            return 1 // 1 hardcoded collection
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == filterTable {
        if let cell = tableView.dequeueReusableCell(withIdentifier: FilterOptionCell.id, for: indexPath) as? FilterOptionCell {
            
            cell.delegate = self
            cell.setup(filterOption: filterOptionArr.getSelectedAndUnselectedOptions().unselected[indexPath.row])
            return cell
            
        } else {
            return UITableViewCell()
        }
        } else {
            // collections table
            if let cell = tableView.dequeueReusableCell(withIdentifier: ClothingCollectionsCell.id, for: indexPath) as? ClothingCollectionsCell {
                let _collection = collection
                cell.delegate = self
                cell.setup(collection: _collection)
                return cell
            } else {
                return UITableViewCell()
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == filterTable {
            return 50
        } else if tableView == clothingCollectionsTable {
            return Constants.Sizes.ClothingCollectionCell.height
        }
        return 0
    }

}


extension ProfileVC: FilterOptionCellDelegate {
    func cellTapped(cell: FilterOptionCell) {
        // make tapped cell selected
        filterOptionArr.setSelected(type: cell.filterOption!.type)
        // all other cells become unselected
        // this reorders table view such that unselected
        // options remain ordered in the table view
        // and the selected option (if any) is set in selectedFilterOptionLbl
        
        // filter closet by filter type (ex: tops only)
        let filterType = cell.filterOption!.type.rawValue
        
        if (filterType != "Recent") {
        filteredClosetDict = closetDict.filter { $0.value.type.rawValue == filterType}
        } else {
            // recent should show entire closet
            filteredClosetDict = closetDict
        }
        
        self.filterTable.reloadData()
        selectedFilterOptionLbl.text = cell.filterOption!.type.rawValue
        toggleFilterTable()
    }
}

extension ProfileVC : ClothingCollectionsCellDelegate {
    
    func optionsTapped(cell: ClothingCollectionsCell) {
        
    }
    
    func clothingCollectionsCellItemTapped(cell: ClothingCollectionsCell) {
        
    }
}
