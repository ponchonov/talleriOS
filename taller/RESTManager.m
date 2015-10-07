//
//  RESTManager.m
//  taller
//
//  Created by Omar Guzmán on 10/5/15.
//  Copyright © 2015 birghtCoders. All rights reserved.
//

#import "RESTManager.h"

/// Macro that store the URL for the testing server.
#define URL_SERVER @"https://tallerios.herokuapp.com"

@implementation RESTManager

+(void)sendData:(NSMutableDictionary *)data toService:(NSString *)service withMethod:(NSString *)method  toCallback:(void (^)(id))callback
{
    /// Create an URL variable.
    NSURL *url = nil;
    /// Create a Request variable.
    NSMutableURLRequest * request;
    url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", URL_SERVER, service]];
    /// Set the request variable.
    request = [NSMutableURLRequest requestWithURL:url];
    /// Check if the request require the accessToken -a.k.a. spree_api_key-.
    /// Check if the request will send data.
    if(data)
    {
        /// Create a JSON data variable.
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:kNilOptions error:nil];
        [request setValue:[NSString stringWithFormat:@"%ud", [jsonData length]] forHTTPHeaderField:@"Content-Length"];
        [request setHTTPBody:jsonData];
    }
    
    /// Set the request.
    [request setHTTPMethod:method];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"json" forHTTPHeaderField:@"Data-Type"];
    /// Send the request.
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        //NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if(!error && response != nil)
        {
            /// Create a dictionary based on the JSON of the response.
            NSDictionary *responseJson = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            callback(responseJson);
        }
        else
        {
            /// Check for the message error.
            if(error)
            {
                callback(nil);
            }
        }
    }];
}
@end
