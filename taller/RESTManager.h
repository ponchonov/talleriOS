//
//  RESTManager.h
//  taller
//
//  Created by Omar Guzmán on 10/5/15.
//  Copyright © 2015 birghtCoders. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RESTManager : NSObject
+(void)sendData:(NSMutableDictionary *)data toService:(NSString *)service withMethod:(NSString *)method  toCallback:(void (^)(id))callback;
@end
