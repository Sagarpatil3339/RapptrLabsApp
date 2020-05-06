//
//  httpResponse.swift
//  iOSTest
//
//  Created by Prasad Patil on 5/5/20.
//  Copyright © 2020 Rapptr Labs. All rights reserved.
//

import Foundation
enum ResultType {
    case success
    case failure
}

private func handleRsponse (_ response:HTTPURLResponse) -> ResultType {
    
    switch response.statusCode {
    case 200...299:
        return .success
    default:
        return .failure;
    }
    
}
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
internal typealias NetworkRouterCompletion = (_ data:Data? ,_ error:Error?)->();
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

internal func httpResponse(request: URLRequest, completionHandler:@escaping NetworkRouterCompletion){
    
    let session = URLSession.shared;
    
    let task = session.dataTask(with: request){ (data, response, error) -> Void in
        
        guard let data = data else {
            completionHandler(nil,error);
            return;
        }
        if let response = response as? HTTPURLResponse{
            
            let Result = handleRsponse(response);
            
            switch Result{
            case .success:
                completionHandler(data,nil);
                break;
            case .failure:
                completionHandler(nil,error);
                break;
            }
        }
    }
    task.resume();
    
}
