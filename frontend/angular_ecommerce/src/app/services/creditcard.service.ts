import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, map } from 'rxjs';
import { of } from 'rxjs';
import { Country } from '../common/country';
import { State } from '../common/state';

@Injectable({
  providedIn: 'root'
})
export class CreditcardService {

  //populate pays et region de notre api
  private countriesUrl = 'http://localhost:8080/api/countries';
  private statesUrl = 'http://localhost:8080/api/states';

  //injecter httpClient pour les RESTCall
  constructor(private httpClient : HttpClient) { }

  getCountries(): Observable<Country[]>{
    return this.httpClient.get<GetResponseCountries>(this.countriesUrl).pipe(
      map(response => response._embedded.countries)
    );
  }

  //Recup les regions mais att spéciale trouver par pays ! 
  getStates(theCountryCode : string): Observable<State[]>{
    //searchUrl
    const searchStatesUrl=`${this.statesUrl}/search/findByCountryCode?code=${theCountryCode}`;

    return this.httpClient.get<GetResponseStates>(searchStatesUrl).pipe(
      map(response => response._embedded.states)
    );
  }




  //Remplir un tableau de mois (12) mais le rendre observable par d'autre classe (transfo [array number] avec of)
  getCreditCardMonths(startMonth : number) : Observable<number[]>{

    let data : number[] =[];

    for(let theMonth = startMonth; theMonth <= 12; theMonth++){
      data.push(theMonth);
    }
    return of(data);
  }
 //Remplir tableau annee actuel + 10ans
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

interface GetResponseCountries {
  _embedded :{
    countries : Country[];
  }
}
interface GetResponseStates {
  _embedded:{
    states:State[];
  }
}
