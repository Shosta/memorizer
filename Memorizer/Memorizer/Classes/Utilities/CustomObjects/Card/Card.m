//
//  Card.m
//  Memorizer
//
//  Created by Rémi LAVEDRINE on 14/05/13.
//  Copyright (c) 2013 Rémi Lavedrine. All rights reserved.
//

#import "Card.h"

@implementation Card


#pragma mark - Birth

- (id)init{
  self = [super init];
  if (self) {
    self.grade = -1;
    self.acq_reps = 0; // Le nombre de répétition dans la phase "Apprentissage"
    self.acq_reps_since_lapse = 0; // Le nombre de répétition dans la phase "Apprentissage" depuis un échec.
    self.ret_reps = 0; // Le nombre de répétition dans la phase "Révision"
    self.ret_reps_since_lapse = 0; // Le nombre de répétition dans la phase "Révision" depuis un échec.
    self.new_interval = 0; // L'intervalle de jours ou la carte doit apparaître (en jours)
    self.lapses = 0; // Le nombre d'échecs alors que l'on connaissait auparavant la réponse de la carte.
    self.grade = 0; // Dernière note attribué a la carte.
    self.new_grade = -1; // Nouvelle note attribué a la carte.
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

int DAY = 1;
- (int)addDaysAccordingTo:(MemorizationLevel)aMemorizationLevel{
  int actual_interval = self.new_interval;
  int new_interval = 0;
  
  //  Si c'est une nouvelle carte
  if (self.grade == -1){
    self.easiness = 2.5;
    self.acq_reps = 1;
    self.acq_reps_since_lapse = 1;
    // On appelle une méthode qui va calculer l'intervalle en fonction de la note pour note de 0 ou 1 en fond de paquet, pour un 2 dans 1 jour, pour un 3 dans 3 jours, pour un 4 dans 4 jours, pour un 5 dans 7 jours
    new_interval = [self calculate_initial_interval:self.new_grade];
  }else if ((self.grade == 0 ||  self.grade == 1) && (aMemorizationLevel == 0 || aMemorizationLevel == 1)){// Si l'ancienne note était de 0 ou 1 et la nouvelle de 0 ou 1 on met la carte en fond de paquet (new_interval =0)
    self.acq_reps += 1;
    self.acq_reps_since_lapse += 1;
    new_interval = 0;
  }else if ((self.grade >= 0 && aMemorizationLevel <= 1) && (aMemorizationLevel >= 2 && aMemorizationLevel <= 5)){
    // In the acquisition phase and moving to the retention phase.
    self.acq_reps += 1;
    self.acq_reps_since_lapse += 1;
    switch (aMemorizationLevel) {
      case MemorizationLevel2:
        new_interval = DAY;
        break;
        
      case MemorizationLevel3:
        // L'intervalle est donnée aléatoirement entre 1,1 et 2 jours (le 1 est plus fort que le 2)
        new_interval = DAY; // random.choice([1, 1, 2]) * DAY Faire le Random.
        break;
        
      case MemorizationLevel4:
        new_interval = DAY; // random.choice([1, 2, 2]) * DAY Faire le Random.
        break;
        
      case MemorizationLevel5:
        new_interval = 2 * DAY;
        break;
        
      default:
        break;
    }
  }else if ((self.grade >= 2 && aMemorizationLevel <= 5) && (aMemorizationLevel >= 2 && aMemorizationLevel <= 5)){
    // In the retention phase and staying there.
    self.ret_reps += 1;
    self.ret_reps_since_lapse += 1;
    // Don't update the easiness when learning ahead.
    if ([self.timing isEqualToString:@"LATE"] || [self.timing isEqualToString:@"ON TIME"]){
      switch (aMemorizationLevel) {
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
      
      if (self.easiness < 1.3){
        self.easiness = 1.3;
      }
      if (self.ret_reps_since_lapse == 1){
        new_interval = 6 * DAY;
      }else{
        if (self.new_grade == 2 || self.new_grade == 3) {
          if ([self.timing isEqualToString:@"ON TIME"] || [self.timing isEqualToString:@"EARLY"]){
            new_interval = actual_interval * self.easiness;
          }else{
            // Learning late and interval was too long, so don't increase the interval and use scheduled_interval again as opposed to the much larger actual_interval * card.easiness.
            new_interval = self.scheduled_interval;
            if (self.new_grade == 4){
              new_interval = actual_interval * self.easiness;
            }
            if (self.new_grade == 5){
              if ([self.timing isEqualToString:@"EARLY"]){
                // Learning ahead and interval was too short. To avoid that the intervals increase explosively when learning ahead, take scheduled_interval as opposed to the much larger actual_interval * card.easiness.
                new_interval = self.scheduled_interval;
              }
              else{
                new_interval = actual_interval * self.easiness;
              }
            }
            // Une nouvelle intervalle ne peut pas être en dessous de 1
            if (new_interval < DAY){
              new_interval = DAY;
            }
          }
        }
      }
    }
  }
  
  
  // On ajoute ou retire des jours aléatoirement en fonction quand même de l'intervalle calculé pour je pense ne pas toujours avoir la même série
  new_interval += [self calculate_interval_noise:new_interval];
  
  return new_interval;
}

@end
