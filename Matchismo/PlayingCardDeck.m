//
//  PlayingCardDeck.m
//  Matchismo
//
//  Created by Joey Smith on 1/29/13.
//  Copyright (c) 2013 Joey Smith. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"
#import "Deck.h"

@implementation PlayingCardDeck

/// Build the deck of playing cards.
- (id) init {
    
    /// Only case for assigning self to anything
    self = [super init];
    
    if (self) {
        for (NSString *suit in [PlayingCard validSuits]) {
            for (NSUInteger rank = 1; rank <= [PlayingCard maxRank]; rank++) {
                PlayingCard *card = [[PlayingCard alloc] init];
                card.rank = rank;
                card.suit = suit;
                [self addCard:card atTop:YES];
            }
        }
    }
    return self;
}

@end
