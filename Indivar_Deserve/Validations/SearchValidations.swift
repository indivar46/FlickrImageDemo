//
//  SearchValidations.swift
//  Indivar_Deserve
//
//  Created by Indivar on 16/05/21.
//  Copyright © 2021 Indivar. All rights reserved.
//

import Foundation

//MARK: Search Validations
struct SearchValidations
{
    func validate(request: SearchRequest) -> ValidationResponse {
        guard !request.searchText.isEmpty else {
            return ValidationResponse(message: "Search cannot be empty", isValid: false)
        }
        return ValidationResponse(message: nil, isValid: true)
    }
}
