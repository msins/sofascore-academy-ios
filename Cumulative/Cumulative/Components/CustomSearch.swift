//
// Created by Marko Sinkovic on 09.04.2022..
//

import UIKit

class CustomSearch: UISearchBar {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init() {
        super.init(frame: .zero)

        barTintColor = .background
        searchBarStyle = .minimal

        searchTextField.tintColor = .primary
        searchTextField.returnKeyType = .search
    }
}
