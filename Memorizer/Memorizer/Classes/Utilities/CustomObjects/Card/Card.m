//
//  Card.m
//  Memorizer
//
//  Created by Rémi LAVEDRINE on 14/05/13.
//  Copyright (c) 2013 Rémi Lavedrine. All rights reserved.
//

#import "Card.h"

@implementation Card


#pragma mark - Helper

- (id)randomElementFromArray:(NSArray *)anArray
{
    id obj;
    @try {
        // http://stackoverflow.com/questions/3318902/picking-a-random-object-in-an-nsarray
        obj = [anArray objectAtIndex:(arc4random() % [anArray count])];
    }
    @catch (NSException *e) {
        obj = nil;
    }
    
    return obj;
}


#pragma mark - Birth

- (id)init{
    self = [super init];
    if (self) {
        self.userLastMemorizationLevel = NoMemorizationLevel; // Dernière note attribué a la carte.
        self.easiness = 0.0;
        self.acq_reps = 0; // Le nombre de répétition dans la phase "Apprentissage"
        self.acq_reps_since_lapse = 0; // Le nombre de répétition dans la phase "Apprentissage" depuis un échec.
        self.ret_reps = 0; // Le nombre de répétition dans la phase "Révision"
        self.ret_reps_since_lapse = 0; // Le nombre de répétition dans la phase "Révision" depuis un échec.
        self.lapses = 0; // Le nombre d'échecs alors que l'on connaissait auparavant la réponse de la carte.
        self.scheduled_interval = 0; // C'est l'intervalle qui prend en compte l'heure à laquelle tu as fait la carte, par exemple si tu as fait la carte après 18h ça te rajoute un jour car si tu lance l'application à 8h tu n'auras pas eu l'intervalle réel à avoir.
        self.timing = @"ON TIME";
    }
    
    return self;
}


#pragma mark - Algo

// TODO
- (int)calculate_initial_interval:(int)grade{
    return 0;
}

// TODO
- (int)calculate_interval_noise:(int)interval{
    return 0;
}

- (int)addDaysToNewCard:(MemorizationLevel)newMemorizationLevel{
    int daysToAdd = 0;
    
    self.easiness = 2.5; // On place la "facilité" de la carte à la moitié (2.5 sur 5, la meilleure note).
    self.acq_reps = 1; // Le nombre de répétitions de la carte est à 1 vu que c'est une nouvelle carte.
    self.acq_reps_since_lapse = 1; // Le nombre de répétitions de la carte depuis le dernier echec est à 1 vu que c'est une nouvelle carte.
    
    // On appelle une méthode qui va calculer l'intervalle en fonction de la note pour note de 0 ou 1 en fond de paquet, pour un 2 dans 1 jour, pour un 3 dans 3 jours, pour un 4 dans 4 jours, pour un 5 dans 7 jours
    daysToAdd = [self calculate_initial_interval:newMemorizationLevel];
    
    return daysToAdd;
}

- (int)addDaysToFailedCard{
    int daysToAdd = 0;
    
    self.acq_reps += 1;
    self.acq_reps_since_lapse += 1;
    daysToAdd = 0; // On met la carte en fond de paquet. Elle doit être revu dans cette session.
    
    return daysToAdd;
}

int DAY = 1;
- (int)addDaysToCardFromAquisitionToRetention:(MemorizationLevel)newMemorizationLevel{
    int daysToAdd = 0;
    
    self.acq_reps += 1;
    self.acq_reps_since_lapse += 1;
    
    switch (newMemorizationLevel) {
        case MemorizationLevel2:
            daysToAdd = DAY;
            break;
            
        case MemorizationLevel3:
            // L'intervalle est donnée aléatoirement entre 1 et 2 jours (le 1 a un poids plus important que le 2)
            daysToAdd = [(NSNumber *)[self randomElementFromArray:@[[NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:2]]] intValue] * DAY;
            break;
            
        case MemorizationLevel4:
            // L'intervalle est donnée aléatoirement entre 1 et 2 jours (le 2 a un poids plus important que le 1)
            daysToAdd = [[self randomElementFromArray:@[[NSNumber numberWithInt:1], [NSNumber numberWithInt:2], [NSNumber numberWithInt:2]]] intValue] * DAY;
            break;
            
        case MemorizationLevel5:
            daysToAdd = 2 * DAY;
            break;
            
        default:
            break;
    }

    return daysToAdd;
}

- (int)addDaysToCardFromRetentionToRetention:(MemorizationLevel)newMemorizationLevel{
    int daysToAdd = 0;
    int actual_interval = self.new_interval;
    
    self.ret_reps += 1;
    self.ret_reps_since_lapse += 1;

    if ([self.timing isEqualToString:@"LATE"] || [self.timing isEqualToString:@"ON TIME"]){
        switch (newMemorizationLevel) {
            case MemorizationLevel2:
                self.easiness -= 0.16;
                break;
                
            case MemorizationLevel3:
                self.easiness -= 0.14;
                break;
                
            case MemorizationLevel5:
                self.easiness += 0.10;
                break;
                
            default:
                break;
    }
        // Easiness can't be less than 1.3.
        if (self.easiness < 1.3){
            self.easiness = 1.3;
        }
        
        if (self.ret_reps_since_lapse == 1){ // Si on a eu un echec dans la phase "Révision", on ajoute 6 jours.
            daysToAdd = 6 * DAY;
        }else{
            switch (self.userLastMemorizationLevel) {
                case MemorizationLevel2:
                    if ([self.timing isEqualToString:@"ON TIME"] || [self.timing isEqualToString:@"EARLY"]){
                        daysToAdd = actual_interval * self.easiness;
                    }else{
                        // Learning late and interval was too long, so don't increase the interval and use scheduled_interval again as opposed to the much larger actual_interval * card.easiness.
                        daysToAdd = self.scheduled_interval;
                    }
                    break;
                    
                case MemorizationLevel3:
                    if ([self.timing isEqualToString:@"ON TIME"] || [self.timing isEqualToString:@"EARLY"]){
                        daysToAdd = actual_interval * self.easiness;
                    }else{
                        // Learning late and interval was too long, so don't increase the interval and use scheduled_interval again as opposed to the much larger actual_interval * card.easiness.
                        daysToAdd = self.scheduled_interval;
                    }
                    break;
                    
                case MemorizationLevel4:
                    daysToAdd = actual_interval * self.easiness;
                    break;
                    
                case MemorizationLevel5:
                    if ([self.timing isEqualToString:@"EARLY"]){
                        // Learning ahead and interval was too short. To avoid that the intervals increase explosively when learning ahead, take scheduled_interval as opposed to the much larger actual_interval * card.easiness.
                        daysToAdd = self.scheduled_interval;
                    }
                    else{
                        daysToAdd = actual_interval * self.easiness;
                    }
                    break;
                    
                default:
                    // Une nouvelle intervalle ne peut pas être en dessous de 1
                    daysToAdd = DAY;
                    break;
            }
        }
    }
    
    // On ajoute ou retire des jours aléatoirement en fonction quand même de l'intervalle calculé pour je pense ne pas toujours avoir la même série
    daysToAdd += [self calculate_interval_noise:newMemorizationLevel];
    
    return daysToAdd;
}

- (int)addDaysAccordingTo:(MemorizationLevel)newMemorizationLevel{
    int daysToAdd = 0;
    
    //  Si c'est une nouvelle carte
    if (self.userLastMemorizationLevel == -1){
        daysToAdd = [self addDaysToNewCard:newMemorizationLevel];
        
    }else if ((self.userLastMemorizationLevel == MemorizationLevel1 ||  self.userLastMemorizationLevel == MemorizationLevel2) &&
              (newMemorizationLevel == MemorizationLevel1 || newMemorizationLevel == MemorizationLevel2)){// Si l'ancienne note était de 0 ou 1 et la nouvelle de 0 ou 1 on met la carte en fond de paquet (new_interval = 0)
        daysToAdd = [self addDaysToFailedCard];
        
    }else if ((self.userLastMemorizationLevel >= NoMemorizationLevel && self.userLastMemorizationLevel <= MemorizationLevel1) &&
              (newMemorizationLevel >= MemorizationLevel2 && newMemorizationLevel <= MemorizationLevel5)){
        // In the acquisition phase and moving to the retention phase.
        [self addDaysToCardFromAquisitionToRetention:newMemorizationLevel];
        
    }else if ((self.userLastMemorizationLevel >= MemorizationLevel2 && self.userLastMemorizationLevel <= MemorizationLevel5) &&
              (newMemorizationLevel >= MemorizationLevel2 && newMemorizationLevel <= MemorizationLevel5)){
        // In the retention phase and staying there.
        [self addDaysToCardFromRetentionToRetention:newMemorizationLevel];
        
    }
    
    // On ajoute ou retire des jours aléatoirement en fonction quand même de l'intervalle calculé pour je pense ne pas toujours avoir la même série
    daysToAdd += [self calculate_interval_noise:daysToAdd];
    
    return daysToAdd;
}

@end
