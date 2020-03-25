//
//  Card.m
//  DeckOfOneCardObjectiveC
//
//  Created by Kelsey Sparkman on 3/24/20.
//  Copyright © 2020 Kelsey Sparkman. All rights reserved.
//

#import "Card.h"
//Magic strings are coding-keys...ish!
static NSString * const kSuitKey = @"suit";
static NSString * const kImageKey = @"image";

@implementation Card
-(instancetype)initWithSuit:(NSString *)suit imageString:(NSString *)imageString
{
    if (self = [super init])
    {
        _suit = suit;
        _imageString = imageString;
    }
    return self;
}

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSString *suit = dictionary[kSuitKey];
    NSString *imageString = dictionary[kImageKey];
    
    return [self initWithSuit:suit imageString:imageString];
}

@end
