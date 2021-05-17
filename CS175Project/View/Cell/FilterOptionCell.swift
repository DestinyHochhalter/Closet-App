//
//  FilterOptionCell.swift
//  CS175Project
//
//  Created by Destiny Hochhalter Ruiz on 5/6/21.
//

import Foundation
import UIKit

protocol FilterOptionCellDelegate {
    func cellTapped(cell: FilterOptionCell)
}

class FilterOptionCell: UITableViewCell, UITableViewDelegate {
    
    static let id = "FilterOptionCell"
    var delegate: FilterOptionCellDelegate?
    var filterOption: FilterOption?
    
    let optionLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Avenir-Medium", size: 17)!
        lbl.textAlignment = .left
        lbl.textColor = Color.mediumText
        lbl.numberOfLines = 1
        return lbl
    }()
    
    let arrowImgVw: UIImageView = {
        let imgVw = UIImageView()
        imgVw.clipsToBounds = true
        imgVw.contentMode = .scaleAspectFit
        imgVw.tintColor = Color.darkText
        return imgVw
    }()
    
    let cellVw: UIView = {
        let vw = UIView()
        vw.isUserInteractionEnabled = true
        vw.backgroundColor = .clear
        return vw
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = Color.bg
        layoutCell()
        addGestures()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutCell() {
        cellVw.fill(self.contentView)
        optionLbl.addLayout(parentVw: self.contentView, leading: (self.contentView.leadingAnchor, Padding.leading), vert: self.contentView.centerYAnchor)
//        arrowImgVw.addLayout(parentVw: self.contentView, trailing: (self.contentView.leadingAnchor, -Padding.traling), vert: optionLbl.centerYAnchor, height: Padding.iconSz, width: Padding.iconSz)
    }
    
    func addGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
        cellVw.addGestureRecognizer(tap)
    }
    
    @objc func cellTapped() {
        delegate?.cellTapped(cell: self)
    }
    
    func setup(filterOption: FilterOption) {
        optionLbl.text = filterOption.type.rawValue
        self.filterOption = filterOption
    }
}
