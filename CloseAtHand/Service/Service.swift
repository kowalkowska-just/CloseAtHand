//
//  Service.swift
//  CloseAtHand
//
//  Created by Justyna Kowalkowska on 03/12/2020.
//

import Firebase
import FacebookCore
import FacebookLogin

//MARK: - Database Referances

let DB_REF = Database.database().reference()
let REF_USERS = DB_REF.child("users")

//MARK: - Users Service

struct UsersService {
    static let shered = UsersService()
    
    func saveData(values: [String: Any], uid: String) {
        REF_USERS.child(uid).updateChildValues(values) { (error, ref) in
            print("DEBUG: Successfully saved data...")
        }
    }
    
    func fetchFacebookUser() {
        let token = AccessToken.current?.tokenString
        let params = ["fields": "id, email, name, picture.type(large)"]
        let graphRequest = GraphRequest(graphPath: "me", parameters: params,
                                        tokenString: token, version: Settings.defaultGraphAPIVersion,
                                        httpMethod: HTTPMethod.get)
        graphRequest.start { (connection, result, error) in
            if let err = error {
                print("DEBUG: Facebook graph request error: \(err)")
            } else {
                print("DEBUG: Facebook graph request successful!")
                
                guard let json = result as? NSDictionary else { return }
                
                guard let email = json["email"] as? String,
                      let fullname = json["name"] as? String
//                      let id = json["id"] as? String
                else { return }
                
                guard let pictureData = json["picture"] as? [String: Any],
                      let data = pictureData["data"] as? [String: Any],
                      let pictureURL = data["url"] as? String
                else { return }

                
                guard let url = URL(string: pictureURL) else { return }
                URLSession.shared.dataTask(with: url) { (data, response, error) in
                    if let error = error {
                        print("DEBUG: Failed request for profile picture with error \(error)")
                        return
                    }
                    guard let data = data else { return }
                    guard let profilePicture = UIImage(data: data) else { return }
                    
                    self.saveUserIntoDatabase(profilePicture: profilePicture, email: email, fullname: fullname)
                }.resume()
            }
        }
    }
    
    func saveUserIntoDatabase(profilePicture: UIImage, email: String, fullname: String) {
        let fileName = UUID().uuidString
        guard let uploadData = profilePicture.jpegData(compressionQuality: 0.3) else { return }
        
        let storage = Storage.storage().reference().child("profileImages").child(fileName)
        
        DispatchQueue.main.sync {
            storage.putData(uploadData).observe(.success) { (snapshot) in
                storage.downloadURL { (url, error) in
                    if let error = error {
                        print("DEBUG: Failed download URL with profile image with error: \(error)")
                        return
                    }
                    if let profilePictureURL = url?.absoluteString {
                        
                        guard let uid = Auth.auth().currentUser?.uid else { return }
                        
                        let values = ["email": email,
                                      "fullname": fullname,
                                      "profilePictureURL": profilePictureURL] as [String: Any]
                        
                        REF_USERS.child(uid).updateChildValues(values) { (error, ref) in
                            
                            if let error = error {
                                print("DEBUG: Failed saved user into Database with erroe: \(error)")
                            }
                            print("DEBUG: Successfully saved user into Database")
                        }
                    }
                }
            }
        }
    }
    
}
