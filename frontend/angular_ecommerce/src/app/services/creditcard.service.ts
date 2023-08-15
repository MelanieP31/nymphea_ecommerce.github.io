import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { of } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class CreditcardService {

  constructor() { }

  //Remplir un tableau de mois (12) mais le rendre observable par d'autre classe (transfo [array number] avec of)
  getCreditCardMonths(startMonth : number) : Observable<number[]>{

    let data : number[] =[];

    for(let theMonth = startMonth; theMonth <= 12; theMonth++){
      data.push(theMonth);
    }
    return of(data);
  }

  getCreditCardYears(): Observable<number[]>{
    let data : number[] = [];

    const startYear : number = new Date().getFullYear();
    const endYear : number = startYear +10;

    for(let theYear = startYear; theYear <= endYear; theYear++){
      data.push(theYear);
    }

    return of (data);


  }
}
