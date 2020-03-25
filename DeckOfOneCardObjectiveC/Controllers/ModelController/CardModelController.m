//
//  CardModelController.m
//  DeckOfOneCardObjectiveC
//
//  Created by Kelsey Sparkman on 3/24/20.
//  Copyright © 2020 Kelsey Sparkman. All rights reserved.
//

#import "CardModelController.h"
#import "Card.h"

static NSString * const kBaseURLString = @"https://deckofcardsapi.com/api/deck/new/";
static NSString * const kDrawComponent = @"draw/";
static NSString * const kCountQueryName = @"count";
static NSString * const kCardsArray = @"cards";

@implementation CardModelController

//Mark: - Draw New Card Function
+(void)drawNewCard:(NSNumber *)numberOfCards completion:(void (^)(NSArray<Card *> * _Nullable))completion
{
    //Declare our baseURL
    NSURL * baseURL = [NSURL URLWithString:kBaseURLString];
    
    //Append draw component to base URL
    NSURL * drawURL = [baseURL URLByAppendingPathComponent:kDrawComponent];
    
    //Because our cardCount parameter is an integer, we must convert it to a string so that our query item can properly accept it as a parameter
    NSString *cardCount = [numberOfCards stringValue];
    
    //Next we will define our NSURLComonents to add our query item(s) to.
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:drawURL resolvingAgainstBaseURL:true];
    
    //Define our cardCount query item to tell our API via the URL how many cards we are looking to get from our request.
    NSURLQueryItem *queryItem = [NSURLQueryItem queryItemWithName:kCountQueryName value:cardCount];
    
    //Add our query item(s) to our NSURLComponents
    urlComponents.queryItems = @[queryItem];
    
    //Define our finalURL including from our NSURLComponents that inclue our query item(s)
    NSURL *finalURL = urlComponents.URL;
    
    NSLog(@"%@", finalURL);
    
    //Define our dataTask using the serchURL from above.
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        //First we musn handle our error. We pring the localized description and complete with nil & return if error has a value.
        if (error)
        {
            NSLog(@"%@", error.localizedDescription);
            completion(nil);
            return;
        }
        //Next we ensure that we have data and if not, print out an error and complete with nil & return.
        if (!data)
        {
            NSLog(@"Error: no data returned from task");
            completion(nil);
            return;
        }
        //Once we have determined that we have data, we will try to decode that data into a dictionary.  Options: 2 is equivalent to options: allowFragments. &error allows us to use the same pointer in memory as the previous error declaration
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData: data options: 2 error: &error];
        //Next we will ensure that our jsonDictionary is not nil and is indeed an NSDicionary, otherwise print out an error and complete with nil & return.
        if (!jsonDictionary || ![jsonDictionary isKindOfClass:[NSDictionary class]])
        {
            NSLog(@"Unable to create a dictionary from the data");
            completion(nil);
            return;
        }
        
        //Now that we have a dictionary, we can access the array value at the key "cards" - (kCardsArray) is a string value that we have defined in our constants
        NSArray * cardsArray = jsonDictionary[kCardsArray];
        
        //We need a mutable array in order to append card objects to the array of DVMCards we want to complete with.
        NSMutableArray *cardsPlaceholder = [NSMutableArray array];
        
        ///Now that we have a mutable array to hold our card objects, we can loop through our cardsArray and initialize card objects from each dictionary in the array (cardsArray is an array of dictionaries) and append each card to our mutable cardsPlaceholder array
        for (NSDictionary *cardDictionary in cardsArray)
        {
            //Initailize a Card object from the cardDictionary
            Card *card = [[Card alloc] initWithDictionary:cardDictionary];
            [cardsPlaceholder addObject:card];
        }
        completion(cardsPlaceholder);
    }]resume];
}

//Mark: - Fetch Image Function
+(void)fetchCardImage:(Card *)card completion:(void (^)(UIImage * _Nullable))completion
{
    // We must first convert our imageString to an NSURL so that our data task can properly accept it as a parameter (because the api provides a complete URL via this string, we don't need to do any other URL setup for the image fetch)
    NSURL *imageURL = [NSURL URLWithString:card.imageString];
    
    //Define our dataTask using our imageURL
    [[[NSURLSession sharedSession] dataTaskWithURL:imageURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error)
        {
            NSLog(@"%@", error.localizedDescription);
            completion(nil);
            return;
        }
        //Next we ensure that we have data and if not, print out an error and complete with nil & return
        if (!data)
        {
            NSLog(@"Error: no data returned from task");
            completion(nil);
            return;
        }
        
        //Now that we have data, we will initialize a UIImage using that data and complete with that UIImage
        UIImage *cardImage = [UIImage imageWithData:data];
        completion(cardImage);
        //Using resume starts our data task
    }]resume];
}

@end
