//
//  KeychainHelper.swift
//  GitHubUsers
//
//  Created by Sparsh Chadha on 11/03/24.
//

import Foundation
/**
    * kSecClass — A key that represent type of data being saved.  `kSecClassGenericPassword` indicates that the data we are saving is a generic            password and can be used to store tokens
 
    * kSecValuedata — A key that represent the data being saved to keychain
 
    * kSecAttributeService & kSecAttrAccount the two key are mandatory. The values for both of these keys will act as the primary key for the data being            saved. In other words, we will use them to retrieve the saved data from the keychain later on. There is no hard defined rule what value to use for both         kSecAttrService and kSecAttrAccount. However, it is recommended to use strings that are meaningful. For example, if we are saving the login access        token, we can set kSecAttrService as “access-token” and kSecAttrAccount as “app-name“.
 
    * CFTypeRef serves as a placeholder for other true Core Foundation objects (e.g., CFString, CFArray, etc.). Similar to Any, but Any is used in swift only        and CFTypeRef is part of core foundation(C based framework in mac and ios)
 */

class KeychainHelper {
    static func saveData(data: Data, forService service: String, account: String) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecValueData as String: data
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil) // Passing nil because we don't need the result of the operation
        return status == errSecSuccess
    }
    
    static func getData(forService service: String, account: String) -> Data? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne // specifies only 1 matching item to be returned
        ]

        var item: CFTypeRef? // some core foundation object, type not known at compile time
        let status = SecItemCopyMatching(query as CFDictionary, &item)

        guard status == errSecSuccess else {
            return nil
        }

        guard let data = item as? Data else {
            return nil
        }

        return data
    }

}
