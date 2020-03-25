//
//  CardModelController.h
//  DeckOfOneCardObjectiveC
//
//  Created by Kelsey Sparkman on 3/24/20.
//  Copyright © 2020 Kelsey Sparkman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class Card;

NS_ASSUME_NONNULL_BEGIN

@interface CardModelController : NSObject

+ (void)drawNewCard:(NSNumber *)numberOfCards completion: (void(^) (NSArray<Card *> *_Nullable cards))completion;
+ (void)fetchCardImage:(Card *)card completion: (void(^) (UIImage *_Nullable image))completion;

@end

NS_ASSUME_NONNULL_END
