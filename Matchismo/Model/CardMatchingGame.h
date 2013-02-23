//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Joey Smith on 2/1/13.
//  Copyright (c) 2013 Joey Smith. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "PlayingCard.h"
#import "Deck.h"

@interface CardMatchingGame : NSObject

// designated initializer
- (id)initWithCardCount:(NSUInteger)count
              usingDeck:(Deck *) deck;

- (void)flipCardAtIndex:(NSUInteger)index;

- (Card *)cardatIndex:(NSUInteger)index;

// Public API has only a getter (readonly)
@property (readonly,nonatomic) int score;
@property (readonly,nonatomic) NSString *resultString;
// Represents the number of other cards to match with
// the selected card.
@property (nonatomic) NSUInteger matchLevel;
@end
