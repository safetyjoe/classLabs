//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Joey Smith on 2/1/13.
//  Copyright (c) 2013 Joey Smith. All rights reserved.
//

#import "CardMatchingGame.h"
@interface CardMatchingGame ()

// Private API has ability to set and get. (readwrite)
@property (readwrite,nonatomic) int score;
@property (strong, nonatomic) NSMutableArray *cards;
@end


@implementation CardMatchingGame

- (NSMutableArray *) cards {
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (Card *)cardatIndex:(NSUInteger)index {
    return(index < [self.cards count]) ? self.cards[index] : nil;
}

#define FLIP_COST 1
#define MATCH_BONUS 4
#define MATCH_PENALTY 2

- (void)flipCardAtIndex:(NSUInteger)index {
    Card *card = [self cardatIndex:index];
    
    if(!card.isUnplayable) {
        if(!card.isFaceUp) {
            // Loop thru the other cards finding a faceup palyable one.
            for( Card *otherCard in self.cards ) {
                
                if(otherCard.isFaceUp && !otherCard.isUnplayable) {
                    // match requires an NSArray.  This is a tool to create
                    // an array of objects on the fly with one element.
                    int matchScore = [card match:@[otherCard]];
                    
                    // If it is a match, both cards become unplayable.
                    if(matchScore) {
                        otherCard.unPlayable = YES;
                        card.unPlayable = YES;
                        // scale the successful match.
                        self.score += matchScore * MATCH_BONUS;
                    } else {
                        otherCard.faceUp = NO;
                        // if we select 2 and fail, charge a penalty
                        self.score -= MATCH_PENALTY;
                    }
                }
            }
            // charge a penslty yo yurn the card over.
            self.score -= FLIP_COST;
        }
        card.faceUp = !card.isFaceUp;
    }
}


- (id)initWithCardCount:(NSUInteger)count
              usingDeck:(Deck *) deck{
    self = [super init];
    if (self) {
        for( int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if( card )
                self.cards[i] = card;
            else {
                self = nil;
                break;
            }
        }
    }
    return self;
}


@end
