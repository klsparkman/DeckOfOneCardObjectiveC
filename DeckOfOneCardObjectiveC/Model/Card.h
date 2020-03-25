//
//  Card.h
//  DeckOfOneCardObjectiveC
//
//  Created by Kelsey Sparkman on 3/24/20.
//  Copyright © 2020 Kelsey Sparkman. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Card : NSObject
//Properties
@property (nonatomic, copy, readonly)NSString *suit;
@property (nonatomic, copy, readonly)NSString *imageString;

-(instancetype)initWithSuit: (NSString *)suit imageString:(NSString *)imageString;

-(instancetype)initWithDictionary: (NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
