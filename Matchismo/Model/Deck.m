//
//  Deck.m
//  Matchismo
//
//  Created by Joey Smith on 1/28/13.
//  Copyright (c) 2013 Joey Smith. All rights reserved.
//

#import "Deck.h"

/// Private properties
@interface Deck()
@property (strong, nonatomic) NSMutableArray *cards;
@end

@implementation Deck

/// Perform lazy instantiation by creating cards array when the getter
/// for cards is called the first time.
- (NSMutableArray *) cards {
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (void)addCard:(Card *)card atTop:(BOOL)atTop {
    /// Prevent putting nil in array
    if (card) {
        if (atTop) {
            [self.cards insertObject:card atIndex:0];
        } else {
            [self.cards addObject:card];
        }
    }
}

- (Card *)drawRandomCard {
    Card *randomCard = nil;
    
    /// Need cards to not be empty.
    /// Accessing an element of an empty array will crash
    if (self.cards.count) {
        /// randomly find a card in the deck and remove it from the array
        /// returning it to the calling method.
        unsigned index = arc4random() % self.cards.count;
        /// new syntax for iOS 6 to use array[index]
        randomCard = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }
    
    return randomCard;
}

@end

